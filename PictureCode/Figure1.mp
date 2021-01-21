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

pickup pencircle scaled 1.2;

numeric r, L;
r := 10u;
L := 80u;

pair p[];
pair jd[];
numeric cs;
cs := -22.5;
p[9] = L*dir(cs);
p[8] = L*dir(cs+22.5);
p[7] = L*dir(cs+22.5+45);
p[3] = L*dir(90);
p[4] = L*dir(90+45);
p[1] = L*dir(90+45+22.5);
p[10] = L*dir(180);
p[5] = L*dir(180+45);
p[2] = L*dir(-90);
p[6] = L*dir(-45);
jd[1] := whatever[p[3], p[5]] = whatever[p[4], p[8]];
jd[2] := whatever[p[3], p[5]] = whatever[p[10], p[8]];
jd[3] := whatever[p[4], p[5]] = whatever[p[10], p[8]];
jd[4] := p[4];
p[1] := 1/4(jd[1]+jd[2]+jd[3]+jd[4]);
p[9] := -p[1];

color cl;
cl := 0.4white;

draw p[2]--p[5];
draw p[5]--p[6];
draw p[2]--p[9] withcolor cl dashed evenly;
draw p[6]--p[7];
draw p[3]--p[5];
draw p[1]--p[2] withcolor cl dashed evenly;
draw p[6]--p[10];
draw p[4]--p[5];
draw p[4]--p[10];
draw p[1]--p[8] withcolor cl dashed evenly;
draw p[7]--p[9] withcolor cl dashed evenly;
draw p[4]--p[7];
draw p[8]--p[10];
draw p[1]--p[10] withcolor cl dashed evenly;
draw p[2]--p[7];
draw p[4]--p[8];
draw p[7]--p[8];
draw p[1]--p[5] withcolor cl dashed evenly;
draw p[1]--p[3] withcolor cl dashed evenly;
draw p[3]--p[7];
draw p[9]--p[10] withcolor cl dashed evenly;
draw p[5]--p[10];
draw p[8]--p[9] withcolor cl dashed evenly;
draw p[2]--p[3];
draw p[6]--p[8];
draw p[3]--p[4];
draw p[1]--p[4] withcolor cl dashed evenly;
draw p[6]--p[9] withcolor cl dashed evenly;
draw p[2]--p[6];
draw p[3]--p[9] withcolor cl dashed evenly;

color cc[];
cc[1] := COL(189, 236, 182);
cc[2] := COL(32, 33, 79);
cc[3] := COL(234, 137, 154);

dp(p[1], r, cc[1]);
dp(p[2], r, cc[2]);
dp(p[3], r, cc[2]);
dp(p[4], r, cc[3]);
dp(p[5], r, cc[3]);
dp(p[6], r, cc[3]);
dp(p[7], r, cc[3]);
dp(p[8], r, cc[2]);
dp(p[9], r, cc[1]);
dp(p[10], r, cc[2]);

label(btex \Huge $\bm{1}$ etex, p[1]);
label(btex \Huge $\bm{2}$ etex, p[2]) withcolor white;
label(btex \Huge $\bm{3}$ etex, p[3]) withcolor white;
label(btex \Huge $\bm{4}$ etex, p[4]);
label(btex \Huge $\bm{5}$ etex, p[5]);
label(btex \Huge $\bm{6}$ etex, p[6]);
label(btex \Huge $\bm{7}$ etex, p[7]);
label(btex \Huge $\bm{8}$ etex, p[8]) withcolor white;
label(btex \Huge $\bm{9}$ etex, p[9]);
label(btex \LARGE $\bm{10}$ etex, p[10]) withcolor white;

endfig;

end;
