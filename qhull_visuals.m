(* ::Package:: *)

(* ::Section:: *)
(*Routines*)


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
(*CircCenter[{u1_,u2_,u3_}]:=Module[{c1,c2,c3,v},*)
(*{c1,c2}={-((-1+u1.u2+u1.u3-u2.u3) (-1+u2.u3))/(-3+(u1.u2)^2+2 u1.u3+(u1.u3-u2.u3)^2+2 u2.u3-2 u1.u2 (-1+u1.u3+u2.u3)),((-1+u1.u3) (1-u1.u2+u1.u3-u2.u3))/(-3+(u1.u2)^2+2 u1.u3+(u1.u3-u2.u3)^2+2 u2.u3-2 u1.u2 (-1+u1.u3+u2.u3))};*)
(*c3=1-c1-c2;*)
(*v={c1,c2,c3}.{u1,u2,u3};*)
(*v=v/Sqrt[v.v]]*)


(* ::Input:: *)
(*NextFacet[ptIndex_,OtherPtIndex_,Facets_,currFacetIndex_]:= Module[{nextFacet,nextPtIndex},*)
(*nextFacet=Complement[Position[Facets,OtherPtIndex][[All,1]],{currFacetIndex}][[1]];*)
(*nextPtIndex=Complement[Facets[[nextFacet]],{ptIndex,OtherPtIndex}][[1]];*)
(*{nextFacet,nextPtIndex}]*)


(* ::Input:: *)
(*ClearAll[VorCell]*)
(*VorCell[VFPfile_,ptIndex_]:=Module[{VorVerts,theFacets},*)
(*theFacets=GetFacets[VFPfile][[GetVertFacets[VFPfile][[ptIndex]]]];*)
(*Map[CircCenter,Partition[GetVerts[VFPfile][[Flatten[theFacets]]],3] ]]*)


(* ::Input:: *)
(*VorCelltoTris[verts_,pt_]:={EdgeForm[],Switch[Length[verts],5,RGBColor[0,0,1],6,RGBColor[0,1,0],7,RGBColor[1,0,0],_,White],Triangle[Append[Table[{verts[[k]],verts[[k+1]],pt},{k,1,Length[verts]-1}],{verts[[-1]],verts[[1]],pt}]],{Black,Line[Append[verts,verts[[1]]]]}}*)


(* ::Input:: *)
(*VorCelltoPolygon[verts_,pt_]:={Switch[Length[verts],5,RGBColor[0,0,1],6,RGBColor[0,1,0],7,RGBColor[1,0,0],_,White],Polygon[verts],{Black,Line[Append[verts,verts[[1]]]]}}*)


(* ::Input:: *)
(*VorCells[VFPFiles_]:=Table[VorCell[VFPFiles,k],{k,1,VFPFiles[[1,2]]}]*)
(**)


(* ::Input:: *)
(*Clear[VorGraph]*)
(*VorGraph[VFPFiles_]:=Table[VorCelltoPolygon[VorCell[VFPFiles,k],GetVerts[VFPFiles][[k]]],{k,1,NumVerts[VFPFiles]}];*)
(**)


(* ::Input:: *)
(*Clear[PlotThisFile]*)
(*PlotThisFile[VFPData_]:= Module[{path,VFPFiles},*)
(*VFPFiles=VFP[VFPData];*)
(*Graphics3D[ {Thickness[.000001],PointSize[.003],VorGraph[VFPFiles],Black,Map[Point,1.0001*GetVerts[VFPFiles]]},Boxed->False,ViewPoint->{1.3`,-2.4`,2.`},Axes->True,Boxed->False,AxesStyle->Directive[GrayLevel[0],AbsoluteThickness[1.625`]],AxesLabel->{x,y,z}]*)
(*]*)


(* ::Section:: *)
(*Plotting multiple files*)


(* ::Input:: *)
(*path = NotebookDirectory[];*)
(*allFiles = FileNames["*.out",path];*)


