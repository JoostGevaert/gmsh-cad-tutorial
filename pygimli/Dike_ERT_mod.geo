// Gmsh project created on Wed Nov 13 by Joost Gevaert
// This is the ERT modeling mesh, Gmsh script, 
// for the FreeCAD -> Gmsh -> pyGIMLi workflow example

SetFactory("OpenCASCADE");
Merge "Dike_ERT_mod.brep";      // Import FreeCAD geometry
// Alternatively: var() = ShapeFromFile("Dike_ERT_mod.brep");
// Allows you to assign a variable name to the imported volume (see demos: fillet2.geo & import.geo)

Geometry.OCCScaling = 0.001;    // Scale geometry from [mm] to [m]
// Calling: Geometry.OCCTargetUnit = "M"; before the import changes units to [m]
// But for some reason this does not work for me...

// Set characteristic lengths
cl_elec = 0.1;  cl_dike = 0.6;  cl_outer = 30;
// Volume 1: sand channel, Volume 2: outer region, Volume 3: inner region
Characteristic Length { PointsOf{ Volume{2}; } } = cl_outer;
Characteristic Length { PointsOf{ Volume{3}; } } = cl_dike;
Characteristic Length { PointsOf{ Volume{1}; } } = cl_dike;

// Add electrodes to the mesh
Point(201) = {8.500, 0.600, -0.020, cl_elec};
Point(202) = {9.000, 1.076, 0.134, cl_elec};
Point(203) = {8.500, 1.551, 0.288, cl_elec};
Point(204) = {9.000, 2.027, 0.443, cl_elec};
Point(205) = {8.500, 2.503, 0.597, cl_elec};
Point(206) = {9.000, 2.978, 0.751, cl_elec};
Point(207) = {8.500, 3.454, 0.905, cl_elec};
Point(208) = {9.000, 3.929, 1.059, cl_elec};
Point(209) = {8.500, 4.405, 1.213, cl_elec};
Point(210) = {9.000, 4.881, 1.367, cl_elec};
Point(211) = {8.500, 5.356, 1.522, cl_elec};
Point(212) = {9.000, 5.832, 1.676, cl_elec};
Point(213) = {8.500, 6.308, 1.830, cl_elec};
Point(214) = {9.000, 6.808, 1.830, cl_elec};
Point(215) = {8.500, 7.308, 1.830, cl_elec};
Point(216) = {8.500, 7.763, 1.624, cl_elec};
Point(217) = {8.500, 8.219, 1.419, cl_elec};
Point(218) = {8.500, 8.675, 1.213, cl_elec};
Point(219) = {8.500, 9.131, 1.008, cl_elec};
Point(220) = {8.500, 9.587, 0.802, cl_elec};
Point(221) = {8.500, 10.042, 0.597, cl_elec};
Point(222) = {8.500, 10.498, 0.391, cl_elec};
Point(223) = {8.500, 10.954, 0.186, cl_elec};
Point(224) = {9.500, 0.600, -0.020, cl_elec};
Point(225) = {10.000, 1.076, 0.134, cl_elec};
Point(226) = {9.500, 1.551, 0.288, cl_elec};
Point(227) = {10.000, 2.027, 0.443, cl_elec};
Point(228) = {9.500, 2.503, 0.597, cl_elec};
Point(229) = {10.000, 2.978, 0.751, cl_elec};
Point(230) = {9.500, 3.454, 0.905, cl_elec};
Point(231) = {10.000, 3.929, 1.059, cl_elec};
Point(232) = {9.500, 4.405, 1.213, cl_elec};
Point(233) = {10.000, 4.881, 1.367, cl_elec};
Point(234) = {9.500, 5.356, 1.522, cl_elec};
Point(235) = {10.000, 5.832, 1.676, cl_elec};
Point(236) = {9.500, 6.308, 1.830, cl_elec};
Point(237) = {10.000, 6.808, 1.830, cl_elec};
Point(238) = {9.500, 7.308, 1.830, cl_elec};
Point(239) = {9.500, 7.763, 1.624, cl_elec};
Point(240) = {9.500, 8.219, 1.419, cl_elec};
Point(241) = {9.500, 8.675, 1.213, cl_elec};
Point(242) = {9.500, 9.131, 1.008, cl_elec};
Point(243) = {9.500, 9.587, 0.802, cl_elec};
Point(244) = {9.500, 10.042, 0.597, cl_elec};
Point(245) = {9.500, 10.498, 0.391, cl_elec};
Point(246) = {9.500, 10.954, 0.186, cl_elec};
Point(247) = {10.500, 2.503, 0.597, cl_elec};
Point(248) = {11.000, 2.978, 0.751, cl_elec};
Point(249) = {10.500, 3.454, 0.905, cl_elec};
Point(250) = {11.000, 3.929, 1.059, cl_elec};
Point(251) = {10.500, 4.405, 1.213, cl_elec};
Point(252) = {11.000, 4.881, 1.367, cl_elec};
Point(253) = {10.500, 5.356, 1.522, cl_elec};
Point(254) = {11.000, 5.832, 1.676, cl_elec};
Point(255) = {10.500, 6.308, 1.830, cl_elec};
Point(256) = {11.000, 6.808, 1.830, cl_elec};
Point(257) = {10.500, 7.308, 1.830, cl_elec};
Point(258) = {10.500, 7.763, 1.624, cl_elec};
Point(259) = {10.500, 8.219, 1.419, cl_elec};
Point(260) = {10.500, 8.675, 1.213, cl_elec};
Point(261) = {10.500, 9.131, 1.008, cl_elec};
Point(262) = {10.500, 9.587, 0.802, cl_elec};
Point(263) = {10.500, 10.042, 0.597, cl_elec};
Point(264) = {10.500, 10.498, 0.391, cl_elec};
Point(265) = {10.500, 10.954, 0.186, cl_elec};
Point(266) = {11.500, 2.503, 0.597, cl_elec};
Point(267) = {11.500, 2.978, 0.751, cl_elec};
Point(268) = {11.500, 3.454, 0.905, cl_elec};
Point(269) = {11.500, 3.929, 1.059, cl_elec};
Point(270) = {11.500, 4.405, 1.213, cl_elec};
Point(271) = {11.500, 4.881, 1.367, cl_elec};
Point(272) = {11.500, 5.356, 1.522, cl_elec};
Point(273) = {11.500, 5.832, 1.676, cl_elec};
Point(274) = {11.500, 6.308, 1.830, cl_elec};
Point(275) = {11.500, 6.808, 1.830, cl_elec};
Point(276) = {11.500, 7.308, 1.830, cl_elec};
Point(277) = {11.500, 7.763, 1.624, cl_elec};
Point(278) = {11.500, 8.219, 1.419, cl_elec};
Point(279) = {11.500, 8.675, 1.213, cl_elec};
Point(280) = {11.500, 9.131, 1.008, cl_elec};
Point(281) = {11.500, 9.587, 0.802, cl_elec};
Point(282) = {11.500, 10.042, 0.597, cl_elec};
Point(283) = {11.500, 10.498, 0.391, cl_elec};
Point(284) = {12.500, 0.600, -0.020, cl_elec};
Point(285) = {12.500, 1.076, 0.134, cl_elec};
Point(286) = {12.500, 1.551, 0.288, cl_elec};
Point(287) = {12.500, 2.027, 0.443, cl_elec};
Point(288) = {12.500, 2.503, 0.597, cl_elec};
Point(289) = {12.000, 2.978, 0.751, cl_elec};
Point(290) = {12.500, 3.454, 0.905, cl_elec};
Point(291) = {12.000, 3.929, 1.059, cl_elec};
Point(292) = {12.500, 4.405, 1.213, cl_elec};
Point(293) = {12.000, 4.881, 1.367, cl_elec};
Point(294) = {12.500, 5.356, 1.522, cl_elec};
Point(295) = {12.000, 5.832, 1.676, cl_elec};
Point(296) = {12.500, 6.308, 1.830, cl_elec};
Point(297) = {12.000, 6.808, 1.830, cl_elec};
Point(298) = {12.500, 7.308, 1.830, cl_elec};
Point(299) = {12.500, 7.763, 1.624, cl_elec};
Point(300) = {12.500, 8.219, 1.419, cl_elec};
Point(301) = {12.500, 8.675, 1.213, cl_elec};
Point(302) = {12.500, 9.131, 1.008, cl_elec};
Point(303) = {12.500, 9.587, 0.802, cl_elec};
Point(304) = {12.500, 10.042, 0.597, cl_elec};
Point(305) = {12.500, 10.498, 0.391, cl_elec};
Point(306) = {12.500, 10.954, 0.186, cl_elec};
Point(307) = {13.500, 0.600, -0.020, cl_elec};
Point(308) = {13.000, 1.076, 0.134, cl_elec};
Point(309) = {13.500, 1.551, 0.288, cl_elec};
Point(310) = {13.000, 2.027, 0.443, cl_elec};
Point(311) = {13.500, 2.503, 0.597, cl_elec};
Point(312) = {13.000, 2.978, 0.751, cl_elec};
Point(313) = {13.500, 3.454, 0.905, cl_elec};
Point(314) = {13.000, 3.929, 1.059, cl_elec};
Point(315) = {13.500, 4.405, 1.213, cl_elec};
Point(316) = {13.000, 4.881, 1.367, cl_elec};
Point(317) = {13.500, 5.356, 1.522, cl_elec};
Point(318) = {13.000, 5.832, 1.676, cl_elec};
Point(319) = {13.500, 6.308, 1.830, cl_elec};
Point(320) = {13.000, 6.808, 1.830, cl_elec};
Point(321) = {13.500, 7.308, 1.830, cl_elec};
Point(322) = {13.500, 7.763, 1.624, cl_elec};
Point(323) = {13.500, 8.219, 1.419, cl_elec};
Point(324) = {13.500, 8.675, 1.213, cl_elec};
Point(325) = {13.500, 9.131, 1.008, cl_elec};
Point(326) = {13.500, 9.587, 0.802, cl_elec};
Point(327) = {13.500, 10.042, 0.597, cl_elec};
Point(328) = {13.500, 10.498, 0.391, cl_elec};
Point(329) = {13.500, 10.954, 0.186, cl_elec};
Point(330) = {14.500, 0.600, -0.020, cl_elec};
Point(331) = {14.000, 1.076, 0.134, cl_elec};
Point(332) = {14.500, 1.551, 0.288, cl_elec};
Point(333) = {14.000, 2.027, 0.443, cl_elec};
Point(334) = {14.500, 2.503, 0.597, cl_elec};
Point(335) = {14.000, 2.978, 0.751, cl_elec};
Point(336) = {14.500, 3.454, 0.905, cl_elec};
Point(337) = {14.000, 3.929, 1.059, cl_elec};
Point(338) = {14.500, 4.405, 1.213, cl_elec};
Point(339) = {14.000, 4.881, 1.367, cl_elec};
Point(340) = {14.500, 5.356, 1.522, cl_elec};
Point(341) = {14.000, 5.832, 1.676, cl_elec};
Point(342) = {14.500, 6.308, 1.830, cl_elec};
Point(343) = {14.000, 6.808, 1.830, cl_elec};
Point(344) = {14.500, 7.308, 1.830, cl_elec};
Point(345) = {14.500, 7.763, 1.624, cl_elec};
Point(346) = {14.500, 8.219, 1.419, cl_elec};
Point(347) = {14.500, 8.675, 1.213, cl_elec};
Point(348) = {14.500, 9.131, 1.008, cl_elec};
Point(349) = {14.500, 9.587, 0.802, cl_elec};
Point(350) = {14.500, 10.042, 0.597, cl_elec};
Point(351) = {14.500, 10.498, 0.391, cl_elec};
Point(352) = {14.500, 10.954, 0.186, cl_elec};

