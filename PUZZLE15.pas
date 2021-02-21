program puzzle;
uses crt,windows;
const xmax=19;
      ymax=9;   {"pixel" v Pascalu je vyssi nez sirsi}
const pocethr=10;

type ctverec = array [1..xmax,1..ymax]of char;

type hrac3 = record
           jmeno:string;
           skore:integer;
           end;
type hrac4 = record
           jmeno:string;
           skore:integer;
           end;
type hrac5 = record
           jmeno:string;
           skore:integer;
           end;

var s,a,zvuky,pi,md,ID,WW,AA,SS,DD,obtiznost,pocettahu,g,pocitadloprouzi:integer;   {md=Manhattan distance}

    zmack:char;
    tab3:text;
    tab4:text;
    tab5:text;

    poct,mazu,pact:integer;
    tabuvs3: array[1..pocethr+1] of hrac3;
    tabuvs4: array[1..pocethr+1] of hrac4;
    tabuvs5: array[1..pocethr+1] of hrac5;
    uzivatel:string[16];
    f: ctverec;

    cislo: array [1..4,1..4]of integer;
    cislo3: array [1..3,1..3]of integer;
    cislo5: array [1..5,1..5]of integer;
    {pole cislo znaËÌ pole, kterÈ si poËÌtaË se¯adil a je jiû se¯azenÈ}
    cislohra: array [1..4,1..4]of integer;
    cislohra3: array [1..3,1..3]of integer;
    cislohra5: array [1..5,1..5]of integer;
    {pole cislohra znaËÌ pole, kterÈ vidÌ uûivatel a kterÈ se snaûÌ se¯adit}

//----------------------------------------------------------------------------//
//<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>//

procedure prectisito;
var ch:string;
    int:integer;
    rech:integer;

begin case pact of

3: begin
     reset (tab3);
     for rech:=1 to pocethr do
     begin readln(tab3,ch); tabuvs3[rech].jmeno:=ch; readln(tab3,int); tabuvs3[rech].skore:=int; end;
     close(tab3); end;
4: begin
     reset (tab4);
     for rech:=1 to pocethr do
     begin readln(tab4,ch); tabuvs4[rech].jmeno:=ch; readln(tab4,int); tabuvs4[rech].skore:=int; end;
     close(tab4); end;
5: begin
     reset (tab5);
     for rech:=1 to pocethr do
     begin readln(tab5,ch); tabuvs5[rech].jmeno:=ch; readln(tab5,int); tabuvs5[rech].skore:=int; end;
     close(tab5); end;

end;end;
//<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>//

procedure smazsito;
begin case obtiznost of

3: begin
   rewrite(tab3);
   for mazu:=1 to pocethr do begin
   writeln(tab3,tabuvs3[mazu].jmeno);writeln(tab3,tabuvs3[mazu].skore); end;
   close(tab3);
   end;
4: begin
   rewrite(tab4);
   for mazu:=1 to pocethr do begin
   writeln(tab4,tabuvs4[mazu].jmeno);writeln(tab4,tabuvs4[mazu].skore); end;
   close(tab4);
   end;
5: begin
   rewrite(tab5);
   for mazu:=1 to pocethr do begin
   writeln(tab5,tabuvs5[mazu].jmeno);writeln(tab5,tabuvs5[mazu].skore); end;
   close(tab5);
   end;

end;end;

//<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>//

procedure vypismito;
var pridat,kolikme,zaspo:integer;
begin pridat:=1; case pact of

3: begin for poct:=1 to pocethr do begin if poct>=10 then begin gotoxy(43,14+pridat);write(poct,'. '); end else begin gotoxy(44,14+pridat);write(poct,'. ');end;
write(tabuvs3[poct].jmeno);kolikme:=(length(tabuvs3[poct].jmeno));for zaspo:=1 to 20-kolikme do begin write(' '); end;writeln(tabuvs3[poct].skore);pridat:=pridat+1;end;  end;


4: begin for poct:=1 to pocethr do begin if poct>=10 then begin gotoxy(43,14+pridat);write(poct,'. '); end else begin gotoxy(44,14+pridat);write(poct,'. ');end;
write(tabuvs4[poct].jmeno);kolikme:=(length(tabuvs4[poct].jmeno));for zaspo:=1 to 20-kolikme do begin write(' '); end;writeln(tabuvs4[poct].skore);pridat:=pridat+1;end;  end;


5: begin for poct:=1 to pocethr do begin if poct>=10 then begin gotoxy(43,14+pridat);write(poct,'. '); end else begin gotoxy(44,14+pridat);write(poct,'. ');end;
write(tabuvs5[poct].jmeno);kolikme:=(length(tabuvs5[poct].jmeno));for zaspo:=1 to 20-kolikme do begin write(' '); end;writeln(tabuvs5[poct].skore);pridat:=pridat+1;end;  end;

end;end;

//<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>//

procedure seradsito;
var qw,we,schranec,alfa,beta:integer; schrj:string;
begin case obtiznost of

3: begin
for we:=1 to 10 do begin
for qw:=1 to pocethr do begin alfa:=(tabuvs3[qw].skore);beta:=(tabuvs3[qw+1].skore);
if (alfa>beta)
then
begin schranec:=tabuvs3[qw].skore;schrj:=tabuvs3[qw].jmeno;
      tabuvs3[qw].skore:=tabuvs3[qw+1].skore;tabuvs3[qw].jmeno:=tabuvs3[qw+1].jmeno;
      tabuvs3[qw+1].skore:=schranec;tabuvs3[qw+1].jmeno:=schrj;
end;end;end;end;
4: begin
for we:=1 to 10 do begin
for qw:=1 to pocethr do begin alfa:=(tabuvs4[qw].skore);beta:=(tabuvs4[qw+1].skore);
if (alfa>beta)
then
begin schranec:=tabuvs4[qw].skore;schrj:=tabuvs4[qw].jmeno;
      tabuvs4[qw].skore:=tabuvs4[qw+1].skore;tabuvs4[qw].jmeno:=tabuvs4[qw+1].jmeno;
      tabuvs4[qw+1].skore:=schranec;tabuvs4[qw+1].jmeno:=schrj;
end;end;end;end;
5: begin
for we:=1 to 10 do begin
for qw:=1 to pocethr do begin alfa:=(tabuvs5[qw].skore);beta:=(tabuvs5[qw+1].skore);
if (alfa>beta)
then
begin schranec:=tabuvs5[qw].skore;schrj:=tabuvs5[qw].jmeno;
      tabuvs5[qw].skore:=tabuvs5[qw+1].skore;tabuvs5[qw].jmeno:=tabuvs5[qw+1].jmeno;
      tabuvs5[qw+1].skore:=schranec;tabuvs5[qw+1].jmeno:=schrj;
end;end;end;end;

end;end;

//<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>//
//----------------------------------------------------------------------------//

procedure ohrvse; {ohranici cele hraci pole}
var poci,pocy,pos:integer; {pocitadla a posunuti}
begin
cursoroff;textcolor(white);pos:=0;
gotoxy(1,1); write(chr(218)); for poci:=2 to 113 do write(chr(196));
write(chr(191)); {horni rada}
for pocy:=2 to 49 do begin pos:=pos+1; for poci:=2 to 113 do
begin gotoxy(1,1+pos); write(chr(179)); gotoxy(114,1+pos);
write(chr(179));  end; end; {okraje}
gotoxy(1,50); write(chr(192));
for poci:=2 to 113 do write(chr(196)); write(chr(217)); {spodni rada}
end;
//<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>//
procedure v; {pise vypln}
begin write(chr(219)); end;
procedure m; {pise mezeru}
begin write(chr(32)); end;
//<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>//
procedure nazev; {vypise nad hraci pole nazev hry (15PUZZLE)}
begin cursoroff;gotoxy(43,3);
textcolor(cyan);m;v;m;v;v;v;textcolor(white);m;v;v;v;m;v;m;v;m;v;v;v;m;v;v;v;m;v;m;m;m;v;v;v; gotoxy(43,4);
textcolor(cyan);v;v;m;v;m;m;textcolor(white);m;v;m;v;m;v;m;v;m;m;m;v;m;m;m;v;m;v;m;m;m;v;m;m; gotoxy(43,5);
textcolor(cyan);m;v;m;v;v;v;textcolor(white);m;v;v;v;m;v;m;v;m;m;v;m;m;m;v;m;m;v;m;m;m;v;v;m; gotoxy(43,6);
textcolor(cyan);m;v;m;m;m;v;textcolor(white);m;v;m;m;m;v;m;v;m;v;m;m;m;v;m;m;m;v;m;m;m;v;m;m; gotoxy(43,7);
textcolor(cyan);m;v;m;v;v;v;textcolor(white);m;v;m;m;m;v;v;v;m;v;v;v;m;v;v;v;m;v;v;v;m;v;v;v;end;
procedure jedna;
//<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>//
begin
cursoroff;s:=13; gotoxy(s,a);a:=a+1;
m;m;m;v;v;v;m;m;m; gotoxy(s,a);a:=a+1;
m;m;m;v;v;v;m;m;m; gotoxy(s,a);a:=a+1;
m;m;m;v;v;v;m;m;m; gotoxy(s,a);a:=a+1;
v;v;v;v;v;v;m;m;m; gotoxy(s,a);a:=a+1;
v;v;v;v;v;v;m;m;m; gotoxy(s,a);a:=a+1;
v;v;v;v;v;v;m;m;m; gotoxy(s,a);a:=a+1;
m;m;m;v;v;v;m;m;m; gotoxy(s,a);a:=a+1;
m;m;m;v;v;v;m;m;m; gotoxy(s,a);a:=a+1;
m;m;m;v;v;v;m;m;m; gotoxy(s,a);a:=a+1;
m;m;m;v;v;v;m;m;m; gotoxy(s,a);a:=a+1;
m;m;m;v;v;v;m;m;m; gotoxy(s,a);a:=a+1;
m;m;m;v;v;v;m;m;m; gotoxy(s,a);a:=a+1;
m;m;m;v;v;v;m;m;m; gotoxy(s,a);a:=a+1;
m;m;m;v;v;v;m;m;m; gotoxy(s,a);a:=a+1;
m;m;m;v;v;v;m;m;m; gotoxy(s,a);a:=8;
end;
//<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>//
procedure pet;
begin
cursoroff;s:=22; gotoxy(s,a);a:=a+1;
v;v;v;v;v;v;v;v;v;m;m;m; gotoxy(s,a);a:=a+1;
v;v;v;v;v;v;v;v;v;m;m;m; gotoxy(s,a);a:=a+1;
v;v;v;v;v;v;v;v;v;m;m;m; gotoxy(s,a);a:=a+1;
v;v;v;m;m;m;m;m;m;m;m;m; gotoxy(s,a);a:=a+1;
v;v;v;m;m;m;m;m;m;m;m;m; gotoxy(s,a);a:=a+1;
v;v;v;m;m;m;m;m;m;m;m;m; gotoxy(s,a);a:=a+1;
v;v;v;v;v;v;v;v;v;m;m;m; gotoxy(s,a);a:=a+1;
v;v;v;v;v;v;v;v;v;m;m;m; gotoxy(s,a);a:=a+1;
v;v;v;v;v;v;v;v;v;m;m;m; gotoxy(s,a);a:=a+1;
m;m;m;m;m;m;v;v;v;m;m;m; gotoxy(s,a);a:=a+1;
m;m;m;m;m;m;v;v;v;m;m;m; gotoxy(s,a);a:=a+1;
m;m;m;m;m;m;v;v;v;m;m;m; gotoxy(s,a);a:=a+1;
v;v;v;v;v;v;v;v;v;m;m;m; gotoxy(s,a);a:=a+1;
v;v;v;v;v;v;v;v;v;m;m;m; gotoxy(s,a);a:=a+1;
v;v;v;v;v;v;v;v;v;m;m;m; gotoxy(s,a);a:=8;
end;
//<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>//
procedure p;
begin
cursoroff;s:=34;gotoxy(s,a);a:=a+1;
v;v;v;v;v;v;v;v;v;m;m;m; gotoxy(s,a);a:=a+1;
v;v;v;v;v;v;v;v;v;m;m;m; gotoxy(s,a);a:=a+1;
v;v;v;v;v;v;v;v;v;m;m;m; gotoxy(s,a);a:=a+1;
v;v;v;m;m;m;v;v;v;m;m;m; gotoxy(s,a);a:=a+1;
v;v;v;m;m;m;v;v;v;m;m;m; gotoxy(s,a);a:=a+1;
v;v;v;m;m;m;v;v;v;m;m;m; gotoxy(s,a);a:=a+1;
v;v;v;v;v;v;v;v;v;m;m;m; gotoxy(s,a);a:=a+1;
v;v;v;v;v;v;v;v;v;m;m;m; gotoxy(s,a);a:=a+1;
v;v;v;v;v;v;v;v;v;m;m;m; gotoxy(s,a);a:=a+1;
v;v;v;m;m;m;m;m;m;m;m;m; gotoxy(s,a);a:=a+1;
v;v;v;m;m;m;m;m;m;m;m;m; gotoxy(s,a);a:=a+1;
v;v;v;m;m;m;m;m;m;m;m;m; gotoxy(s,a);a:=a+1;
v;v;v;m;m;m;m;m;m;m;m;m; gotoxy(s,a);a:=a+1;
v;v;v;m;m;m;m;m;m;m;m;m; gotoxy(s,a);a:=a+1;
v;v;v;m;m;m;m;m;m;m;m;m; gotoxy(s,a);a:=8;
end;
//<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>//
procedure u;
begin
cursoroff;s:=46;gotoxy(s,a);a:=a+1;
v;v;v;m;m;m;v;v;v;m;m;m; gotoxy(s,a);a:=a+1;
v;v;v;m;m;m;v;v;v;m;m;m; gotoxy(s,a);a:=a+1;
v;v;v;m;m;m;v;v;v;m;m;m; gotoxy(s,a);a:=a+1;
v;v;v;m;m;m;v;v;v;m;m;m; gotoxy(s,a);a:=a+1;
v;v;v;m;m;m;v;v;v;m;m;m; gotoxy(s,a);a:=a+1;
v;v;v;m;m;m;v;v;v;m;m;m; gotoxy(s,a);a:=a+1;
v;v;v;m;m;m;v;v;v;m;m;m; gotoxy(s,a);a:=a+1;
v;v;v;m;m;m;v;v;v;m;m;m; gotoxy(s,a);a:=a+1;
v;v;v;m;m;m;v;v;v;m;m;m; gotoxy(s,a);a:=a+1;
v;v;v;m;m;m;v;v;v;m;m;m; gotoxy(s,a);a:=a+1;
v;v;v;m;m;m;v;v;v;m;m;m; gotoxy(s,a);a:=a+1;
v;v;v;m;m;m;v;v;v;m;m;m; gotoxy(s,a);a:=a+1;
v;v;v;v;v;v;v;v;v;m;m;m; gotoxy(s,a);a:=a+1;
v;v;v;v;v;v;v;v;v;m;m;m; gotoxy(s,a);a:=a+1;
v;v;v;v;v;v;v;v;v;m;m;m; gotoxy(s,a);a:=8;
end;
//<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>//
procedure z(t:integer);
begin
begin case t of 1: begin s:=58; end;
          2: begin s:=70; end; end;
