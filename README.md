# qhull-visuals
Mathematica routine to process qhull output. Designed for the output of the gradient descent method applied to Riesz energy, as in [this repository](https://github.com/OVlasiuk/RieszEnergyOptimization).

Written with Douglas Hardin and [Ziqi Young](https://github.com/kenyangzq).

Usage:

- place the files with point coordinates and control.inp in the repository folder
- run qhull_all.sh
- open and run qhull_visuals.m in Mathematica

Output:

.pdf files containing the spherical Voronoi diagrams of the original
configuration, one figure per one input file. Hexagons are colored green,
pentagons blue, heptagons red.