// Include electrodes in the correct geometric volume
Point{201:352} In Volume{1};

// Define a background field that further refines mesh size.
// LcMax -                       /------------------
//                             /
//                           /
// LcMin -o----------------/
//        |                |      |
//      Point           DistMin DistMax
Field[1] = Distance;        Field[1].NodesList = {201:352};
Field[2] = Threshold;       Field[2].IField = 1;
Field[2].LcMin = cl_elec;   Field[2].LcMax = cl_dike;
Field[2].DistMin = 0.2;     Field[2].DistMax = 1.5;
Field[2].Sigmoid = 0;       Field[2].StopAtDistMax = 1;
Background Field = 2;

// The BERT user tutorial specifies that the following physical group naming conventions have to be used, such that BERT automatically recognizes regions, boundaries and electrodes appropriately:
// Boundaries
Physical Surface(1) = {13, 12, 7, 9, 11, 21, 23, 24, 27, 25, 26, 28, 29}; // Free Surface
Physical Surface(2) = {14, 20, 15, 8, 16}; // Mixed Boundary Conditions: V = 0
// Regions
Physical Volume(1) = {2}; // Outer region
Physical Volume(2) = {3}; // Dike body
Physical Volume(3) = {1}; // Sand Channel
// Electrodes
Physical Point(99) = {201:352};