cursoroff;gotoxy(s,a);a:=a+1;
v;v;v;v;v;v;v;v;v;m;m;m; gotoxy(s,a);a:=a+1;
v;v;v;v;v;v;v;v;v;m;m;m; gotoxy(s,a);a:=a+1;
v;v;v;v;v;v;v;v;v;m;m;m; gotoxy(s,a);a:=a+1;
m;m;m;m;m;m;v;v;v;m;m;m; gotoxy(s,a);a:=a+1;
m;m;m;m;m;m;v;v;v;m;m;m; gotoxy(s,a);a:=a+1;
m;m;m;m;m;m;v;v;v;m;m;m; gotoxy(s,a);a:=a+1;
m;m;m;v;v;v;m;m;m;m;m;m; gotoxy(s,a);a:=a+1;
m;m;m;v;v;v;m;m;m;m;m;m; gotoxy(s,a);a:=a+1;
m;m;m;v;v;v;m;m;m;m;m;m; gotoxy(s,a);a:=a+1;
v;v;v;m;m;m;m;m;m;m;m;m; gotoxy(s,a);a:=a+1;
v;v;v;m;m;m;m;m;m;m;m;m; gotoxy(s,a);a:=a+1;
v;v;v;m;m;m;m;m;m;m;m;m; gotoxy(s,a);a:=a+1;
v;v;v;v;v;v;v;v;v;m;m;m; gotoxy(s,a);a:=a+1;
v;v;v;v;v;v;v;v;v;m;m;m; gotoxy(s,a);a:=a+1;
v;v;v;v;v;v;v;v;v;m;m;m; gotoxy(s,a);a:=8;
end;
end;
//<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>//
procedure l;
begin
cursoroff;s:=82;gotoxy(s,a);a:=a+1;
v;v;v;m;m;m;m;m;m;m;m;m; gotoxy(s,a);a:=a+1;
v;v;v;m;m;m;m;m;m;m;m;m; gotoxy(s,a);a:=a+1;
v;v;v;m;m;m;m;m;m;m;m;m; gotoxy(s,a);a:=a+1;
v;v;v;m;m;m;m;m;m;m;m;m; gotoxy(s,a);a:=a+1;
v;v;v;m;m;m;m;m;m;m;m;m; gotoxy(s,a);a:=a+1;
v;v;v;m;m;m;m;m;m;m;m;m; gotoxy(s,a);a:=a+1;
v;v;v;m;m;m;m;m;m;m;m;m; gotoxy(s,a);a:=a+1;
v;v;v;m;m;m;m;m;m;m;m;m; gotoxy(s,a);a:=a+1;
v;v;v;m;m;m;m;m;m;m;m;m; gotoxy(s,a);a:=a+1;
v;v;v;m;m;m;m;m;m;m;m;m; gotoxy(s,a);a:=a+1;
v;v;v;m;m;m;m;m;m;m;m;m; gotoxy(s,a);a:=a+1;
v;v;v;m;m;m;m;m;m;m;m;m; gotoxy(s,a);a:=a+1;
v;v;v;v;v;v;v;v;v;m;m;m; gotoxy(s,a);a:=a+1;
v;v;v;v;v;v;v;v;v;m;m;m; gotoxy(s,a);a:=a+1;
v;v;v;v;v;v;v;v;v;m;m;m; gotoxy(s,a);a:=8;
end;
//<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>//
procedure e;
begin
cursoroff;s:=94;gotoxy(s,a);a:=a+1;
v;v;v;v;v;v;v;v;v;m;m;m; gotoxy(s,a);a:=a+1;
v;v;v;v;v;v;v;v;v;m;m;m; gotoxy(s,a);a:=a+1;
v;v;v;v;v;v;v;v;v;m;m;m; gotoxy(s,a);a:=a+1;
v;v;v;m;m;m;m;m;m;m;m;m; gotoxy(s,a);a:=a+1;
v;v;v;m;m;m;m;m;m;m;m;m; gotoxy(s,a);a:=a+1;
v;v;v;m;m;m;m;m;m;m;m;m; gotoxy(s,a);a:=a+1;
v;v;v;v;v;v;m;m;m;m;m;m; gotoxy(s,a);a:=a+1;
v;v;v;v;v;v;m;m;m;m;m;m; gotoxy(s,a);a:=a+1;
v;v;v;v;v;v;m;m;m;m;m;m; gotoxy(s,a);a:=a+1;
v;v;v;m;m;m;m;m;m;m;m;m; gotoxy(s,a);a:=a+1;
v;v;v;m;m;m;m;m;m;m;m;m; gotoxy(s,a);a:=a+1;
v;v;v;m;m;m;m;m;m;m;m;m; gotoxy(s,a);a:=a+1;
v;v;v;v;v;v;v;v;v;m;m;m; gotoxy(s,a);a:=a+1;
v;v;v;v;v;v;v;v;v;m;m;m; gotoxy(s,a);a:=a+1;
v;v;v;v;v;v;v;v;v;m;m;m; gotoxy(s,a);a:=8;
end;
//<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>//
procedure nap_novahra;
var b:integer;
begin
cursoroff;s:=43;b:=13;gotoxy(s,b);b:=b+1;
v;m;m;m;v;m;v;v;v;m;v;m;v;m;v;v;v;m;m;v;m;v;m;v;v;v;m;v;v;v; gotoxy(s,b);b:=b+1;
v;v;m;m;v;m;v;m;v;m;v;m;v;m;v;m;v;m;m;v;m;v;m;v;m;v;m;v;m;v; gotoxy(s,b);b:=b+1;
v;m;v;m;v;m;v;m;v;m;v;m;v;m;v;v;v;m;m;v;v;v;m;v;v;m;m;v;v;v; gotoxy(s,b);b:=b+1;
v;m;m;v;v;m;v;m;v;m;v;m;v;m;v;m;v;m;m;v;m;v;m;v;m;v;m;v;m;v; gotoxy(s,b);b:=b+1;
v;m;m;m;v;m;v;v;v;m;m;v;m;m;v;m;v;m;m;v;m;v;m;v;m;v;m;v;m;v;
end;
//<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>//
procedure nap_obtiznost;
var b:integer;
begin
cursoroff;s:=40;b:=19;gotoxy(s,b);b:=b+1;
v;v;v;m;v;v;v;v;m;v;v;v;m;v;m;v;v;v;m;v;m;m;m;v;m;v;v;v;m;v;v;v;m;v;v;v; gotoxy(s,b);b:=b+1;
v;m;v;m;v;m;m;v;m;m;v;m;m;v;m;m;m;v;m;v;v;m;m;v;m;v;m;v;m;v;m;m;m;m;v;m; gotoxy(s,b);b:=b+1;
v;m;v;m;v;v;v;m;m;m;v;m;m;v;m;m;v;m;m;v;m;v;m;v;m;v;m;v;m;v;v;v;m;m;v;m; gotoxy(s,b);b:=b+1;
v;m;v;m;v;m;m;v;m;m;v;m;m;v;m;v;m;m;m;v;m;m;v;v;m;v;m;v;m;m;m;v;m;m;v;m; gotoxy(s,b);b:=b+1;
v;v;v;m;v;v;v;v;m;m;v;m;m;v;m;v;v;v;m;v;m;m;m;v;m;v;v;v;m;v;v;v;m;m;v;m; gotoxy(s,b);b:=b+1;
end;
//<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>//
procedure nap_ovladani;
var b:integer;
begin
cursoroff;s:=22;b:=25;gotoxy(s,b);b:=b+1;
v;m;m;m;v;m;v;v;v;m;v;v;v;m;v;v;v;m;v;v;v;m;v;m;v;m;v;v;v;m;v;m;m;m;v;m;v;m;m;v;v;v;m;m;v;v;v;m;v;m;v;m;v;v;v;m;v;v;v;m;v;v;v;m;v;m;v;v;v;m;v;m;m;  gotoxy(s,b);b:=b+1;
v;v;m;m;v;m;v;m;v;m;v;m;m;m;m;v;m;m;v;m;v;m;v;m;v;m;v;m;m;m;v;v;m;m;v;m;v;m;m;v;m;v;m;m;m;v;m;m;v;m;v;m;m;v;m;m;v;m;v;m;v;m;v;m;v;m;v;m;v;m;v;m;m;  gotoxy(s,b);b:=b+1;
v;m;v;m;v;m;v;v;v;m;v;v;v;m;m;v;m;m;v;v;v;m;v;m;v;m;v;v;m;m;v;m;v;m;v;m;v;m;m;v;v;v;m;m;m;v;m;m;v;m;v;m;m;v;m;m;v;m;v;m;v;v;m;m;v;m;v;v;v;m;v;m;m;  gotoxy(s,b);b:=b+1;
v;m;m;v;v;m;v;m;v;m;m;m;v;m;m;v;m;m;v;m;v;m;v;m;v;m;v;m;m;m;v;m;m;v;v;m;v;m;m;v;m;v;m;m;m;v;m;m;v;m;v;m;m;v;m;m;v;m;v;m;v;m;v;m;v;m;v;m;v;m;v;m;m;  gotoxy(s,b);b:=b+1;
v;m;m;m;v;m;v;m;v;m;v;v;v;m;m;v;m;m;v;m;v;m;m;v;m;m;v;v;v;m;v;m;m;m;v;m;v;m;m;v;m;v;m;m;m;v;m;m;v;v;v;m;m;v;m;m;v;v;v;m;v;m;v;m;v;m;v;m;v;m;v;v;v;  gotoxy(s,b);b:=b+1;
end;
//<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>//
procedure nap_sinslavy;
var b:integer;
begin
cursoroff;s:=42;b:=31;gotoxy(s,b);b:=b+1;
v;v;v;m;v;m;v;m;m;m;v;m;m;v;v;v;m;v;m;m;m;v;v;v;m;v;m;v;m;v;m;v; gotoxy(s,b);b:=b+1;
v;m;m;m;v;m;v;v;m;m;v;m;m;v;m;m;m;v;m;m;m;v;m;v;m;v;m;v;m;v;m;v; gotoxy(s,b);b:=b+1;
v;v;v;m;v;m;v;m;v;m;v;m;m;v;v;v;m;v;m;m;m;v;v;v;m;v;m;v;m;m;v;m; gotoxy(s,b);b:=b+1;
m;m;v;m;v;m;v;m;m;v;v;m;m;m;m;v;m;v;m;m;m;v;m;v;m;v;m;v;m;m;v;m; gotoxy(s,b);b:=b+1;
v;v;v;m;v;m;v;m;m;m;v;m;m;v;v;v;m;v;v;v;m;v;m;v;m;m;v;m;m;m;v;m; gotoxy(s,b);b:=b+1;
end;
//<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>//
procedure nap_konec;
var b:integer;
begin
cursoroff;s:=47;b:=37;gotoxy(s,b);b:=b+1;
v;m;m;v;m;v;v;v;m;v;m;m;m;v;m;v;v;v;m;v;v;v; gotoxy(s,b);b:=b+1;
v;m;v;m;m;v;m;v;m;v;v;m;m;v;m;v;m;m;m;v;m;m; gotoxy(s,b);b:=b+1;
v;v;m;m;m;v;m;v;m;v;m;v;m;v;m;v;v;m;m;v;m;m; gotoxy(s,b);b:=b+1;
v;m;v;m;m;v;m;v;m;v;m;m;v;v;m;v;m;m;m;v;m;m; gotoxy(s,b);b:=b+1;
v;m;m;v;m;v;v;v;m;v;m;m;m;v;m;v;v;v;m;v;v;v; gotoxy(s,b);b:=b+1;
end;
//<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>//
procedure nap_lehka;
var b:integer;
begin
cursoroff;s:=39;b:=13;gotoxy(s,b);b:=b+1;
v;m;m;m;v;v;v;m;v;m;v;m;v;m;m;v;m;v;v;v;m;m;m;m;m;m;v;v;v;m;m;m;m;m;v;v;v; gotoxy(s,b);b:=b+1;
v;m;m;m;v;m;m;m;v;m;v;m;v;m;v;m;m;v;m;v;m;m;m;m;m;m;m;m;v;m;v;m;v;m;m;m;v; gotoxy(s,b);b:=b+1;
v;m;m;m;v;v;m;m;v;v;v;m;v;v;m;m;m;v;v;v;m;m;v;v;m;m;v;v;v;m;m;v;m;m;v;v;v; gotoxy(s,b);b:=b+1;
v;m;m;m;v;m;m;m;v;m;v;m;v;m;v;m;m;v;m;v;m;m;m;m;m;m;m;m;v;m;v;m;v;m;m;m;v; gotoxy(s,b);b:=b+1;
v;v;v;m;v;v;v;m;v;m;v;m;v;m;m;v;m;v;m;v;m;m;m;m;m;m;v;v;v;m;m;m;m;m;v;v;v; gotoxy(s,b);b:=b+1;
end;
//<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>//
procedure nap_stredni;
var b:integer;
begin
cursoroff;s:=36;b:=19;gotoxy(s,b);b:=b+1;
v;v;v;m;v;v;v;m;v;v;v;m;v;v;v;m;v;v;m;m;v;m;m;m;v;m;v;m;m;m;m;m;m;v;m;v;m;m;m;m;m;v;m;v; gotoxy(s,b);b:=b+1;
v;m;m;m;m;v;m;m;v;m;v;m;v;m;m;m;v;m;v;m;v;v;m;m;v;m;v;m;m;m;m;m;m;v;m;v;m;v;m;v;m;v;m;v; gotoxy(s,b);b:=b+1;
v;v;v;m;m;v;m;m;v;v;m;m;v;v;m;m;v;m;v;m;v;m;v;m;v;m;v;m;m;v;v;m;m;v;v;v;m;m;v;m;m;v;v;v; gotoxy(s,b);b:=b+1;
m;m;v;m;m;v;m;m;v;m;v;m;v;m;m;m;v;m;v;m;v;m;m;v;v;m;v;m;m;m;m;m;m;m;m;v;m;v;m;v;m;m;m;v; gotoxy(s,b);b:=b+1;
v;v;v;m;m;v;m;m;v;m;v;m;v;v;v;m;v;v;m;m;v;m;m;m;v;m;v;m;m;m;m;m;m;m;m;v;m;m;m;m;m;m;m;v; gotoxy(s,b);b:=b+1;
end;
//<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>//
procedure nap_tezka;
var b:integer;
begin
cursoroff;s:=39;b:=25;gotoxy(s,b);b:=b+1;
v;v;v;m;v;v;v;m;v;v;v;m;v;m;m;v;m;v;v;v;m;m;m;m;m;m;v;v;v;m;m;m;m;m;v;v;v; gotoxy(s,b);b:=b+1;
m;v;m;m;v;m;m;m;m;m;v;m;v;m;v;m;m;v;m;v;m;m;m;m;m;m;v;m;m;m;v;m;v;m;v;m;m; gotoxy(s,b);b:=b+1;
m;v;m;m;v;v;m;m;m;v;m;m;v;v;m;m;m;v;v;v;m;m;v;v;m;m;v;v;v;m;m;v;m;m;v;v;v; gotoxy(s,b);b:=b+1;
m;v;m;m;v;m;m;m;v;m;m;m;v;m;v;m;m;v;m;v;m;m;m;m;m;m;m;m;v;m;v;m;v;m;m;m;v; gotoxy(s,b);b:=b+1;
m;v;m;m;v;v;v;m;v;v;v;m;v;m;m;v;m;v;m;v;m;m;m;m;m;m;v;v;v;m;m;m;m;m;v;v;v; gotoxy(s,b);b:=b+1;
end;
//<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>//
procedure nap_zpet;
var b:integer;
begin
cursoroff;s:=50;b:=36;gotoxy(s,b);b:=b+1;
v;v;v;m;v;v;v;m;v;v;v;m;v;v;v; gotoxy(s,b);b:=b+1;
m;m;v;m;v;m;v;m;v;m;m;m;m;v;m; gotoxy(s,b);b:=b+1;
m;v;m;m;v;v;v;m;v;v;m;m;m;v;m; gotoxy(s,b);b:=b+1;
v;m;m;m;v;m;m;m;v;m;m;m;m;v;m; gotoxy(s,b);b:=b+1;
v;v;v;m;v;m;m;m;v;v;v;m;m;v;m; gotoxy(s,b);b:=b+1;
end;
//<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>//
procedure nap_jakhrat; {tutorial}
var b:integer;
begin
cursoroff;s:=44;b:=13;gotoxy(s,b);b:=b+1;
v;v;v;m;v;m;v;m;v;v;v;m;v;v;v;m;v;v;v;m;v;m;v;v;v;m;v;m;m;   gotoxy(s,b);b:=b+1;
m;v;m;m;v;m;v;m;m;v;m;m;v;m;v;m;v;m;v;m;v;m;v;m;v;m;v;m;m;   gotoxy(s,b);b:=b+1;
m;v;m;m;v;m;v;m;m;v;m;m;v;m;v;m;v;v;m;m;v;m;v;v;v;m;v;m;m;   gotoxy(s,b);b:=b+1;
m;v;m;m;v;m;v;m;m;v;m;m;v;m;v;m;v;m;v;m;v;m;v;m;v;m;v;m;m;   gotoxy(s,b);b:=b+1;
m;v;m;m;v;v;v;m;m;v;m;m;v;v;v;m;v;m;v;m;v;m;v;m;v;m;v;v;v;   gotoxy(s,b);b:=b+1;
end;
//<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>//
procedure nap_ohre ; {zmena uzivatele}
var b:integer;
begin
cursoroff;s:=30;b:=19;gotoxy(s,b);b:=b+1;
v;v;v;m;v;m;m;m;v;m;v;v;v;m;v;m;m;m;v;m;v;v;v;m;m;v;m;v;m;v;v;v;m;v;m;v;m;v;m;v;v;v;m;v;v;v;m;v;v;v;m;v;m;m;m;v;v;v; gotoxy(s,b);b:=b+1;
m;m;v;m;v;v;m;v;v;m;v;m;m;m;v;v;m;m;v;m;v;m;v;m;m;v;m;v;m;m;m;v;m;v;m;v;m;v;m;v;m;v;m;m;v;m;m;v;m;m;m;v;m;m;m;v;m;m; gotoxy(s,b);b:=b+1;
m;v;m;m;v;m;v;m;v;m;v;v;m;m;v;m;v;m;v;m;v;v;v;m;m;v;m;v;m;m;v;m;m;v;m;v;m;v;m;v;v;v;m;m;v;m;m;v;v;m;m;v;m;m;m;v;v;m; gotoxy(s,b);b:=b+1;
v;m;m;m;v;m;m;m;v;m;v;m;m;m;v;m;m;v;v;m;v;m;v;m;m;v;m;v;m;v;m;m;m;v;m;v;m;v;m;v;m;v;m;m;v;m;m;v;m;m;m;v;m;m;m;v;m;m; gotoxy(s,b);b:=b+1;
v;v;v;m;v;m;m;m;v;m;v;v;v;m;v;m;m;m;v;m;v;m;v;m;m;v;v;v;m;v;v;v;m;v;m;m;v;m;m;v;m;v;m;m;v;m;m;v;v;v;m;v;v;v;m;v;v;v; gotoxy(s,b);b:=b+1;
end;
//<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>//
procedure nap_vypnoutzvuky ;
var b:integer;
begin
cursoroff;s:=33;b:=25;gotoxy(s,b);b:=b+1;
v;m;v;m;v;m;v;m;v;v;v;m;v;m;m;m;v;m;v;v;v;m;v;m;v;m;v;v;v;m;m;v;v;v;m;v;m;v;m;v;m;v;m;v;m;m;v;m;v;m;v;  gotoxy(s,b);b:=b+1;
v;m;v;m;v;m;v;m;v;m;v;m;v;v;m;m;v;m;v;m;v;m;v;m;v;m;m;v;m;m;m;m;m;v;m;v;m;v;m;v;m;v;m;v;m;v;m;m;v;m;v;  gotoxy(s,b);b:=b+1;
v;m;v;m;m;v;m;m;v;v;v;m;v;m;v;m;v;m;v;m;v;m;v;m;v;m;m;v;m;m;m;m;v;m;m;v;m;v;m;v;m;v;m;v;v;m;m;m;m;v;m;  gotoxy(s,b);b:=b+1;
v;m;v;m;m;v;m;m;v;m;m;m;v;m;m;v;v;m;v;m;v;m;v;m;v;m;m;v;m;m;m;v;m;m;m;v;m;v;m;v;m;v;m;v;m;v;m;m;m;v;m;  gotoxy(s,b);b:=b+1;
m;v;m;m;m;v;m;m;v;m;m;m;v;m;m;m;v;m;v;v;v;m;v;v;v;m;m;v;m;m;m;v;v;v;m;m;v;m;m;v;v;v;m;v;m;m;v;m;m;v;m;  gotoxy(s,b);b:=b+1;
end;
//<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>//
procedure nap_zapnoutzvuky  ;
var b:integer;
begin
cursoroff;s:=33;b:=25;gotoxy(s,b);b:=b+1;
v;v;v;m;v;v;v;m;v;v;v;m;v;m;m;m;v;m;v;v;v;m;v;m;v;m;v;v;v;m;m;v;v;v;m;v;m;v;m;v;m;v;m;v;m;m;v;m;v;m;v;  gotoxy(s,b);b:=b+1;
m;m;v;m;v;m;v;m;v;m;v;m;v;v;m;m;v;m;v;m;v;m;v;m;v;m;m;v;m;m;m;m;m;v;m;v;m;v;m;v;m;v;m;v;m;v;m;m;v;m;v;  gotoxy(s,b);b:=b+1;
m;v;m;m;v;v;v;m;v;v;v;m;v;m;v;m;v;m;v;m;v;m;v;m;v;m;m;v;m;m;m;m;v;m;m;v;m;v;m;v;m;v;m;v;v;m;m;m;m;v;m;  gotoxy(s,b);b:=b+1;
v;m;m;m;v;m;v;m;v;m;m;m;v;m;m;v;v;m;v;m;v;m;v;m;v;m;m;v;m;m;m;v;m;m;m;v;m;v;m;v;m;v;m;v;m;v;m;m;m;v;m;  gotoxy(s,b);b:=b+1;
v;v;v;m;v;m;v;m;v;m;m;m;v;m;m;m;v;m;v;v;v;m;v;v;v;m;m;v;m;m;m;v;v;v;m;m;v;m;m;v;v;v;m;v;m;m;v;m;m;v;m;  gotoxy(s,b);b:=b+1;
end;
//<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>//
procedure vyhra;
var b:integer; cudlik:char;
begin
cursoroff;window(2,2,113,49);clrscr;window(1,1,114,50);nazev;s:=27;b:=20;gotoxy(s,b);b:=b+1;
v;v;m;m;v;v;m;m;v;v;m;m;v;v;m;m;v;v;v;v;v;v;m;m;m;m;v;v;v;v;v;v;m;m;v;v;v;v;v;v;m;m;v;v;m;m;m;m;m;m;v;v;m;m;v;v;v;v;v;v;   gotoxy(s,b);b:=b+1;
v;v;m;m;v;v;m;m;v;v;m;m;v;v;m;m;v;v;v;v;v;v;v;m;m;m;v;v;v;v;v;v;m;m;v;v;v;v;v;v;m;m;v;v;m;m;m;m;m;m;v;v;m;m;v;v;v;v;v;v;   gotoxy(s,b);b:=b+1;
v;v;m;m;v;v;m;m;v;v;m;m;v;v;m;m;v;v;m;m;m;m;v;v;m;m;v;v;m;m;v;v;m;m;v;v;m;m;v;v;m;m;v;v;v;v;m;m;m;m;v;v;m;m;v;v;m;m;m;m;   gotoxy(s,b);b:=b+1;
v;v;m;m;v;v;m;m;v;v;m;m;v;v;m;m;v;v;m;m;m;m;v;v;m;m;v;v;m;m;v;v;m;m;v;v;m;m;v;v;m;m;v;v;v;v;m;m;m;m;v;v;m;m;v;v;m;m;m;m;   gotoxy(s,b);b:=b+1;
v;v;m;m;v;v;m;m;m;m;v;v;m;m;m;m;v;v;v;v;v;v;m;m;m;m;v;v;m;m;v;v;m;m;v;v;v;v;m;m;m;m;v;v;m;m;v;v;m;m;v;v;m;m;v;v;v;v;m;m;   gotoxy(s,b);b:=b+1;
v;v;m;m;v;v;m;m;m;m;v;v;m;m;m;m;v;v;v;v;v;v;m;m;m;m;v;v;m;m;v;v;m;m;v;v;v;v;m;m;m;m;v;v;m;m;v;v;m;m;v;v;m;m;v;v;v;v;m;m;   gotoxy(s,b);b:=b+1;
v;v;m;m;v;v;m;m;m;m;v;v;m;m;m;m;v;v;m;m;m;m;v;v;m;m;v;v;m;m;v;v;m;m;v;v;m;m;v;v;m;m;v;v;m;m;m;m;v;v;v;v;m;m;v;v;m;m;m;m;   gotoxy(s,b);b:=b+1;
v;v;m;m;v;v;m;m;m;m;v;v;m;m;m;m;v;v;m;m;m;m;v;v;m;m;v;v;m;m;v;v;m;m;v;v;m;m;v;v;m;m;v;v;m;m;m;m;v;v;v;v;m;m;v;v;m;m;m;m;   gotoxy(s,b);b:=b+1;
m;m;v;v;m;m;m;m;m;m;v;v;m;m;m;m;v;v;v;v;v;v;v;m;m;m;v;v;v;v;v;v;m;m;v;v;m;m;v;v;m;m;v;v;m;m;m;m;m;m;v;v;m;m;v;v;v;v;v;v;   gotoxy(s,b);b:=b+2;
m;m;v;v;m;m;m;m;m;m;v;v;m;m;m;m;v;v;v;v;v;v;m;m;m;m;v;v;v;v;v;v;m;m;v;v;m;m;v;v;m;m;v;v;m;m;m;m;m;m;v;v;m;m;v;v;v;v;v;v;   gotoxy(s-7,b);
write('Zvladli jste hru dohrat za ',pocettahu,' tahu. Pro navrat do menu stisknete mezernik.');
repeat begin cudlik:=readkey; end; until (cudlik=#32);window(2,8,113,49);clrscr;window(1,1,114,50);
end;
//<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>//
procedure textsin;
begin gotoxy(44,13);write('UZIVATEL               POCET TAHU');
gotoxy(40,27);write('Pro navrat do MENU stisknete mezernik');
end;
//<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>//
//----------------------------------------------------------------------------//
procedure ohraniceni; {ohranici hraci pole 4x4,3x3, zrusi nadpis u pole 5x5}
var poci,pocy,pos:integer; {pocitadla a posunuti}
begin case obtiznost of
4: begin
cursoroff;textcolor(cyan);pos:=0;
gotoxy(19,9); write(chr(201)); for poci:=20 to 95 do write(chr(205));
write(chr(187)); {horni rada}
for pocy:=10 to 45 do begin pos:=pos+1; for poci:=20 to 95 do
begin gotoxy(19,9+pos); write(chr(186)); gotoxy(96,9+pos);
write(chr(186));  end; end; {okraje}
gotoxy(19,46); write(chr(200));
for poci:=20 to 95 do write(chr(205)); write(chr(188)); {spodni rada}
end;
3: begin
cursoroff;textcolor(cyan);pos:=0;
gotoxy(28,13); write(chr(201)); for poci:=29 to 85 do write(chr(205));
write(chr(187)); {horni rada}
for pocy:=14 to 40 do begin pos:=pos+1; for poci:=29 to 85 do
begin gotoxy(28,13+pos); write(chr(186)); gotoxy(86,13+pos);
write(chr(186));  end; end; {okraje}
gotoxy(28,41); write(chr(200));
for poci:=29 to 85 do write(chr(205)); write(chr(188)); {spodni rada}
end;
5: begin begin window(2,3,113,3);clrscr;window(1,1,120,60);end;
end;
end;end;
//<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>//
procedure caryvypln; {priradi mezi rohy ctverce ohraniceni a vypln}
var poci,pocy:integer; {poËÌtadla}
begin cursoroff;
for poci:=2 to 18 do begin f[poci,1]:=chr(196); f[poci,9]:=chr(196); end;
for poci:=2 to 8 do begin  for pocy:=1 to 19 do begin  if pocy=1 then
f[pocy,poci]:=chr(179) else if pocy=19 then f[pocy,poci]:=chr(179) else
begin  f[pocy,poci]:=chr(255);end; end; end;
end;
//<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>//
procedure square;  {priradi kompletni ctverec}
begin
F[1,1]:=(chr(218));
F[xmax,1]:=(chr(191));
F[1,ymax]:=(chr(192));
F[xmax,ymax]:=(chr(217));
caryvypln;
end;
//<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>//
procedure dilek (jaky:integer); {vypise square na vybrane souradnici 1-16}
var xp,yp,x,y:integer;  {pocitadlo}
begin
square;cursoroff;
case obtiznost of
4: begin
case jaky of 1: begin x:=20; y:=10; gotoxy(x,y); for yp:=1 to 9 do
                begin                            for xp:=1 to 19 do
                begin write(f[xp,yp]); if xp=19 then
                begin                           gotoxy(x,y+yp);
                end;end;end;end;
             2: begin x:=39; y:=10; gotoxy(x,y); for yp:=1 to 9 do
                begin                            for xp:=1 to 19 do
                begin write(f[xp,yp]); if xp=19 then
                begin                           gotoxy(x,y+yp);
                end;end;end;end;
             3: begin x:=58; y:=10; gotoxy(x,y); for yp:=1 to 9 do
                begin                            for xp:=1 to 19 do
                begin write(f[xp,yp]); if xp=19 then
                begin                           gotoxy(x,y+yp);
                end;end;end;end;
             4: begin x:=77; y:=10; gotoxy(x,y); for yp:=1 to 9 do
                begin                            for xp:=1 to 19 do
                begin write(f[xp,yp]); if xp=19 then
                begin                           gotoxy(x,y+yp);
                end;end;end;end;
             5: begin x:=20; y:=19; gotoxy(x,y); for yp:=1 to 9 do
                begin                            for xp:=1 to 19 do
                begin write(f[xp,yp]); if xp=19 then
                begin                           gotoxy(x,y+yp);
                end;end;end;end;
             6: begin x:=39; y:=19; gotoxy(x,y); for yp:=1 to 9 do
                begin                            for xp:=1 to 19 do
                begin write(f[xp,yp]); if xp=19 then
                begin                          gotoxy(x,y+yp);
                end;end;end;end;
             7: begin x:=58; y:=19; gotoxy(x,y); for yp:=1 to 9 do
                begin                            for xp:=1 to 19 do
                begin write(f[xp,yp]); if xp=19 then
                begin                          gotoxy(x,y+yp);
                end;end;end;end;
             8: begin x:=77; y:=19; gotoxy(x,y); for yp:=1 to 9 do
                begin                            for xp:=1 to 19 do
                begin write(f[xp,yp]); if xp=19 then
                begin                          gotoxy(x,y+yp);
                end;end;end;end;
             9: begin x:=20; y:=28; gotoxy(x,y); for yp:=1 to 9 do
                begin                            for xp:=1 to 19 do
                begin write(f[xp,yp]); if xp=19 then
                begin                          gotoxy(x,y+yp);
                end;end;end;end;
             10: begin x:=39; y:=28; gotoxy(x,y); for yp:=1 to 9 do
                begin                            for xp:=1 to 19 do
                begin  write(f[xp,yp]); if xp=19 then
                begin                            gotoxy(x,y+yp);
                end;end;end;end;
             11: begin x:=58; y:=28; gotoxy(x,y); for yp:=1 to 9 do
                begin                            for xp:=1 to 19 do
                begin write(f[xp,yp]); if xp=19 then
                begin                           gotoxy(x,y+yp);
                end;end;end;end;
             12: begin x:=77; y:=28; gotoxy(x,y); for yp:=1 to 9 do
                begin                            for xp:=1 to 19 do
                begin write(f[xp,yp]); if xp=19 then
                begin                           gotoxy(x,y+yp);
                end;end;end;end;
             13: begin x:=20; y:=37; gotoxy(x,y); for yp:=1 to 9 do
                begin                            for xp:=1 to 19 do
                begin write(f[xp,yp]); if xp=19 then
                begin                           gotoxy(x,y+yp);
                end;end;end;end;
             14: begin x:=39; y:=37; gotoxy(x,y); for yp:=1 to 9 do
                begin                            for xp:=1 to 19 do
                begin write(f[xp,yp]); if xp=19 then
                begin                           gotoxy(x,y+yp);
                end;end;end;end;
             15: begin x:=58; y:=37; gotoxy(x,y); for yp:=1 to 9 do
                begin                            for xp:=1 to 19 do
                begin write(f[xp,yp]); if xp=19 then
                begin                           gotoxy(x,y+yp);
                end;end;end;end;
             16: begin x:=77; y:=37; gotoxy(x,y); for yp:=1 to 9 do
                begin                            for xp:=1 to 19 do
                begin write(f[xp,yp]); if xp=19 then
                begin                           gotoxy(x,y+yp);
                end;end;end;end;
end;end;

3: begin
case jaky of 1: begin x:=29; y:=14; gotoxy(x,y); for yp:=1 to 9 do
                begin                            for xp:=1 to 19 do
                begin write(f[xp,yp]); if xp=19 then
                begin                           gotoxy(x,y+yp);
                end;end;end;end;
             2: begin x:=48; y:=14; gotoxy(x,y); for yp:=1 to 9 do
                begin                            for xp:=1 to 19 do
                begin write(f[xp,yp]); if xp=19 then
                begin                           gotoxy(x,y+yp);
                end;end;end;end;
             3: begin x:=67; y:=14; gotoxy(x,y); for yp:=1 to 9 do
                begin                            for xp:=1 to 19 do
                begin write(f[xp,yp]); if xp=19 then
                begin                           gotoxy(x,y+yp);
                end;end;end;end;
             4: begin x:=29; y:=23; gotoxy(x,y); for yp:=1 to 9 do
                begin                            for xp:=1 to 19 do
                begin write(f[xp,yp]); if xp=19 then
                begin                           gotoxy(x,y+yp);
                end;end;end;end;
             5: begin x:=48; y:=23; gotoxy(x,y); for yp:=1 to 9 do
                begin                            for xp:=1 to 19 do
                begin write(f[xp,yp]); if xp=19 then
                begin                           gotoxy(x,y+yp);
                end;end;end;end;
             6: begin x:=67; y:=23; gotoxy(x,y); for yp:=1 to 9 do
                begin                            for xp:=1 to 19 do
                begin write(f[xp,yp]); if xp=19 then
                begin                          gotoxy(x,y+yp);
                end;end;end;end;
             7: begin x:=29; y:=32; gotoxy(x,y); for yp:=1 to 9 do
                begin                            for xp:=1 to 19 do
                begin write(f[xp,yp]); if xp=19 then
                begin                          gotoxy(x,y+yp);
                end;end;end;end;
             8: begin x:=48; y:=32; gotoxy(x,y); for yp:=1 to 9 do
                begin                            for xp:=1 to 19 do
                begin write(f[xp,yp]); if xp=19 then
                begin                          gotoxy(x,y+yp);
                end;end;end;end;
             9: begin x:=67; y:=32; gotoxy(x,y); for yp:=1 to 9 do
                begin                            for xp:=1 to 19 do
                begin write(f[xp,yp]); if xp=19 then
                begin                          gotoxy(x,y+yp);
                end;end;end;end;
end;end;

5: begin
case jaky of 1: begin x:=11; y:=4; gotoxy(x,y); for yp:=1 to 9 do
                begin                            for xp:=1 to 19 do
                begin write(f[xp,yp]); if xp=19 then
                begin                           gotoxy(x,y+yp);
                end;end;end;end;
             2: begin x:=30; y:=4; gotoxy(x,y); for yp:=1 to 9 do
                begin                            for xp:=1 to 19 do
                begin write(f[xp,yp]); if xp=19 then
                begin                           gotoxy(x,y+yp);
                end;end;end;end;
             3: begin x:=49; y:=4; gotoxy(x,y); for yp:=1 to 9 do
                begin                            for xp:=1 to 19 do
                begin write(f[xp,yp]); if xp=19 then
                begin                           gotoxy(x,y+yp);
                end;end;end;end;
             4: begin x:=68; y:=4; gotoxy(x,y); for yp:=1 to 9 do
                begin                            for xp:=1 to 19 do
                begin write(f[xp,yp]); if xp=19 then
                begin                           gotoxy(x,y+yp);
                end;end;end;end;
             5: begin x:=87; y:=4; gotoxy(x,y); for yp:=1 to 9 do
                begin                            for xp:=1 to 19 do
                begin write(f[xp,yp]); if xp=19 then
                begin                           gotoxy(x,y+yp);
                end;end;end;end;
             6: begin x:=11; y:=13; gotoxy(x,y); for yp:=1 to 9 do
                begin                            for xp:=1 to 19 do
                begin write(f[xp,yp]); if xp=19 then
                begin                          gotoxy(x,y+yp);
                end;end;end;end;
             7: begin x:=30; y:=13; gotoxy(x,y); for yp:=1 to 9 do
                begin                            for xp:=1 to 19 do
                begin write(f[xp,yp]); if xp=19 then
                begin                          gotoxy(x,y+yp);
                end;end;end;end;
             8: begin x:=49; y:=13; gotoxy(x,y); for yp:=1 to 9 do
                begin                            for xp:=1 to 19 do
                begin write(f[xp,yp]); if xp=19 then
                begin                          gotoxy(x,y+yp);
                end;end;end;end;
             9: begin x:=68; y:=13; gotoxy(x,y); for yp:=1 to 9 do
                begin                            for xp:=1 to 19 do
                begin write(f[xp,yp]); if xp=19 then
                begin                          gotoxy(x,y+yp);
                end;end;end;end;
             10: begin x:=87; y:=13; gotoxy(x,y); for yp:=1 to 9 do
                begin                            for xp:=1 to 19 do
                begin  write(f[xp,yp]); if xp=19 then
                begin                            gotoxy(x,y+yp);
                end;end;end;end;
             11: begin x:=11; y:=22; gotoxy(x,y); for yp:=1 to 9 do
                begin                            for xp:=1 to 19 do
                begin write(f[xp,yp]); if xp=19 then
                begin                           gotoxy(x,y+yp);
                end;end;end;end;
             12: begin x:=30; y:=22; gotoxy(x,y); for yp:=1 to 9 do
                begin                            for xp:=1 to 19 do
                begin write(f[xp,yp]); if xp=19 then
                begin                           gotoxy(x,y+yp);
                end;end;end;end;
             13: begin x:=49; y:=22; gotoxy(x,y); for yp:=1 to 9 do
                begin                            for xp:=1 to 19 do
                begin write(f[xp,yp]); if xp=19 then
                begin                           gotoxy(x,y+yp);
                end;end;end;end;
             14: begin x:=68; y:=22; gotoxy(x,y); for yp:=1 to 9 do
                begin                            for xp:=1 to 19 do
                begin write(f[xp,yp]); if xp=19 then
                begin                           gotoxy(x,y+yp);
                end;end;end;end;
             15: begin x:=87; y:=22; gotoxy(x,y); for yp:=1 to 9 do
                begin                            for xp:=1 to 19 do
                begin write(f[xp,yp]); if xp=19 then
                begin                           gotoxy(x,y+yp);
                end;end;end;end;
             16: begin x:=11; y:=31; gotoxy(x,y); for yp:=1 to 9 do
                begin                            for xp:=1 to 19 do
                begin write(f[xp,yp]); if xp=19 then
                begin                           gotoxy(x,y+yp);
                end;end;end;end;
             17: begin x:=30; y:=31; gotoxy(x,y); for yp:=1 to 9 do
                begin                            for xp:=1 to 19 do
                begin write(f[xp,yp]); if xp=19 then
                begin                           gotoxy(x,y+yp);
                end;end;end;end;
             18: begin x:=49; y:=31; gotoxy(x,y); for yp:=1 to 9 do
                begin                            for xp:=1 to 19 do
                begin write(f[xp,yp]); if xp=19 then
                begin                           gotoxy(x,y+yp);
                end;end;end;end;
             19: begin x:=68; y:=31; gotoxy(x,y); for yp:=1 to 9 do
                begin                            for xp:=1 to 19 do
                begin write(f[xp,yp]); if xp=19 then
                begin                           gotoxy(x,y+yp);
                end;end;end;end;
             20: begin x:=87; y:=31; gotoxy(x,y); for yp:=1 to 9 do
                begin                            for xp:=1 to 19 do
                begin write(f[xp,yp]); if xp=19 then
                begin                           gotoxy(x,y+yp);
                end;end;end;end;
             21: begin x:=11; y:=40; gotoxy(x,y); for yp:=1 to 9 do
                begin                            for xp:=1 to 19 do
                begin write(f[xp,yp]); if xp=19 then
                begin                           gotoxy(x,y+yp);
                end;end;end;end;
             22: begin x:=30; y:=40; gotoxy(x,y); for yp:=1 to 9 do
                begin                            for xp:=1 to 19 do
                begin write(f[xp,yp]); if xp=19 then
                begin                          gotoxy(x,y+yp);
                end;end;end;end;
             23: begin x:=49; y:=40; gotoxy(x,y); for yp:=1 to 9 do
                begin                            for xp:=1 to 19 do
                begin write(f[xp,yp]); if xp=19 then
                begin                          gotoxy(x,y+yp);
                end;end;end;end;
             24: begin x:=68; y:=40; gotoxy(x,y); for yp:=1 to 9 do
                begin                            for xp:=1 to 19 do
                begin write(f[xp,yp]); if xp=19 then
                begin                          gotoxy(x,y+yp);
                end;end;end;end;
             25: begin x:=87; y:=40; gotoxy(x,y); for yp:=1 to 9 do
                begin                            for xp:=1 to 19 do
                begin write(f[xp,yp]); if xp=19 then
                begin                          gotoxy(x,y+yp);
                end;end;end;end;
end;end;

end;
end;
//<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>//
procedure nahodne_prirad;
{n·hodnÏ p¯i¯adÌ sou¯adnicÌm [1...4;1...4]/... ËÌsla od 1 do 16/...}
var sestnact: array [1..16]of integer;
    devet: array [1..9]of integer;
    dvacetpet: array [1..25]of integer;
    c,rn,rl,x,y: integer;
begin pocettahu:=0;case obtiznost of

4:
begin
begin
for c:=1 to 16 do begin sestnact[c]:=c; end;
{priradi do retezce sestnact cisla 1-16}
end;
begin for y:=1 to 4 do
begin for x:=1 to 4 do
begin
randomize;
begin repeat begin rl:=(1+random(16)); rn:=sestnact[rl]; end; until rn<>0; end;
cislo[x,y]:=rn; sestnact[rn]:=0;
{priradi nulu na misto v retezci, ze ktereho je uz cislo pouzito, dale si
program nuly nebere, takze si postupne vybere vsechna cisla a neopakuji se}
end;end;end; cislohra:=cislo;
end;

3:
begin
begin
for c:=1 to 9 do begin devet[c]:=c; end;
{priradi do retezce sestnact cisla 1-9}
end;
begin for y:=1 to 3 do
begin for x:=1 to 3 do
begin
randomize;
begin repeat begin rl:=(1+random(9)); rn:=devet[rl]; end; until rn<>0; end;
cislo3[x,y]:=rn; devet[rn]:=0;
{priradi nulu na misto v retezci, ze ktereho je uz cislo pouzito, dale si
program nuly nebere, takze si postupne vybere vsechna cisla a neopakuji se}
end;end;end; cislohra3:=cislo3;
end;

5:
begin
begin
for c:=1 to 25 do begin dvacetpet[c]:=c; end;
{priradi do retezce sestnact cisla 1-25}
end;
begin for y:=1 to 5 do
begin for x:=1 to 5 do
begin
randomize;
begin repeat begin rl:=(1+random(25)); rn:=dvacetpet[rl]; end; until rn<>0; end;
cislo5[x,y]:=rn; dvacetpet[rn]:=0;
{priradi nulu na misto v retezci, ze ktereho je uz cislo pouzito, dale si
program nuly nebere, takze si postupne vybere vsechna cisla a neopakuji se}
end;end;end; cislohra5:=cislo5;
end;

end;end;
//<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>//
procedure vypiscisla; {vypÌöe ËÌsla doprost¯ed Ëtverc˘, cislo 16/9/25 vypise cerne}
var x,y,xp,yp:integer;

begin case obtiznost of

4:
begin
textcolor(white);cursoroff;
y:=14;
begin for yp:=1 to 4 do begin x:=29;
begin for xp:=1 to 4 do
begin gotoxy(x,y); if cislohra[xp,yp]=16 then textcolor(black);
write(cislohra[xp,yp]);x:=x+19; textcolor(white);
begin if xp=4 then y:=y+9 end;
end;end;end;end;end;

3:
begin
textcolor(white);cursoroff;
y:=18;
begin for yp:=1 to 3 do begin x:=38;
begin for xp:=1 to 3 do
begin gotoxy(x,y); if cislohra3[xp,yp]=9 then textcolor(black);
write(cislohra3[xp,yp]);x:=x+19; textcolor(white);
begin if xp=3 then y:=y+9 end;
end;end;end;end;end;

5:
begin
textcolor(white);cursoroff;
y:=8;
begin for yp:=1 to 5 do begin x:=20;
begin for xp:=1 to 5 do
begin gotoxy(x,y); if cislohra5[xp,yp]=25 then textcolor(black);
write(cislohra5[xp,yp]);x:=x+19; textcolor(white);
begin if xp=5 then y:=y+9 end;
end;end;end;end;end;

end;end;

//<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>//

procedure vypisdilky; {vypise vsechny ctverce}
var poc:integer;
begin textcolor(cyan);cursoroff;
case obtiznost of
4: begin for poc:=1 to 16 do dilek(poc);end;
3: begin for poc:=1 to 9 do dilek(poc);end;
5: begin for poc:=1 to 25 do dilek(poc);end;
end; end;
//<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>//
procedure sixteen; {zkontroluje, kde je cislo 16 a vymaze jeho ctverec}
var x,y,poc:integer;

begin case obtiznost of
4:
begin poc:=0;
begin for y:=1 to 4 do
begin for x:=1 to 4 do
begin poc:=poc+1; if cislohra[x,y]=16 then begin textcolor(black); dilek(poc);
end;end;end;end;end;

3:
begin poc:=0;
begin for y:=1 to 3 do
begin for x:=1 to 3 do
begin poc:=poc+1; if cislohra3[x,y]=9 then begin textcolor(black); dilek(poc);
end;end;end;end;end;

5:
begin poc:=0;
begin for y:=1 to 5 do
begin for x:=1 to 5 do
begin poc:=poc+1; if cislohra5[x,y]=25 then begin textcolor(black); dilek(poc);
end;end;end;end;end;

end;end;
//<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>//
procedure priradvypis;
{vypise ctverce, vypise vsechna cisla a smaze cislo 16/9/25 a jeho ctverec}
{po celou hru se po kaûdÈm tahu opakouje}
begin vypisdilky;sixteen;vypiscisla;end;
//<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>//
procedure pravidlo; {zjiöùuje poËet inverzÌ v permutaci ËÌsel}
var x,y,a,schr,iks,yps:integer;

begin case obtiznost of

4:
begin
pi:=0; a:=1; {pi=pocet inverzi, a=hledane cislo}
begin
for yps:=1 to 4 do
begin
for iks:=1 to 4 do
begin
if cislo[iks,yps]=a then begin a:=a+1; end else
begin
randomize; repeat begin x:=1+random(4);y:=1+random(4); end; until cislo[x,y]=a;
{n·hodnÏ zkouöÌ sou¯adnice x a y, dokud nenajde ty, kde leûÌ ËÌslo a}
begin
schr:=cislo[iks,yps];cislo[iks,yps]:=cislo[x,y];cislo[x,y]:=schr;
pi:=pi+1;a:=a+1;
end;end;end;end;end;end;

3:
begin
pi:=0; a:=1; {pi=pocet inverzi, a=hledane cislo}
begin
for yps:=1 to 3 do
begin
for iks:=1 to 3 do
begin
if cislo3[iks,yps]=a then begin a:=a+1; end else
begin
randomize; repeat begin x:=1+random(3);y:=1+random(3); end; until cislo3[x,y]=a;
{n·hodnÏ zkouöÌ sou¯adnice x a y, dokud nenajde ty, kde leûÌ ËÌslo a}
begin
schr:=cislo3[iks,yps];cislo3[iks,yps]:=cislo3[x,y];cislo3[x,y]:=schr;
pi:=pi+1;a:=a+1;
end;end;end;end;end;end;

5:
begin
pi:=0; a:=1; {pi=pocet inverzi, a=hledane cislo}
begin
for yps:=1 to 5 do
begin
for iks:=1 to 5 do
begin
if cislo5[iks,yps]=a then begin a:=a+1; end else
begin
randomize; repeat begin x:=1+random(5);y:=1+random(5); end; until cislo5[x,y]=a;
{n·hodnÏ zkouöÌ sou¯adnice x a y, dokud nenajde ty, kde leûÌ ËÌslo a}
begin
schr:=cislo5[iks,yps];cislo5[iks,yps]:=cislo5[x,y];cislo5[x,y]:=schr;
pi:=pi+1;a:=a+1;
end;end;end;end;end;end;

end;end;
//<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>//
procedure ManhMe;
{zjisti vzdalenost prazdneho pole (16)
od praveho dolniho rohu Manhattanskou metrikou}
var x,y:integer ;

begin case obtiznost of

4:
begin for y:=1 to 4 do begin for x:=1 to 4 do begin
if cislohra[x,y]=16 then md:=(4-x)+(4-y) end;end;end;

3:
begin for y:=1 to 3 do begin for x:=1 to 3 do begin
if cislohra3[x,y]=9 then md:=(3-x)+(3-y) end;end;end;

5:
begin for y:=1 to 5 do begin for x:=1 to 5 do begin
if cislohra5[x,y]=25 then md:=(5-x)+(5-y) end;end;end;

end;end;
//<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>//
procedure zkouska;
{zepta se, zda souËet poËtu inverzÌ v permutaci ËÌsel
a vzd·lenosti cisla 16 od praveho dolniho rohu je  sud˝ (1) nebo ne (0)}
var z:integer;
{z=zbytek po dÏlenÌ souËtu poËtu inverzÌ v permutaci a MD ËÌsla 16}
begin begin pravidlo;ManhMe;z:=((pi+md) mod 2);if z=0 then ID:=1 else ID:=0 end; if pi+md=0 then ID:=0; end;
//<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>//
procedure prirad_spravne;
begin repeat nahodne_prirad;zkouska; until ID=1; end;
//<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>//
procedure loading; {naznacuje nacitani hry pomoci znaku o O o,...,trva cca 6s}
var poc,del,dels:integer;
begin
cursoroff;
del:=400;dels:=100; delay(del);gotoxy(54,26);write('Nacitani...');
for poc:=1 to 11 do begin
gotoxy(56,25);beep(440,dels);write('O o o'); delay(del);gotoxy(56,25);beep(550,dels); write('o O o'); delay(del);gotoxy(56,25);beep(660,dels); write('o o O'); delay(del);
poc:=poc+1; if poc=10 then begin textcolor(black);del:=0;dels:=0;gotoxy(54,26);write('Nacitani...'); end; end;textcolor(white); end;
//<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>//
procedure ohrlogin; {ohranici login}
var poci,pocy,pos:integer; {pocitadla a posunuti}
begin
cursoroff;pos:=0;
gotoxy(40,13); write(chr(218)); for poci:=41 to 74 do write(chr(196));
write(chr(191)); {horni rada}
for pocy:=14 to 17 do begin pos:=pos+1; for poci:=41 to 74 do
begin gotoxy(40,13+pos); write(chr(179)); gotoxy(75,13+pos);
write(chr(179));  end; end; {okraje}
gotoxy(40,18); write(chr(192));
for poci:=41 to 74 do write(chr(196)); write(chr(217)); {spodni rada}
end;
//<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>//
procedure ohruziv; {ohranici jmeno uzivatele}
var poci,pocy,pos:integer; {pocitadla a posunuti}
begin
cursoroff;pos:=0;
gotoxy(43,15); write(chr(218)); for poci:=44 to 71 do write(chr(196));
write(chr(191)); {horni rada}
for pocy:=15 to 16 do begin pos:=pos+1; for poci:=44 to 73 do
begin gotoxy(43,15+pos); write(chr(179)); gotoxy(72,15+pos);
write(chr(179));  end; end; {okraje}
gotoxy(43,17); write(chr(192));
for poci:=44 to 71 do write(chr(196)); write(chr(217)); {spodni rada}
end;
//<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>//
procedure jmenouzi;
{Necha uzivatele napsat jmeno do radku, ten smi obsahovat pouze
mala a velka pismena a cisla. Backspace neumozni, pokud je souradnice X=<50,
maximalni delka retezce je 16}
label again,enter,smazat;
var ch,ente:char; poc:integer;

begin poc:=1; gotoxy(50,16); cursoron;
repeat again: begin  ch:=readkey;

case ch of
{cisla}
#48	:	begin uzivatel[poc]:=ch;write(uzivatel[poc]);poc:=poc+1; end;
#49	:	begin uzivatel[poc]:=ch;write(uzivatel[poc]);poc:=poc+1; end;
#50	:	begin uzivatel[poc]:=ch;write(uzivatel[poc]);poc:=poc+1; end;
#51	:	begin uzivatel[poc]:=ch;write(uzivatel[poc]);poc:=poc+1; end;
#52	:	begin uzivatel[poc]:=ch;write(uzivatel[poc]);poc:=poc+1; end;
#53	:	begin uzivatel[poc]:=ch;write(uzivatel[poc]);poc:=poc+1; end;
#54	:	begin uzivatel[poc]:=ch;write(uzivatel[poc]);poc:=poc+1; end;
#55	:	begin uzivatel[poc]:=ch;write(uzivatel[poc]);poc:=poc+1; end;
#56	:	begin uzivatel[poc]:=ch;write(uzivatel[poc]);poc:=poc+1; end;
#57	:	begin uzivatel[poc]:=ch;write(uzivatel[poc]);poc:=poc+1; end;
{/cisla}
{malapismena}
#97	    :	begin uzivatel[poc]:=ch;write(uzivatel[poc]);poc:=poc+1; end;
#98	    :	begin uzivatel[poc]:=ch;write(uzivatel[poc]);poc:=poc+1; end;
#99	    :	begin uzivatel[poc]:=ch;write(uzivatel[poc]);poc:=poc+1; end;
#100	:	begin uzivatel[poc]:=ch;write(uzivatel[poc]);poc:=poc+1; end;
#101	:	begin uzivatel[poc]:=ch;write(uzivatel[poc]);poc:=poc+1; end;
#102	:	begin uzivatel[poc]:=ch;write(uzivatel[poc]);poc:=poc+1; end;
#103	:	begin uzivatel[poc]:=ch;write(uzivatel[poc]);poc:=poc+1; end;
#104	:	begin uzivatel[poc]:=ch;write(uzivatel[poc]);poc:=poc+1; end;
#105	:	begin uzivatel[poc]:=ch;write(uzivatel[poc]);poc:=poc+1; end;
#106	:	begin uzivatel[poc]:=ch;write(uzivatel[poc]);poc:=poc+1; end;
#107	:	begin uzivatel[poc]:=ch;write(uzivatel[poc]);poc:=poc+1; end;
#108	:	begin uzivatel[poc]:=ch;write(uzivatel[poc]);poc:=poc+1; end;
#109	:	begin uzivatel[poc]:=ch;write(uzivatel[poc]);poc:=poc+1; end;
#110	:	begin uzivatel[poc]:=ch;write(uzivatel[poc]);poc:=poc+1; end;
#111	:	begin uzivatel[poc]:=ch;write(uzivatel[poc]);poc:=poc+1; end;
#112	:	begin uzivatel[poc]:=ch;write(uzivatel[poc]);poc:=poc+1; end;
#113	:	begin uzivatel[poc]:=ch;write(uzivatel[poc]);poc:=poc+1; end;
#114	:	begin uzivatel[poc]:=ch;write(uzivatel[poc]);poc:=poc+1; end;
#115	:	begin uzivatel[poc]:=ch;write(uzivatel[poc]);poc:=poc+1; end;
#116	:	begin uzivatel[poc]:=ch;write(uzivatel[poc]);poc:=poc+1; end;
#117	:	begin uzivatel[poc]:=ch;write(uzivatel[poc]);poc:=poc+1; end;
#118	:	begin uzivatel[poc]:=ch;write(uzivatel[poc]);poc:=poc+1; end;
#119	:	begin uzivatel[poc]:=ch;write(uzivatel[poc]);poc:=poc+1; end;
#120	:	begin uzivatel[poc]:=ch;write(uzivatel[poc]);poc:=poc+1; end;
#121	:	begin uzivatel[poc]:=ch;write(uzivatel[poc]);poc:=poc+1; end;
#122	:	begin uzivatel[poc]:=ch;write(uzivatel[poc]);poc:=poc+1; end;
{/malapismena}
{velkapismena}
#65	:	begin uzivatel[poc]:=ch;write(uzivatel[poc]);poc:=poc+1; end;
#66	:	begin uzivatel[poc]:=ch;write(uzivatel[poc]);poc:=poc+1; end;
#67	:	begin uzivatel[poc]:=ch;write(uzivatel[poc]);poc:=poc+1; end;
#68	:	begin uzivatel[poc]:=ch;write(uzivatel[poc]);poc:=poc+1; end;
#69	:	begin uzivatel[poc]:=ch;write(uzivatel[poc]);poc:=poc+1; end;
#70	:	begin uzivatel[poc]:=ch;write(uzivatel[poc]);poc:=poc+1; end;
#71	:	begin uzivatel[poc]:=ch;write(uzivatel[poc]);poc:=poc+1; end;
#72	:	begin uzivatel[poc]:=ch;write(uzivatel[poc]);poc:=poc+1; end;
#73	:	begin uzivatel[poc]:=ch;write(uzivatel[poc]);poc:=poc+1; end;
#74	:	begin uzivatel[poc]:=ch;write(uzivatel[poc]);poc:=poc+1; end;
#75	:	begin uzivatel[poc]:=ch;write(uzivatel[poc]);poc:=poc+1; end;
#76	:	begin uzivatel[poc]:=ch;write(uzivatel[poc]);poc:=poc+1; end;
#77	:	begin uzivatel[poc]:=ch;write(uzivatel[poc]);poc:=poc+1; end;
#78	:	begin uzivatel[poc]:=ch;write(uzivatel[poc]);poc:=poc+1; end;
#79	:	begin uzivatel[poc]:=ch;write(uzivatel[poc]);poc:=poc+1; end;
#80	:	begin uzivatel[poc]:=ch;write(uzivatel[poc]);poc:=poc+1; end;
#81	:	begin uzivatel[poc]:=ch;write(uzivatel[poc]);poc:=poc+1; end;
#82	:	begin uzivatel[poc]:=ch;write(uzivatel[poc]);poc:=poc+1; end;
#83	:	begin uzivatel[poc]:=ch;write(uzivatel[poc]);poc:=poc+1; end;
#84	:	begin uzivatel[poc]:=ch;write(uzivatel[poc]);poc:=poc+1; end;
#85	:	begin uzivatel[poc]:=ch;write(uzivatel[poc]);poc:=poc+1; end;
#86	:	begin uzivatel[poc]:=ch;write(uzivatel[poc]);poc:=poc+1; end;
#87	:	begin uzivatel[poc]:=ch;write(uzivatel[poc]);poc:=poc+1; end;
#88	:	begin uzivatel[poc]:=ch;write(uzivatel[poc]);poc:=poc+1; end;
#89	:	begin uzivatel[poc]:=ch;write(uzivatel[poc]);poc:=poc+1; end;
#90	:	begin uzivatel[poc]:=ch;write(uzivatel[poc]);poc:=poc+1; end;
{/velkapismena}
{dalsiznaky}
#8  : smazat: begin if wherex<51 then begin sound(200);goto again; end else begin uzivatel[poc-1]:=' ';poc:=poc-1; gotoxy(49+poc,16);write(uzivatel[poc]);gotoxy(49+poc,16); goto again; end; end;
#13 : begin if poc>1 then goto enter else goto again; end;
{/dalsiznaky}
end;
end; until poc=17;
repeat begin ente:=readkey; if ente=#8 then goto smazat end; until ente=#13;
enter: begin uzivatel:=(uzivatel[1]+uzivatel[2]+uzivatel[3]+uzivatel[4]+uzivatel[5]+uzivatel[6]+uzivatel[7]+uzivatel[8]
+uzivatel[9]+uzivatel[10]+uzivatel[11]+uzivatel[12]+uzivatel[13]+uzivatel[14]+uzivatel[15]
+uzivatel[16]);cursoroff;Window(2,13,100,23); Clrscr; window(1,1,120,60); end;

end;

//<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>//
procedure login;
{vypise pomoci procedur nazev hry, ohraniceni loginu a pole pro psani}
begin
nazev;ohrlogin;ohruziv;
gotoxy(50,14);write('Jmeno uzivatele:');
gotoxy(20,20);write('Zadavat lze pouze velka/mala pismena a cisla. Po zadani jmena stisknete enter.');
jmenouzi;
end;
//<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>//
procedure mezernik; {po nacteni ceka na zmacknuti mezerniku, jinak hru nespusti}
var ch:char;
begin cursoroff;gotoxy(49,26);write('Stisknete mezernik.'); repeat ch:=readkey;
until ch=#32;
begin beep(1000,100);textcolor(black); gotoxy(49,26);write('Stisknete mezernik.');jedna;pet;
p;u;z(1);z(2);l;e;login;end; end;
//<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>//
procedure zacatek;
begin
a:=8;zvuky:=1;
textcolor(cyan);jedna;delay(300);pet;delay(300);textcolor(white);p;delay(300);u;delay(300);
z(1);delay(300);z(2);delay(300);l;delay(300);e;loading;beep(440,100);beep(740,100);mezernik;obtiznost:=4;
end;
//<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>//
procedure tutorial;
var cudlik:char; puvob:integer;
begin
window(2,13,113,49);clrscr;window(1,1,114,50);
puvob:=obtiznost;obtiznost:=3;
cislohra3[1,1]:=1;cislohra3[2,1]:=2;cislohra3[3,1]:=3;cislohra3[1,2]:=4;cislohra3[2,2]:=5;cislohra3[3,2]:=6;
cislohra3[1,3]:=9;cislohra3[2,3]:=7;cislohra3[3,3]:=8; ohraniceni;priradvypis;
gotoxy(14,44);write('Pri stisknuti klaces W,S,A,D nebo sipek se posune na misto prazdneho pole to hraci pole,'); gotoxy(16,45);
write('kteremu jedinemu v pohybu danym smerem nic nebrani. V nasem pripade se pri zmacknuti');
gotoxy(17,46);write('tlacitka A nebo sipky vlevo posune na prazdne misto pole s cislem 7. ');textcolor(yellow);write('Zkuste si to!');
textcolor(white);repeat begin cudlik:=readkey; end; until (cudlik in ['a','K','A']);window(29,32,56,40);clrscr;window(1,1,114,50);

cislohra3[1,3]:=7;cislohra3[2,3]:=9;cislohra3[3,3]:=8;textcolor(cyan);dilek(7);sixteen;textcolor(white);vypiscisla; ;delay(400);window(2,44,113,49);clrscr;window(1,1,114,50);
gotoxy(14,44);write('Vyborne! Cilem hry je seradit cisla vzestupne tak, aby prazdne pole bylo na konci hry'); gotoxy(25,45);write('vzdy v pravem dolnim rohu. ');
textcolor(yellow);write('Nyni zkuste jedinym tahem hru dohrat.');textcolor(white);
repeat begin cudlik:=readkey; end; until (cudlik in ['a','K','A']);
cislohra3[2,3]:=8;cislohra3[3,3]:=9;textcolor(cyan);dilek(8);sixteen;textcolor(white);vypiscisla; ;delay(400);window(2,44,113,49);clrscr;window(1,1,114,50);
gotoxy(22,44);write('Skvele! Nyni jste pripraveni hrat. Na vyber budete mit ze 3 obtiznosti '); gotoxy(23,45);write('(hraci pole 3x3, 4x4 a 5x5).');
textcolor(yellow);write(' Pro navrat do MENU stisknete tlacitko Z.');textcolor(white);
repeat begin cudlik:=readkey; end; until (cudlik in ['Z','z']);window(2,8,113,49);clrscr;window(1,1,114,50);

obtiznost:=puvob;
end;

//<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>//

procedure pridejsiho;
begin case obtiznost of
3: begin

append(tab3);
tabuvs3[11].jmeno:=uzivatel;
writeln(tab3,tabuvs3[11].jmeno);
tabuvs3[11].skore:=pocettahu;
writeln(tab3,tabuvs3[11].skore);
close(tab3);
end;
4: begin
append(tab4);
tabuvs4[11].jmeno:=uzivatel;
writeln(tab4,tabuvs4[11].jmeno);
tabuvs4[11].skore:=pocettahu;
writeln(tab4,tabuvs4[11].skore);
close(tab4);
end;
5: begin
append(tab5);
tabuvs5[11].jmeno:=uzivatel;
writeln(tab5,tabuvs5[11].jmeno);
tabuvs5[11].skore:=pocettahu;
writeln(tab5,tabuvs5[11].skore);
close(tab5);
end;

end;end;

//<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>//

procedure hlmenu;  {vypÌöe hlavnÌ menu hry, uûivatel si vybÌr· pomocÌ öipek nebo tlaËÌtek w(W) a s(S), kterou z poloûku v menu chce zvolit. Po stisknutÌ entru (#13) se volba provede.}
label znovuob,znovuov;
var klavesa:char; volba,volbaob,volbaov,bep:integer; ch:char; x,y,a,schr:integer;

procedure nap_gameover;
var b:integer; cudlik:char;
begin
case obtiznost of
3: begin window(17,8,113,49);clrscr;window(1,1,120,60);cursoroff;s:=23;b:=20;gotoxy(s,b);b:=b+1;
v;v;m;m;m;m;v;v;m;m;v;v;v;v;v;v;m;m;v;v;m;m;m;m;m;m;v;v;m;m;v;v;v;v;v;v;m;m;v;v;v;v;v;v;m;m;m;m;v;v;m;m;v;v;m;m;v;v;v;v;v;v;m;m;v;v;m;m;v;v; gotoxy(s,b);b:=b+1;
v;v;m;m;m;m;v;v;m;m;v;v;v;v;v;v;m;m;v;v;m;m;m;m;m;m;v;v;m;m;v;v;v;v;v;v;m;m;v;v;v;v;v;v;m;m;m;m;v;v;m;m;v;v;m;m;v;v;v;v;v;v;m;m;v;v;m;m;v;v; gotoxy(s,b);b:=b+1;
v;v;m;m;v;v;m;m;m;m;v;v;m;m;v;v;m;m;v;v;v;v;m;m;m;m;v;v;m;m;v;v;m;m;m;m;m;m;v;v;m;m;m;m;m;m;m;m;v;v;m;m;v;v;m;m;v;v;m;m;v;v;m;m;v;v;m;m;v;v; gotoxy(s,b);b:=b+1;
v;v;m;m;v;v;m;m;m;m;v;v;m;m;v;v;m;m;v;v;v;v;m;m;m;m;v;v;m;m;v;v;m;m;m;m;m;m;v;v;m;m;m;m;m;m;m;m;v;v;m;m;v;v;m;m;v;v;m;m;v;v;m;m;v;v;m;m;v;v; gotoxy(s,b);b:=b+1;
v;v;v;v;m;m;m;m;m;m;v;v;m;m;v;v;m;m;v;v;m;m;v;v;m;m;v;v;m;m;v;v;v;v;m;m;m;m;v;v;m;m;m;m;m;m;m;m;v;v;v;v;v;v;m;m;v;v;v;v;m;m;m;m;m;m;v;v;m;m; gotoxy(s,b);b:=b+1;
v;v;v;v;m;m;m;m;m;m;v;v;m;m;v;v;m;m;v;v;m;m;v;v;m;m;v;v;m;m;v;v;v;v;m;m;m;m;v;v;m;m;m;m;m;m;m;m;v;v;v;v;v;v;m;m;v;v;v;v;m;m;m;m;m;m;v;v;m;m; gotoxy(s,b);b:=b+1;
v;v;m;m;v;v;m;m;m;m;v;v;m;m;v;v;m;m;v;v;m;m;m;m;v;v;v;v;m;m;v;v;m;m;m;m;m;m;v;v;m;m;m;m;m;m;m;m;v;v;m;m;v;v;m;m;v;v;m;m;v;v;m;m;m;m;v;v;m;m; gotoxy(s,b);b:=b+1;
v;v;m;m;v;v;m;m;m;m;v;v;m;m;v;v;m;m;v;v;m;m;m;m;v;v;v;v;m;m;v;v;m;m;m;m;m;m;v;v;m;m;m;m;m;m;m;m;v;v;m;m;v;v;m;m;v;v;m;m;v;v;m;m;m;m;v;v;m;m; gotoxy(s,b);b:=b+1;
v;v;m;m;m;m;v;v;m;m;v;v;v;v;v;v;m;m;v;v;m;m;m;m;m;m;v;v;m;m;v;v;v;v;v;v;m;m;v;v;v;v;v;v;m;m;m;m;v;v;m;m;v;v;m;m;v;v;m;m;v;v;m;m;m;m;v;v;m;m; gotoxy(s,b);b:=b+1;
v;v;m;m;m;m;v;v;m;m;v;v;v;v;v;v;m;m;v;v;m;m;m;m;m;m;v;v;m;m;v;v;v;v;v;v;m;m;v;v;v;v;v;v;m;m;m;m;v;v;m;m;v;v;m;m;v;v;m;m;v;v;m;m;m;m;v;v;m;m; gotoxy(s,b);b:=b+1;
gotoxy(20,31);write('Prekrocili jste maximalni pocet tahu. Pro navrat do menu stisknete mezernik.');repeat begin cudlik:=readkey;end;until cudlik=#32;window(17,8,113,49);clrscr;window(1,1,120,60);hlmenu; end;
4: begin window(17,8,113,49);clrscr;window(1,1,120,60);cursoroff;s:=23;b:=20;gotoxy(s,b);b:=b+1;
v;v;m;m;m;m;v;v;m;m;v;v;v;v;v;v;m;m;v;v;m;m;m;m;m;m;v;v;m;m;v;v;v;v;v;v;m;m;v;v;v;v;v;v;m;m;m;m;v;v;m;m;v;v;m;m;v;v;v;v;v;v;m;m;v;v;m;m;v;v; gotoxy(s,b);b:=b+1;
v;v;m;m;m;m;v;v;m;m;v;v;v;v;v;v;m;m;v;v;m;m;m;m;m;m;v;v;m;m;v;v;v;v;v;v;m;m;v;v;v;v;v;v;m;m;m;m;v;v;m;m;v;v;m;m;v;v;v;v;v;v;m;m;v;v;m;m;v;v; gotoxy(s,b);b:=b+1;
v;v;m;m;v;v;m;m;m;m;v;v;m;m;v;v;m;m;v;v;v;v;m;m;m;m;v;v;m;m;v;v;m;m;m;m;m;m;v;v;m;m;m;m;m;m;m;m;v;v;m;m;v;v;m;m;v;v;m;m;v;v;m;m;v;v;m;m;v;v; gotoxy(s,b);b:=b+1;
v;v;m;m;v;v;m;m;m;m;v;v;m;m;v;v;m;m;v;v;v;v;m;m;m;m;v;v;m;m;v;v;m;m;m;m;m;m;v;v;m;m;m;m;m;m;m;m;v;v;m;m;v;v;m;m;v;v;m;m;v;v;m;m;v;v;m;m;v;v; gotoxy(s,b);b:=b+1;
v;v;v;v;m;m;m;m;m;m;v;v;m;m;v;v;m;m;v;v;m;m;v;v;m;m;v;v;m;m;v;v;v;v;m;m;m;m;v;v;m;m;m;m;m;m;m;m;v;v;v;v;v;v;m;m;v;v;v;v;m;m;m;m;m;m;v;v;m;m; gotoxy(s,b);b:=b+1;
v;v;v;v;m;m;m;m;m;m;v;v;m;m;v;v;m;m;v;v;m;m;v;v;m;m;v;v;m;m;v;v;v;v;m;m;m;m;v;v;m;m;m;m;m;m;m;m;v;v;v;v;v;v;m;m;v;v;v;v;m;m;m;m;m;m;v;v;m;m; gotoxy(s,b);b:=b+1;
v;v;m;m;v;v;m;m;m;m;v;v;m;m;v;v;m;m;v;v;m;m;m;m;v;v;v;v;m;m;v;v;m;m;m;m;m;m;v;v;m;m;m;m;m;m;m;m;v;v;m;m;v;v;m;m;v;v;m;m;v;v;m;m;m;m;v;v;m;m; gotoxy(s,b);b:=b+1;
v;v;m;m;v;v;m;m;m;m;v;v;m;m;v;v;m;m;v;v;m;m;m;m;v;v;v;v;m;m;v;v;m;m;m;m;m;m;v;v;m;m;m;m;m;m;m;m;v;v;m;m;v;v;m;m;v;v;m;m;v;v;m;m;m;m;v;v;m;m; gotoxy(s,b);b:=b+1;
v;v;m;m;m;m;v;v;m;m;v;v;v;v;v;v;m;m;v;v;m;m;m;m;m;m;v;v;m;m;v;v;v;v;v;v;m;m;v;v;v;v;v;v;m;m;m;m;v;v;m;m;v;v;m;m;v;v;m;m;v;v;m;m;m;m;v;v;m;m; gotoxy(s,b);b:=b+1;
v;v;m;m;m;m;v;v;m;m;v;v;v;v;v;v;m;m;v;v;m;m;m;m;m;m;v;v;m;m;v;v;v;v;v;v;m;m;v;v;v;v;v;v;m;m;m;m;v;v;m;m;v;v;m;m;v;v;m;m;v;v;m;m;m;m;v;v;m;m; gotoxy(s,b);b:=b+1;
 gotoxy(20,31);write('Prekrocili jste maximalni pocet tahu. Pro navrat do menu stisknete mezernik.');repeat begin cudlik:=readkey;end;until cudlik=#32;window(17,8,113,49);clrscr;window(1,1,120,60);hlmenu; end;
5: begin window(2,2,113,49);clrscr;window(1,1,120,60);nazev;cursoroff;s:=23;b:=20;gotoxy(s,b);b:=b+1;
v;v;m;m;m;m;v;v;m;m;v;v;v;v;v;v;m;m;v;v;m;m;m;m;m;m;v;v;m;m;v;v;v;v;v;v;m;m;v;v;v;v;v;v;m;m;m;m;v;v;m;m;v;v;m;m;v;v;v;v;v;v;m;m;v;v;m;m;v;v; gotoxy(s,b);b:=b+1;
v;v;m;m;m;m;v;v;m;m;v;v;v;v;v;v;m;m;v;v;m;m;m;m;m;m;v;v;m;m;v;v;v;v;v;v;m;m;v;v;v;v;v;v;m;m;m;m;v;v;m;m;v;v;m;m;v;v;v;v;v;v;m;m;v;v;m;m;v;v; gotoxy(s,b);b:=b+1;
v;v;m;m;v;v;m;m;m;m;v;v;m;m;v;v;m;m;v;v;v;v;m;m;m;m;v;v;m;m;v;v;m;m;m;m;m;m;v;v;m;m;m;m;m;m;m;m;v;v;m;m;v;v;m;m;v;v;m;m;v;v;m;m;v;v;m;m;v;v; gotoxy(s,b);b:=b+1;
v;v;m;m;v;v;m;m;m;m;v;v;m;m;v;v;m;m;v;v;v;v;m;m;m;m;v;v;m;m;v;v;m;m;m;m;m;m;v;v;m;m;m;m;m;m;m;m;v;v;m;m;v;v;m;m;v;v;m;m;v;v;m;m;v;v;m;m;v;v; gotoxy(s,b);b:=b+1;
v;v;v;v;m;m;m;m;m;m;v;v;m;m;v;v;m;m;v;v;m;m;v;v;m;m;v;v;m;m;v;v;v;v;m;m;m;m;v;v;m;m;m;m;m;m;m;m;v;v;v;v;v;v;m;m;v;v;v;v;m;m;m;m;m;m;v;v;m;m; gotoxy(s,b);b:=b+1;
v;v;v;v;m;m;m;m;m;m;v;v;m;m;v;v;m;m;v;v;m;m;v;v;m;m;v;v;m;m;v;v;v;v;m;m;m;m;v;v;m;m;m;m;m;m;m;m;v;v;v;v;v;v;m;m;v;v;v;v;m;m;m;m;m;m;v;v;m;m; gotoxy(s,b);b:=b+1;
v;v;m;m;v;v;m;m;m;m;v;v;m;m;v;v;m;m;v;v;m;m;m;m;v;v;v;v;m;m;v;v;m;m;m;m;m;m;v;v;m;m;m;m;m;m;m;m;v;v;m;m;v;v;m;m;v;v;m;m;v;v;m;m;m;m;v;v;m;m; gotoxy(s,b);b:=b+1;
v;v;m;m;v;v;m;m;m;m;v;v;m;m;v;v;m;m;v;v;m;m;m;m;v;v;v;v;m;m;v;v;m;m;m;m;m;m;v;v;m;m;m;m;m;m;m;m;v;v;m;m;v;v;m;m;v;v;m;m;v;v;m;m;m;m;v;v;m;m; gotoxy(s,b);b:=b+1;
v;v;m;m;m;m;v;v;m;m;v;v;v;v;v;v;m;m;v;v;m;m;m;m;m;m;v;v;m;m;v;v;v;v;v;v;m;m;v;v;v;v;v;v;m;m;m;m;v;v;m;m;v;v;m;m;v;v;m;m;v;v;m;m;m;m;v;v;m;m; gotoxy(s,b);b:=b+1;
v;v;m;m;m;m;v;v;m;m;v;v;v;v;v;v;m;m;v;v;m;m;m;m;m;m;v;v;m;m;v;v;v;v;v;v;m;m;v;v;v;v;v;v;m;m;m;m;v;v;m;m;v;v;m;m;v;v;m;m;v;v;m;m;m;m;v;v;m;m; gotoxy(s,b);b:=b+1;
gotoxy(20,31);write('Prekrocili jste maximalni pocet tahu. Pro navrat do menu stisknete mezernik.');repeat begin cudlik:=readkey;end;until cudlik=#32;window(17,8,113,49);clrscr;window(1,1,120,60);hlmenu; end;
end;
end;

procedure koliktahu;
begin case obtiznost of

3: begin cursoroff;gotoxy(82,12);write(pocettahu); if pocettahu>9999 then nap_gameover; end;
4: begin cursoroff;gotoxy(92,8);write(pocettahu);if pocettahu>9999 then nap_gameover;end;
5: begin cursoroff;gotoxy(100,3);write(pocettahu);if pocettahu>9999 then nap_gameover;end;
end;end;

procedure textokolo; {vypise text okolo (uzivatel, pocet tahu, menu,...}
begin case obtiznost of
3: begin gotoxy(70,12);write('Pocet tahu:');gotoxy(29,12);write('Uzivatel:');gotoxy(39,12);write(uzivatel);gotoxy(77,42);write('Znovu - R');gotoxy(29,42);write('Menu - Z'); end;
4: begin gotoxy(80,8);write('Pocet tahu:');gotoxy(20,8);write('Uzivatel:');gotoxy(30,8);write(uzivatel);gotoxy(87,47);write('Znovu - R');gotoxy(20,47);write('Menu - Z'); end;
5: begin gotoxy(88,3);write('Pocet tahu:');gotoxy(12,3);write('Uzivatel:');gotoxy(22,3);write(uzivatel);gotoxy(96,49);write('Znovu - R');gotoxy(12,49);write('Menu - Z'); end;
end;end;


{MENU}
begin
if zvuky=0 then bep:=0 else bep:=1300;
textcolor(yellow);nap_novahra;textcolor(white); nap_obtiznost; nap_ovladani; nap_sinslavy; nap_konec; volba:=1;
repeat begin klavesa:=readkey; begin if (klavesa in ['H','P','w','s','W','S'])
then case klavesa of
'H': begin if volba=1 then begin beep(bep,75);volba:=5; end else begin beep(bep,75);volba:=volba-1; end end;
'W': begin if volba=1 then begin beep(bep,75);volba:=5; end else begin beep(bep,75);volba:=volba-1; end end;
'w': begin if volba=1 then begin beep(bep,75);volba:=5; end else begin beep(bep,75);volba:=volba-1; end end;
'P': begin if volba=5 then begin beep(bep,75);volba:=1; end else begin beep(bep,75);volba:=volba+1; end end;
'S': begin if volba=5 then begin beep(bep,75);volba:=1; end else begin beep(bep,75);volba:=volba+1; end end;
's': begin if volba=5 then begin beep(bep,75);volba:=1; end else begin beep(bep,75);volba:=volba+1; end end;
end;end;
case volba of
1: begin textcolor(yellow);nap_novahra;textcolor(white); nap_obtiznost; nap_ovladani; nap_sinslavy; nap_konec; end;
2: begin nap_novahra;textcolor(yellow); nap_obtiznost; textcolor(white); nap_ovladani; nap_sinslavy; nap_konec; end;
3: begin nap_novahra; nap_obtiznost; textcolor(yellow); nap_ovladani; textcolor(white);  nap_sinslavy; nap_konec; end;
4: begin nap_novahra; nap_obtiznost; nap_ovladani;textcolor(yellow);nap_sinslavy;textcolor(white);nap_konec; end;
5: begin nap_novahra; nap_obtiznost; nap_ovladani;nap_sinslavy;textcolor(yellow);nap_konec;textcolor(white); end;
end;
end; until klavesa=#13;
case volba of

1: begin window(2,9,113,49);clrscr;window(1,1,120,60);
ohraniceni;
prirad_spravne;
priradvypis;
textokolo;
begin case obtiznost of

4:
begin repeat begin

begin
begin
randomize; repeat   {zjisti, kde je 16/9/25, a jestli bude hracem zamysleny tah proveditelny}
begin x:=(1+random(4)); y:=(1+random(4)); end; until cislohra[x,y]=16;end;
begin    {0=nelze provest tah danym smerem, 1=lze provest tah danym smerem}
begin if (y+1)<5 then WW:=1 else WW:=0 end;
begin if (y-1)>0 then SS:=1 else SS:=0 end;
begin if (x+1)<5 then AA:=1 else AA:=0 end;
begin if (x-1)>0 then DD:=1 else DD:=0 end;
end;
begin ch:=readkey;
case ch of
#122 : begin window(17,8,113,49);clrscr;window(1,1,120,60);hlmenu; end;
#90 : begin window(17,8,113,49);clrscr;window(1,1,120,60);hlmenu; end;
#82 : begin textcolor(black);koliktahu;textcolor(white); nahodne_prirad; prirad_spravne; priradvypis; end;
#114 : begin textcolor(black);koliktahu;textcolor(white); nahodne_prirad; prirad_spravne; priradvypis; end;
#119 : begin if WW=1 then begin
schr:=cislohra[x,y+1]; cislohra[x,y+1]:=cislohra[x,y];
cislohra[x,y]:=schr; pocettahu:=pocettahu+1; priradvypis;
end; end;
#87 : begin if WW=1 then begin
schr:=cislohra[x,y+1]; cislohra[x,y+1]:=cislohra[x,y];
cislohra[x,y]:=schr; pocettahu:=pocettahu+1; priradvypis;
end; end;
#72 : begin if WW=1 then begin
schr:=cislohra[x,y+1]; cislohra[x,y+1]:=cislohra[x,y];
cislohra[x,y]:=schr; pocettahu:=pocettahu+1; priradvypis;
end; end;
#115 : begin if SS=1 then begin
schr:=cislohra[x,y-1]; cislohra[x,y-1]:=cislohra[x,y];
cislohra[x,y]:=schr; pocettahu:=pocettahu+1; priradvypis;
end; end;
#83 : begin if SS=1 then begin
schr:=cislohra[x,y-1]; cislohra[x,y-1]:=cislohra[x,y];
cislohra[x,y]:=schr; pocettahu:=pocettahu+1; priradvypis;
end; end;
#80 : begin if SS=1 then begin
schr:=cislohra[x,y-1]; cislohra[x,y-1]:=cislohra[x,y];
cislohra[x,y]:=schr; pocettahu:=pocettahu+1; priradvypis;
end; end;
#97 : begin if AA=1 then begin
schr:=cislohra[x+1,y]; cislohra[x+1,y]:=cislohra[x,y];
cislohra[x,y]:=schr; pocettahu:=pocettahu+1; priradvypis;
end; end;
#65 : begin if AA=1 then begin
schr:=cislohra[x+1,y]; cislohra[x+1,y]:=cislohra[x,y];
cislohra[x,y]:=schr; pocettahu:=pocettahu+1; priradvypis;
end; end;
#75 : begin if AA=1 then begin
schr:=cislohra[x+1,y]; cislohra[x+1,y]:=cislohra[x,y];
cislohra[x,y]:=schr; pocettahu:=pocettahu+1; priradvypis;
end; end;
#100 : begin if DD=1 then begin
schr:=cislohra[x-1,y]; cislohra[x-1,y]:=cislohra[x,y];
cislohra[x,y]:=schr; pocettahu:=pocettahu+1; priradvypis;
end; end;
#68 : begin if DD=1 then begin
schr:=cislohra[x-1,y]; cislohra[x-1,y]:=cislohra[x,y];
cislohra[x,y]:=schr; pocettahu:=pocettahu+1; priradvypis;
end; end;
#77 : begin if DD=1 then begin
schr:=cislohra[x-1,y]; cislohra[x-1,y]:=cislohra[x,y];
cislohra[x,y]:=schr; pocettahu:=pocettahu+1; priradvypis;
end; end;
end;
end;end;
;koliktahu;
a:=1;g:=0;
begin
for y:=1 to 4 do
begin
for x:=1 to 4 do
begin
if cislohra[x,y]=a then begin g:=g+1; a:=a+1; end else a:=a+1 end;end;end;end;
until g=16; begin pact:=4;vyhra;pridejsiho;prectisito;seradsito;smazsito;pact:=0;hlmenu; end; end;

3:
begin repeat begin
begin
begin
randomize; repeat   {zjisti, kde je 16/9/25, a jestli bude hracem zamysleny tah proveditelny}
begin x:=(1+random(3)); y:=(1+random(3)); end; until cislohra3[x,y]=9;end;
begin    {0=nelze provest tah danym smerem, 1=lze provest tah danym smerem}
begin if (y+1)<4 then WW:=1 else WW:=0 end;
begin if (y-1)>0 then SS:=1 else SS:=0 end;
begin if (x+1)<4 then AA:=1 else AA:=0 end;
begin if (x-1)>0 then DD:=1 else DD:=0 end;
end;
begin ch:=readkey;
case ch of
#122 : begin window(17,8,113,49);clrscr;window(1,1,120,60);hlmenu; end;
#90 : begin window(17,8,113,49);clrscr;window(1,1,120,60);hlmenu; end;
#82 : begin textcolor(black);koliktahu;textcolor(white); nahodne_prirad; prirad_spravne; priradvypis; end;
#114 : begin textcolor(black);koliktahu;textcolor(white); nahodne_prirad; prirad_spravne; priradvypis; end;
#119 : begin if WW=1 then begin
schr:=cislohra3[x,y+1]; cislohra3[x,y+1]:=cislohra3[x,y];
cislohra3[x,y]:=schr; pocettahu:=pocettahu+1; priradvypis;
end; end;
#87 : begin if WW=1 then begin
schr:=cislohra3[x,y+1]; cislohra3[x,y+1]:=cislohra3[x,y];
cislohra3[x,y]:=schr; pocettahu:=pocettahu+1; priradvypis;
end; end;
#72 : begin if WW=1 then begin
schr:=cislohra3[x,y+1]; cislohra3[x,y+1]:=cislohra3[x,y];
cislohra3[x,y]:=schr; pocettahu:=pocettahu+1; priradvypis;
end; end;
#115 : begin if SS=1 then begin
schr:=cislohra3[x,y-1]; cislohra3[x,y-1]:=cislohra3[x,y];
cislohra3[x,y]:=schr; pocettahu:=pocettahu+1; priradvypis;
end; end;
#83 : begin if SS=1 then begin
schr:=cislohra3[x,y-1]; cislohra3[x,y-1]:=cislohra3[x,y];
cislohra3[x,y]:=schr; pocettahu:=pocettahu+1; priradvypis;
end; end;
#80 : begin if SS=1 then begin
schr:=cislohra3[x,y-1]; cislohra3[x,y-1]:=cislohra3[x,y];
cislohra3[x,y]:=schr; pocettahu:=pocettahu+1; priradvypis;
end; end;
#97 : begin if AA=1 then begin
schr:=cislohra3[x+1,y]; cislohra3[x+1,y]:=cislohra3[x,y];
cislohra3[x,y]:=schr; pocettahu:=pocettahu+1; priradvypis;
end; end;
#65 : begin if AA=1 then begin
schr:=cislohra3[x+1,y]; cislohra3[x+1,y]:=cislohra3[x,y];
cislohra3[x,y]:=schr; pocettahu:=pocettahu+1; priradvypis;
end; end;
#75 : begin if AA=1 then begin
schr:=cislohra3[x+1,y]; cislohra3[x+1,y]:=cislohra3[x,y];
cislohra3[x,y]:=schr; pocettahu:=pocettahu+1; priradvypis;
end; end;
#100 : begin if DD=1 then begin
schr:=cislohra3[x-1,y]; cislohra3[x-1,y]:=cislohra3[x,y];
cislohra3[x,y]:=schr; pocettahu:=pocettahu+1; priradvypis;
end; end;
#68 : begin if DD=1 then begin
schr:=cislohra3[x-1,y]; cislohra3[x-1,y]:=cislohra3[x,y];
cislohra3[x,y]:=schr; pocettahu:=pocettahu+1; priradvypis;
end; end;
#77 : begin if DD=1 then begin
schr:=cislohra3[x-1,y]; cislohra3[x-1,y]:=cislohra3[x,y];
cislohra3[x,y]:=schr; pocettahu:=pocettahu+1; priradvypis;
end; end;
end;
end;end;
koliktahu;
a:=1;g:=0;
begin
for y:=1 to 3 do
begin
for x:=1 to 3 do
begin
if cislohra3[x,y]=a then begin g:=g+1; a:=a+1; end else a:=a+1 end;end;end;end;
until g=9; begin pact:=3;vyhra;pridejsiho;prectisito;seradsito;smazsito;pact:=0;hlmenu; end; end;

5:
begin repeat begin
begin
begin
randomize; repeat         {zjisti, kde je 16/9/25, a jestli bude hracem zamysleny tah proveditelny}
begin x:=(1+random(5)); y:=(1+random(5)); end; until cislohra5[x,y]=25;end;
begin    {0=nelze provest tah danym smerem, 1=lze provest tah danym smerem}
begin if (y+1)<6 then WW:=1 else WW:=0 end;
begin if (y-1)>0 then SS:=1 else SS:=0 end;
begin if (x+1)<6 then AA:=1 else AA:=0 end;
begin if (x-1)>0 then DD:=1 else DD:=0 end;
end;
begin ch:=readkey;
case ch of
#122 : begin window(2,2,113,49);clrscr;window(1,1,120,60);nazev;hlmenu; end;
#90 : begin window(2,2,113,49);clrscr;window(1,1,120,60);nazev;hlmenu; end;
#82 : begin textcolor(black);koliktahu;textcolor(white); nahodne_prirad; prirad_spravne; priradvypis; end;
#114 : begin textcolor(black);koliktahu;textcolor(white); nahodne_prirad; prirad_spravne; priradvypis; end;
#119 : begin if WW=1 then begin
schr:=cislohra5[x,y+1]; cislohra5[x,y+1]:=cislohra5[x,y];
cislohra5[x,y]:=schr; pocettahu:=pocettahu+1; priradvypis;
end; end;
#87 : begin if WW=1 then begin
schr:=cislohra5[x,y+1]; cislohra5[x,y+1]:=cislohra5[x,y];
cislohra5[x,y]:=schr; pocettahu:=pocettahu+1; priradvypis;
end; end;
#72 : begin if WW=1 then begin
schr:=cislohra5[x,y+1]; cislohra5[x,y+1]:=cislohra5[x,y];
cislohra5[x,y]:=schr; pocettahu:=pocettahu+1; priradvypis;
end; end;
#115 : begin if SS=1 then begin
schr:=cislohra5[x,y-1]; cislohra5[x,y-1]:=cislohra5[x,y];
cislohra5[x,y]:=schr; pocettahu:=pocettahu+1; priradvypis;
end; end;
#83 : begin if SS=1 then begin
schr:=cislohra5[x,y-1]; cislohra5[x,y-1]:=cislohra5[x,y];
cislohra5[x,y]:=schr; pocettahu:=pocettahu+1; priradvypis;
end; end;
#80 : begin if SS=1 then begin
schr:=cislohra5[x,y-1]; cislohra5[x,y-1]:=cislohra5[x,y];
cislohra5[x,y]:=schr; pocettahu:=pocettahu+1; priradvypis;
end; end;
#97 : begin if AA=1 then begin
schr:=cislohra5[x+1,y]; cislohra5[x+1,y]:=cislohra5[x,y];
cislohra5[x,y]:=schr; pocettahu:=pocettahu+1; priradvypis;
end; end;
#65 : begin if AA=1 then begin
schr:=cislohra5[x+1,y]; cislohra5[x+1,y]:=cislohra5[x,y];
cislohra5[x,y]:=schr; pocettahu:=pocettahu+1; priradvypis;
end; end;
#75 : begin if AA=1 then begin
schr:=cislohra5[x+1,y]; cislohra5[x+1,y]:=cislohra5[x,y];
cislohra5[x,y]:=schr; pocettahu:=pocettahu+1; priradvypis;
end; end;
#100 : begin if DD=1 then begin
schr:=cislohra5[x-1,y]; cislohra5[x-1,y]:=cislohra5[x,y];
cislohra5[x,y]:=schr; pocettahu:=pocettahu+1; priradvypis;
end; end;
#77 : begin if DD=1 then begin
schr:=cislohra5[x-1,y]; cislohra5[x-1,y]:=cislohra5[x,y];
cislohra5[x,y]:=schr; pocettahu:=pocettahu+1; priradvypis;
end; end;
#68 : begin if DD=1 then begin
schr:=cislohra5[x-1,y]; cislohra5[x-1,y]:=cislohra5[x,y];
cislohra5[x,y]:=schr; pocettahu:=pocettahu+1; priradvypis;
end; end;
end;
end;end;
koliktahu;
a:=1;g:=0;
begin
for y:=1 to 5 do
begin
for x:=1 to 5 do
begin
if cislohra5[x,y]=a then begin g:=g+1; a:=a+1; end else a:=a+1 end;end;end;end;
until g=25; begin pact:=5;vyhra;pridejsiho;prectisito;seradsito;smazsito;pact:=0;hlmenu; end; end;
end;end;

 end;

{nov· hra na z·kladÏ vybranÈ obtÌûnosti, pokud obtÌûnost nenÌ vybr·na, spustÌ se hra 4x4}
2: begin window(2,9,113,49);clrscr;window(1,1,120,60);               {nastavenÌ obtÌûnosti}
begin textcolor(yellow); nap_lehka; textcolor(white); nap_stredni; nap_tezka; nap_zpet;
case obtiznost of
3: begin textcolor(green);gotoxy(61,15);v;v; textcolor(white); end;
4: begin textcolor(green);gotoxy(65,21);v;v; textcolor(white); end;
5: begin textcolor(green);gotoxy(61,27);v;v; textcolor(white); end;
end;
volbaob:=1;
znovuob: repeat begin klavesa:=readkey; begin if (klavesa in ['H','P','w','s','W','S'])
then case klavesa of
'H': begin if volbaob=1 then begin beep(bep,75);volbaob:=4; end else begin beep(bep,75);volbaob:=volbaob-1; end end;
'W': begin if volbaob=1 then begin beep(bep,75);volbaob:=4; end else begin beep(bep,75);volbaob:=volbaob-1; end end;
'w': begin if volbaob=1 then begin beep(bep,75);volbaob:=4; end else begin beep(bep,75);volbaob:=volbaob-1; end end;
'P': begin if volbaob=4 then begin beep(bep,75);volbaob:=1; end else begin beep(bep,75);volbaob:=volbaob+1; end end;
'S': begin if volbaob=4 then begin beep(bep,75);volbaob:=1; end else begin beep(bep,75);volbaob:=volbaob+1; end end;
's': begin if volbaob=4 then begin beep(bep,75);volbaob:=1; end else begin beep(bep,75);volbaob:=volbaob+1; end end;
end;end;
case volbaob of
1: case obtiznost of
     3:   begin textcolor(yellow); nap_lehka;textcolor(green);gotoxy(61,15);v;v; textcolor(white); nap_stredni; nap_tezka;nap_zpet; end;
     4:   begin textcolor(yellow); nap_lehka; textcolor(white); nap_stredni;textcolor(green);gotoxy(65,21);v;v;textcolor(white); nap_tezka;nap_zpet; end;
     5:   begin textcolor(yellow); nap_lehka; textcolor(white); nap_stredni; nap_tezka;textcolor(green);gotoxy(61,27);v;v;textcolor(white);nap_zpet; end;
   end;
2: case obtiznost of
     3:   begin nap_lehka;textcolor(green);gotoxy(61,15);v;v;textcolor(yellow); nap_stredni;textcolor(white); nap_tezka;nap_zpet; end;
     4:   begin nap_lehka;textcolor(yellow); nap_stredni;textcolor(green);gotoxy(65,21);v;v;textcolor(white); nap_tezka;nap_zpet; end;
     5:   begin nap_lehka;textcolor(yellow); nap_stredni;textcolor(white); nap_tezka;textcolor(green);gotoxy(61,27);v;v;textcolor(white);nap_zpet; end;
   end;
3: case obtiznost of
     3:   begin nap_lehka;textcolor(green);gotoxy(61,15);v;v;textcolor(white);nap_stredni;textcolor(yellow);nap_tezka;textcolor(white);nap_zpet; end;
     4:   begin nap_lehka;nap_stredni;textcolor(green);gotoxy(65,21);v;v;textcolor(yellow);nap_tezka;textcolor(white);nap_zpet; end;
     5:   begin nap_lehka;nap_stredni;textcolor(yellow);nap_tezka;textcolor(green);gotoxy(61,27);v;v;textcolor(white);nap_zpet; end;
   end;
4: case obtiznost of
     3:   begin nap_lehka;textcolor(green);gotoxy(61,15);v;v;textcolor(white);nap_stredni; nap_tezka;textcolor(yellow); nap_zpet;textcolor(white); end;
     4:   begin nap_lehka;nap_stredni;textcolor(green);gotoxy(65,21);v;v;textcolor(white); nap_tezka;textcolor(yellow); nap_zpet;textcolor(white); end;
     5:   begin nap_lehka;nap_stredni; nap_tezka;textcolor(green);gotoxy(61,27);v;v;textcolor(yellow); nap_zpet;textcolor(white); end;
   end;
end;
end; until klavesa=#13;
case volbaob of
1: begin obtiznost:=3;textcolor(green);gotoxy(61,15);v;v;textcolor(white);gotoxy(65,21);v;v;gotoxy(61,27);v;v;goto znovuob; end; {zvolÌ obtiznost 3x3 (e)}
2: begin obtiznost:=4;textcolor(green);gotoxy(65,21);v;v;textcolor(white);gotoxy(61,15);v;v;gotoxy(61,27);v;v;goto znovuob; end; {obtiznost 4x4 (n)}
3: begin obtiznost:=5;textcolor(green);gotoxy(61,27);v;v;textcolor(white);gotoxy(65,21);v;v;gotoxy(61,15);v;v;goto znovuob; end; {obtiznost 5x5 (d)}
4: begin window(2,9,113,49);clrscr;window(1,1,120,60);hlmenu; end; {zpÏt}
end;
end;
end;



3: begin window(2,9,113,49);clrscr;window(1,1,120,60);                    {ovl·d·nÌ (zvuky,popis hry)}
begin textcolor(yellow); nap_jakhrat; textcolor(white); nap_ohre; if zvuky=1 then nap_vypnoutzvuky else nap_zapnoutzvuky; nap_zpet; volbaov:=1;
znovuov: repeat begin klavesa:=readkey; begin if (klavesa in ['H','P','w','s','W','S'])
then case klavesa of
'H': begin if volbaov=1 then begin beep(bep,75);volbaov:=4; end else begin beep(bep,75);volbaov:=volbaov-1; end end;
'W': begin if volbaov=1 then begin beep(bep,75);volbaov:=4; end else begin beep(bep,75);volbaov:=volbaov-1; end end;
'w': begin if volbaov=1 then begin beep(bep,75);volbaov:=4; end else begin beep(bep,75);volbaov:=volbaov-1; end end;
'P': begin if volbaov=4 then begin beep(bep,75);volbaov:=1; end else begin beep(bep,75);volbaov:=volbaov+1; end end;
'S': begin if volbaov=4 then begin beep(bep,75);volbaov:=1; end else begin beep(bep,75);volbaov:=volbaov+1; end end;
's': begin if volbaov=4 then begin beep(bep,75);volbaov:=1; end else begin beep(bep,75);volbaov:=volbaov+1; end end;
end;end;
case volbaov of
1: begin textcolor(yellow); nap_jakhrat; textcolor(white); nap_ohre;if zvuky=0 then nap_zapnoutzvuky else nap_vypnoutzvuky;nap_zpet; end;
2: begin nap_jakhrat;textcolor(yellow); nap_ohre;textcolor(white);if zvuky=0 then nap_zapnoutzvuky else nap_vypnoutzvuky;nap_zpet; end;
3: begin nap_jakhrat;nap_ohre;textcolor(yellow);if zvuky=0 then nap_zapnoutzvuky else nap_vypnoutzvuky;textcolor(white);nap_zpet; end;
4: begin nap_jakhrat;nap_ohre;if zvuky=0 then nap_zapnoutzvuky else nap_vypnoutzvuky;textcolor(yellow); nap_zpet;textcolor(white); end;
end;
end; until klavesa=#13;
case volbaov of
1: begin tutorial;hlmenu; end; {jak hrat}
2: begin window(17,8,113,49);clrscr;window(1,1,120,60);for pocitadloprouzi:=1 to 16 do uzivatel[pocitadloprouzi]:=' ';login;hlmenu;end; {zmena uzivatele}
3: begin if zvuky=1 then zvuky:=0 else zvuky:=1; if zvuky=1 then begin textcolor(yellow); nap_vypnoutzvuky; textcolor(white); end
else begin textcolor(yellow); nap_zapnoutzvuky; textcolor(white); end; if zvuky=0 then bep:=0 else bep:=1300; goto znovuov; end; {vypnout zvuky}
4: begin window(2,9,113,49);clrscr;window(1,1,120,60);hlmenu; end; {zpÏt}
end;
end;
end;



4: begin window(2,9,113,49);clrscr;window(1,1,120,60); {sÌÚ sl·vy - po¯adÌ nejlepöÌch ve 3 kategoriÌch}
begin textcolor(yellow); nap_lehka; textcolor(white); nap_stredni; nap_tezka; nap_zpet; volbaob:=1;
repeat begin klavesa:=readkey; begin if (klavesa in ['H','P','w','s','W','S'])
then case klavesa of
'H': begin if volbaob=1 then begin beep(bep,75);volbaob:=4; end else begin beep(bep,75);volbaob:=volbaob-1; end end;
'W': begin if volbaob=1 then begin beep(bep,75);volbaob:=4; end else begin beep(bep,75);volbaob:=volbaob-1; end end;
'w': begin if volbaob=1 then begin beep(bep,75);volbaob:=4; end else begin beep(bep,75);volbaob:=volbaob-1; end end;
'P': begin if volbaob=4 then begin beep(bep,75);volbaob:=1; end else begin beep(bep,75);volbaob:=volbaob+1; end end;
'S': begin if volbaob=4 then begin beep(bep,75);volbaob:=1; end else begin beep(bep,75);volbaob:=volbaob+1; end end;
's': begin if volbaob=4 then begin beep(bep,75);volbaob:=1; end else begin beep(bep,75);volbaob:=volbaob+1; end end;
end;end;
case volbaob of
1: begin textcolor(yellow); nap_lehka; textcolor(white); nap_stredni; nap_tezka;nap_zpet; end;
2: begin nap_lehka;textcolor(yellow); nap_stredni;textcolor(white); nap_tezka;nap_zpet; end;
3: begin nap_lehka;nap_stredni;textcolor(yellow);nap_tezka;textcolor(white);nap_zpet; end;
4: begin nap_lehka;nap_stredni; nap_tezka;textcolor(yellow); nap_zpet;textcolor(white); end;
end;
end; until klavesa=#13;
case volbaob of
1: begin pact:=3;window(2,9,113,49);clrscr;window(1,1,120,60);textsin;prectisito;vypismito;repeat begin zmack:=readkey; end; until (zmack=#32);window(2,8,113,49);clrscr;window(1,1,114,50);hlmenu; end; {sin slavy lehke obtiznosti}
2: begin pact:=4;window(2,9,113,49);clrscr;window(1,1,120,60);textsin;prectisito;vypismito;repeat begin zmack:=readkey; end; until (zmack=#32);window(2,8,113,49);clrscr;window(1,1,114,50);hlmenu;  end; {sin slavy stredni obtiznosti}
3: begin pact:=5;window(2,9,113,49);clrscr;window(1,1,120,60);textsin;prectisito;vypismito;repeat begin zmack:=readkey; end; until (zmack=#32);window(2,8,113,49);clrscr;window(1,1,114,50);hlmenu;  end; {sin slavy tezke obtiznosti}
4: begin window(2,9,113,49);clrscr;window(1,1,120,60);hlmenu; end; {zpÏt}
end;
end;
end;

5: begin halt; end; {konec}
end;
end;
{/MENU}




begin
assign (tab3, 'zebricek3.txt');
assign (tab4, 'zebricek4.txt');
assign (tab5, 'zebricek5.txt');
 ohrvse; zacatek;hlmenu; end.
