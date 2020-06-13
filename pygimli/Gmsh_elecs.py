import pandas as pd

### Define all variables ###
filename = 'ERT_pos_and_scheme.xlsx'
# Including elec in geometry surface in Gmsh is complicated (Point{pnt_id} In Surface{surf_id};).
# It gives errors, therefore they are put at some depth below the surface
# and then included in the volume of the dike (Point{pnt_id} In Volume{vol_id};).
elec_depth = 0.02               # elec depth [m]


### Write electrode positions to Gmsh .geo file ###
# Load electrode positions from Excel
pos = pd.read_excel(filename, sheet_name='elec_pos')
pos['z'] = pos['z'] - elec_depth

# Write to Gmsh .geo file
id = int(200)           # Gmsh point ID
gmsh_grid = open('gmsh_elec_pos.geo', 'w')
for i, xyz in pos.iterrows():
    gmsh_grid.write('Point(%d) = {%.3f, %.3f, %.3f, cl_elec};\n'
                    % ((xyz['elec #'] + id), xyz['x'], xyz['y'], xyz['z']))
gmsh_grid.close()
