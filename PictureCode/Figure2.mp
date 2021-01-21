verbatimtex
%&latex
\documentclass{article}
\usepackage{amsfonts}
\usepackage{bm}
\usepackage{amsmath}
\begin{document}
etex

prologues:=3;
filenametemplate "%j-%c.eps";
u=1mm;

def dp(expr x, s, c) =
	fill fullcircle scaled s shifted x withcolor c;
	draw fullcircle scaled s shifted x withcolor black;
enddef;

vardef COL(expr r, g, b) = ((r/255)*red + (g/255)*green + (b/255)*blue) enddef;

beginfig(1);

pickup pencircle scaled 1.05;

numeric r, L;
r := 5u;
L := 20u;

pair p[];
p[2] := (0, 0);
p[1] := p[2] + L*dir(90);
p[3] := p[1] + L*dir(0);
p[4] := p[2] + L*dir(0);
p[5] := p[4] + L*dir(30);
p[6] := p[5] + L*dir(0);
p[7] := p[6] + whatever*dir(45) = p[1] + whatever*dir(0);
p[8] := p[6] + L*dir(0);
p[9] := p[6] + whatever*dir(-45) = p[2] + whatever*dir(0);

draw p[1]--p[2]--p[4]--p[3]--cycle;
draw p[4]--p[5]--p[6]--p[7];
draw p[3]--p[5];
draw p[6]--p[8];
draw p[6]--p[9];

color cc[];
cc[1] := COL(237, 255, 33);
cc[2] := COL(244, 169, 0);
cc[3] := COL(255, 35, 1);
cc[4] := COL(250, 244, 227);
cc[5] := COL(189, 236, 182);

dp(p[1], r, cc[1]);
dp(p[2], r, cc[1]);
dp(p[3], r, cc[2]);
dp(p[4], r, cc[2]);
dp(p[5], r, cc[3]);
dp(p[6], r, cc[4]);
dp(p[7], r, cc[5]);
dp(p[8], r, cc[5]);
dp(p[9], r, cc[5]);

label(btex $\bm{1}$ etex, p[1]);
label(btex $\bm{2}$ etex, p[2]);
label(btex $\bm{3}$ etex, p[3]);
label(btex $\bm{4}$ etex, p[4]);
label(btex $\bm{5}$ etex, p[5]);
label(btex $\bm{6}$ etex, p[6]);
label(btex $\bm{7}$ etex, p[7]);
label(btex $\bm{8}$ etex, p[8]);
label(btex $\bm{9}$ etex, p[9]);

endfig;

end;
