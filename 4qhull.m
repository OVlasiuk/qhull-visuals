(* ::Package:: *)

(* ::Section:: *)
(*Routines 4 d*)


(* ::Input:: *)
(*VFP[VFPdata_]:=Module[{VFstart,VFend, Vstart, Vend, Fstart, Fend,numPts,numFacets,dim, VertFacets,Verts,Facets,numNN},*)
(*numPts=VFPdata[[1,1]];*)
(*VFstart=2;VFend=numPts+1;*)
(*dim=VFPdata[[VFend+1,1]];*)
(*VertFacets= Map[Drop[#,1]+1&,VFPdata[[VFstart;;VFend]]];*)
(*numNN= Map[ #[[1]]&,VFPdata[[VFstart;;VFend]]];*)
(*Vstart=VFend+3;*)
(* Vend=Vstart+numPts-1;*)
(*numFacets=VFPdata[[Vend+1,1]];*)
(*Verts=VFPdata[[Vstart;;Vend]];*)
(*Fstart=Vend+2;*)
(*Fend=Fstart+VFPdata[[Vend+1,1]]-1;*)
(*Facets=Map[Drop[#,1]+1&,VFPdata[[Fstart;;Fend]]];*)
(*{{dim, numPts,numFacets},numNN,VertFacets,Verts,Facets}];*)
(**)


(* ::Input:: *)
(*GetVertFacets[VFPfile_]:=VFPfile[[3]]*)
(*GetVerts[VFPfile_]:=VFPfile[[4]]*)
(*GetFacets[VFPfile_]:=VFPfile[[5]]*)
(*GetnumNN[VFPfile_]:=VFPfile[[2]]*)
(*NumVerts[VFPfile_]:= Length[VFPfile[[4]]]*)
(**)


(* ::Input:: *)
(*ClearAll[CircCenter4];*)
(*CircCenter4[{x1_,x2_,x3_,x4_}]:=Block[{normal},*)
(*normal = NullSpace[{x2-x1,x3-x1,x4-x1}][[1]];*)
(*LinearSolve[{x2-x1,x3-x1,x4-x1,normal},*)
(*{(x2-x1).(x1+x2)/2,*)
(*(x3-x1).(x1+x3)/2,*)
(*(x4-x1).(x1+x4)/2,*)
(*x1.normal}]*)
(*]*)


(* ::Input:: *)
(*VorCell4[VFPfile_,ptIndex_]:=Module[*)
(*{VorVerts,theFacets},*)
(*theFacets=GetFacets[VFPfile][[GetVertFacets[VFPfile][[ptIndex]]]];*)
(*Map[CircCenter4,Partition[GetVerts[VFPfile][[Flatten[theFacets]]],4] ]*)
(*]*)


projectTangentPlane[TangentPoint_, ProjectedPoint_]:= 
ProjectedPoint+(1-ProjectedPoint.TangentPoint)TangentPoint;


(* ::Input:: *)
(*VorCell4Flat[VFPfile_,ptIndex_]:= Module[*)
(*{FlatCoords,VorVerts,theFacets,thePoint,TangentPlane,VorCell4Points},*)
(*thePoint = GetVerts[VFPfile][[ptIndex]];*)
(*theFacets=GetFacets[VFPfile][[GetVertFacets[VFPfile][[ptIndex]]]];*)
(*VorCell4Points = Map[CircCenter4,Partition[GetVerts[VFPfile][[Flatten[theFacets]]],4] ];*)
(*TangentPlane = NullSpace[{thePoint}];*)
(*FlatCoords =Map[LeastSquares[Transpose[TangentPlane],projectTangentPlane[thePoint,#]-thePoint]&,VorCell4Points]*)
(*]*)


ClearAll[plotTest]
plotTest[file_]:= Module[{},
Graphics3D[{(*Sphere[{0,0,0},.99],*)Red,Map[Sphere[#,.02]&,file],},Lighting->"Neutral",Axes->True,Boxed->False,AxesStyle->Directive[GrayLevel[0],AbsoluteThickness[1.625`]], 
AxesLabel->{x,y,z},ViewPoint->{1.3, -2.4, 2.}]
]


(* ::Section:: *)
(*Plotting multiple files*)


(* ::Input:: *)
(*NotebookDirectory[]*)
(* path = StringJoin[ ParentDirectory[NotebookDirectory[]],"/qhull120pts4d/"]; allFiles = FileNames["*.out",path];*)


paths


(* ::InheritFromParent:: *)
(*paths*)


(* ::Input:: *)
(*paths = Table[ allFiles[[i]], {i, Length[allFiles]}];*)
(*ALLFiles= Table[ Import[paths[[i]],"Table"],{i,Length[paths]}];*)


(* ::Input:: *)
(*ALLVFP = Map[VFP,ALLFiles];*)


(* ::Input:: *)
(*Position[GetnumNN[ALLVFP[[-1]]],24]*)


(* ::Input:: *)
(*Histogram[GetnumNN[ALLVFP[[-1]]],10]*)


(* ::Input:: *)
(*VorCell4[ALLVFP[[-1]],21]*)


(* ::Input:: *)
(*GetVerts[ALLVFP[[-1]]][[21]]*)


(*VorCell4Flat[ALLVFP[[-1]],21]*)


(*VorCell4Flat[ALLVFP[[-1]],21]*)


(*Table[plotTest[VorCell4Flat[ALLVFP[[-1]],i]],{i,Length[GetVerts[ALLVFP[[-1]]]]}]*)


(*plotTest[VorCell4Flat[ALLVFP[[1]],1]]*)

ConvexHullMesh[VorCell4Flat[ALLVFP[[1]],1]]