(* ::Input:: *)
(*paths = Table[ allFiles[[i]], {i, Length[allFiles]}];*)
(*ALLFiles= Table[ Import[paths[[i]],"Table"],{i,Length[paths]}];*)
(*(*ALLFiles= Table[ Import[path<>"total"<>ToString[i]<>".txt","Table"],{i,Length[allFiles]}];*)*)
(*ll = Table[PlotThisFile[ALLFiles[[i]]],{i,1,Length[ALLFiles]}];*)


For[i=1,i<= Length[ll],i++,
Export["sphere"<>ToString[i]<>".pdf",ll[[i]],ImageSize->1024]]


(* ::Input:: *)
(*SystemOpen["sphere1.pdf"]*)


(* ::Input:: *)
(*(*Export["30K_2.avi",ll,"FrameRate"->2,ImageSize->1024];*)*)


(* ::Input:: *)
(*(*energy=Drop[Import[ParentDirectory[NotebookDirectory[]]<>"/epsFile.txt","Table"][[All,5]],1];*)*)
(*(*ListPlot[Drop[energy,50],PlotRange->All]*)*)
(*(*Timing[PlotThisFile[ALLFiles[[-1]]]]*)*)
(*(*Graphics3D[{PointSize\[Rule].001,Map[Point,1.003*GetVerts[VFP[ALLFiles[[3]]]]]}]*)*)


(* ::Text:: *)
(**)


(* ::Section:: *)
(*Charge motion dynamics (to visualize e.g. gradient descent)*)


ClearAll[plotTest]
plotTest[file_]:= Module[{},
Graphics3D[{(*Sphere[{0,0,0},.99],Red,*)Map[Sphere[#,.02]&,file],},Lighting->"Neutral",Axes->True,Boxed->False,AxesStyle->Directive[GrayLevel[0],AbsoluteThickness[1.625`]], 
AxesLabel->{x,y,z},ViewPoint->{1.3, -2.4, 2.}]
]


ClearAll[plott]
plott[file_]:=Module[{},
Graphics3D[{Sphere[{0,0,0},.99],Table[{RGBColor[i/Length[file],1-i/Length[file],0],Sphere[file[[i]], .06 ]},{i,Length[file]}]
},Lighting->"Neutral",Axes->True,Boxed->False,AxesStyle->Directive[GrayLevel[0],AbsoluteThickness[1.625`]], 
AxesLabel->{x,y,z},ViewPoint->{1.3, -2.4, 2.}]
]

cookies = Table[plott[GetVerts[VFP[ALLFiles[[i]] ]]  ],{i,Length[ALLFiles]} ];


ListAnimate[cookies]



(* ::Text:: *)
(**)


(* ::Section:: *)
(*Statistics of the areas of faces of the Voronoi diagram*)


(* ::Input:: *)
(*VFPFiles=VFP[ALLFiles[[-1]]];*)
(*vor = VorGraph[VFPFiles];*)
(*areas=Map[Area[vor[[#,2]]]&,Range[NumVerts[VFPFiles]]];*)
(*pens=Extract[VorCells[VFPFiles],Position[Length/@VorCells[VFPFiles],5]];*)
(*hexs=Extract[VorCells[VFPFiles],Position[Length/@VorCells[VFPFiles],6]];*)
(*heps=Extract[VorCells[VFPFiles],Position[Length/@VorCells[VFPFiles],7]];*)


(* ::Input:: *)
(*meanArea=Mean[areas]*)
(*varianceArea=Variance[areas]*)


(* ::Input:: *)
(*{numPen=Length[pens],numHex=Length[hexs],numHep=Length[heps]}*)


(* ::Input:: *)
(*penArea=Map[Area[Polygon[pens[[#]]]]&,Range[Length[pens]]];*)
(*hexArea=Map[Area[Polygon[hexs[[#]]]]&,Range[Length[hexs]]];*)
(*hepArea=Map[Area[Polygon[heps[[#]]]]&,Range[Length[heps]]];*)


(* ::Input:: *)
(*{meanPenArea=Mean[penArea],meanHexArea=Mean[hexArea],meanHepArea=Mean[hepArea]}*)


(* ::Input:: *)
(*Histogram[{hexArea,penArea,hepArea},50]*)


(* ::Input:: *)
(*Histogram[{penArea, hepArea},50]*)
