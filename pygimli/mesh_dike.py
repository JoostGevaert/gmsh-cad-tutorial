from pathlib import Path
import pandas as pd
import gmsh
import pygimli as pg
import pygimli.meshtools as mt
from pygimli.physics.ert import ERTManager

# Path to directory with geometry and ERT experiment design
path = Path.cwd()

# Starting it up (tutorial t1.py)
gmsh.initialize()
gmsh.option.setNumber("General.Terminal", 1)
gmsh.option.setString("Geometry.OCCTargetUnit", "M")    # Units to meters (t20.py)
gmsh.model.add("Dike for Modeling")
# Set characteristic lengths, controls mesh size at points
cl_elec = 0.1
cl_dike = 0.6
cl_outer = 30

# Volumes (3), Surfaces (2), Curve (1), Point (0)
# Load a BREP or STEP file (t20.py & demo step_assembly.py)
# geom = gmsh.model.occ.importShapes(str(path.joinpath("dike_mod.step")))
# gmsh.model.occ.healShapes()
# gmsh.model.occ.synchronize()
gmsh.option.setNumber("Geometry.OCCScaling", 0.001)
geom = gmsh.model.occ.importShapes(str(path.joinpath("dike_mod.brep")))


# Read electrode positions from Excel. Electrodes are put at 2 cm depth, 
# such that they can be embeded in the volume of the dike. Embeding the
# electrodes into the surface elements is complicated.
elec_depth = 0.02               # elec depth [m]
pos = pd.read_excel(
    path.joinpath("ERT_pos_and_scheme.xlsx"), 
    sheet_name="elec_pos")
pos["z"] = pos["z"] - elec_depth
ne = len(pos)                   # Number of electrodes
# Gmsh geometry tags of relevant parts. Find the tags in the Gmsh interface.
tags = {"outer region": 2,
    "dike": 3,
    "channel": 1,
    "surface": [7, 11, 12, 13, 21, 23, 24, 
                25, 27, 29, 30, 31],
    "boundary": [8, 14, 15, 16, 20],            # "Underground"
    "electrodes": [0] * ne}
# Add the electrodes to the Gmsh model and put the tags into the Dict
for i, xyz in pos.iterrows():
    tag = int(200 + xyz["elec #"])
    gmsh.model.occ.addPoint(xyz["x"], 
        xyz["y"], 
        xyz["z"], 
        cl_elec, 
        tag)
    tags["electrodes"][i] = tag

# Syncronize CAD representation with the Gmsh model (t1.py)
# Otherwise gmsh.model.get* methods don't work.
gmsh.model.occ.synchronize()

# Set mesh sizes for the dike and outer region.
# I think that the order, in which mesh sizes are set, matters. Big -> Small 
gmsh.model.mesh.setSize(            # Especially t16.py, also t2; 15; 18; 21
    gmsh.model.getBoundary(         # get dimTags of boundary elements of
        (3, tags["outer region"]),  # dimTag: (dim, tag)
        recursive=True),            # recursive -> dimTags of points
    cl_outer)
gmsh.model.mesh.setSize(
    gmsh.model.getBoundary(
        (3, tags["dike"]),
        # (3, tags["channel"]),
        recursive=True),
    cl_dike)

# Embed electrodes in dike volume. (t15.py)
gmsh.model.mesh.embed(0, tags["electrodes"], 3, tags["dike"])

# Further refine the mesh with a background field (t10.py)
# LcMax -                         /------------------
#                               /
#                             /
#                           /
# LcMin -o----------------/
#        |                |       |
#      Point           DistMin DistMax
# Field 1: Distance to electrodes
gmsh.model.mesh.field.add("Distance", 1)
gmsh.model.mesh.field.setNumbers(1, "NodesList", tags["electrodes"])
# Field 2: Threshold that dictates the mesh size of the background field
gmsh.model.mesh.field.add("Threshold", 2)
gmsh.model.mesh.field.setNumber(2, "IField", 1)
gmsh.model.mesh.field.setNumber(2, "LcMin", cl_elec)
gmsh.model.mesh.field.setNumber(2, "LcMax", cl_dike)
gmsh.model.mesh.field.setNumber(2, "DistMin", 0.2)
gmsh.model.mesh.field.setNumber(2, "DistMax", 1.5)
gmsh.model.mesh.field.setNumber(2, "StopAtDistMax", 1)
gmsh.model.mesh.field.setAsBackgroundMesh(2)


# Specify physical groups (t1.py)
# The physical group tags are imported to PyGIMLi (right?)
# Physical Volumes, "Regions" in pyGIMLi
pgrp = gmsh.model.addPhysicalGroup(3, [tags["outer region"]], 1)  #(dim, tag, pgrp tag)
gmsh.model.setPhysicalName(3, pgrp, "Outer Region")     # Physical group name in Gmsh
pgrp = gmsh.model.addPhysicalGroup(3, [tags["dike"]], 2)
gmsh.model.setPhysicalName(3, pgrp, "Dike")
pgrp = gmsh.model.addPhysicalGroup(3, [tags["channel"]], 3)
gmsh.model.setPhysicalName(3, pgrp, "Channel")
# Physical Surfaces, "Boundaries" in pyGIMLi,
# pgrp tag = 1 --> Free Surface | pgrp tag > 1 --> Mixed BC
pgrp = gmsh.model.addPhysicalGroup(2, tags["surface"], 1)
gmsh.model.setPhysicalName(2, pgrp, "Surface")
pgrp = gmsh.model.addPhysicalGroup(2, tags["boundary"], 2)
gmsh.model.setPhysicalName(2, pgrp, "Underground Boundary")
# Physical Points, "Electrodes / Sensors" in pyGIMLi, pgrp tag 99
pgrp = gmsh.model.addPhysicalGroup(0, tags["electrodes"], 99)
gmsh.model.setPhysicalName(0, pgrp, "Electrodes")

# Generate mesh
gmsh.model.mesh.generate(3)
gmsh.write(str(path.joinpath("dike_mod.msh")))

# Run the Gmsh application to verify that importing the geometry went correctly.
# gmsh.fltk.run()
gmsh.finalize()



# Write to BERT/pyGIMLi unified data format .dat file. This file tells PyGIMLi 
# what measurement scheme should be used in modeling and inversion.
scheme = pd.read_excel(
    path.joinpath("ERT_pos_and_scheme.xlsx"), 
    sheet_name="ERT_scheme")

ert_dat = open('ert.dat', 'w')
ert_dat.write(f'{ne}\n' + '# x y z\n')
for i, xyz in pos.iterrows():
    ert_dat.write('%.3f %.3f %.3f\n' % (xyz['x'], xyz['y'], xyz['z']))
ert_dat.write(f'{scheme.shape[0]}\n')
ert_dat.write('# a b m n\n')
for i, abmn in scheme.iterrows():
    ert_dat.write('%d %d %d %d\n' % (abmn['A'], abmn['B'], abmn['M'], abmn['N']))
ert_dat.write('0')
ert_dat.close()


### Read Gmsh .msh and model ERT ####
mesh_mod = mt.readGmsh(str(path.joinpath("dike_mod.msh")))
# Read electrode positions and ERT scheme from .dat file
ert_dat = pg.importData('ert.dat')
# Initiate PyGIMLi ERTManager object
ert = ERTManager()
# Model ERT
rhomap = [[1, 10.], [2, 10.], [3, 300.]]
data_mod = ert.simulate(mesh_mod, res=rhomap, scheme=ert_dat)
data_mod.save('ert_mod.dat')