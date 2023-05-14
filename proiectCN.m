function proiectCN()
  figure
  uicontrol('style','text','string','Alegeti o metoda de aproximare:','units','normalized','position',[0 .9 .2 .1])
  %buton pt metode
 tb1=uicontrol('tag','calcbis','string','Metoda Bisectiei','units','normalized','position',[0 .8 .2 .05],'callback',@calculeaza_callback)
 tb2=uicontrol('tag','calccoarda','string','Metoda Coardei','units','normalized','position',[0 .75 .2 .05],'callback',@calculeaza_callback1)
 tb3=uicontrol('tag','calctg','string','Metoda Tangentei','units','normalized','position',[0 .7 .2 .05],'callback',@calculeaza_callback3)
 tb4=uicontrol('tag','calccontr','string','Principiul Contractiei','units','normalized','position',[0 .65 .2 .05],'callback',@calculeaza_callback4) 
 %introducere date
 uicontrol('style','text','string','Introduceti valori pentru urmatoarele variabile:','units','normalized','position',[0 .48 .2 .1])
 uicontrol('style','text','string','a =','units','normalized','position',[0 .42 .05 .05])
 uicontrol('style','edit','tag','introducere_a','units','normalized','position',[.05 .42 .05 .05])
 uicontrol('style','text','string','b =','units','normalized','position',[0 .34 .05 .05])
 uicontrol('style','edit','tag','introducere_b','units','normalized','position',[.05 .34 .05 .05])
 uicontrol('style','text','string','f(x) =','units','normalized','position',[0 .26 .05 .05])
 uicontrol('style','edit','tag','introducere_f','units','normalized','position',[.05 .26 .05 .05])
 %reset button
 uicontrol('tag','resetare','string','Reset','units','normalized','position',[.05 .1 .1 .1],'callback',@callback_reset)
 
 %criterii_oprire
 uicontrol('style','text','string','Criterii de oprire:','units','normalized','position',[.25 .9 .1 .1])
 uicontrol('style','text','string','Nr. iteratii =','units','normalized','position',[.25 .8 .05 .05])
 uicontrol('style','edit','tag','nr_iteratii','units','normalized','position',[.3 .8 .05 .05])
 uicontrol('style','text','string','Tol =','units','normalized','position',[.25 .7 .05 .05])
 uicontrol('style','edit','tag','toleranta','units','normalized','position',[.3 .7 .05 .05])
 uicontrol('style','text','string','E(n) =','units','normalized','position',[.25 .6 .05 .05])
 uicontrol('style','edit','tag','eroare','units','normalized','position',[.3 .6 .05 .05])
 %valorile solutiilor
 uicontrol('style','text','string','Val. aprox.: xn =','units','normalized','position',[.5 .9 .2 .1])
 uicontrol('style','edit','tag','val_aprox','units','normalized','position',[.7 .9 .1 .1])
 uicontrol('style','text','string','Eroare: abs(xn-fzero) =','units','normalized','position',[.5 .8 .2 .1])
 uicontrol('style','edit','tag','err','units','normalized','position',[.7 .8 .1 .1])
 %timp executie
 uicontrol('style','text','string','Timp executie metoda =','units','normalized','position',[.4 .65 .1 .1])
 uicontrol('style','edit','tag','timp_metoda','units','normalized','position',[.5 .65 .1 .1])
 uicontrol('style','text','string','Timp executie fzero =','units','normalized','position',[.7 .65 .1 .1])
 uicontrol('style','edit','tag','timp_fzero','units','normalized','position',[.8 .65 .1 .1])
 %afisare valori solutie
 uicontrol('style','text','string','Aproximari ale solutiei:','units','normalized','position',[.25 .45 .12 .1])
 multied=uicontrol('style','edit','Max',50,'tag','val_solutii','units','normalized','position',[.25 .2 .12 .25])
end
 
 %backend
function calculeaza_callback(hObject,eventdata)
  valoare1 = get(guihandles.introducere_a, 'string')
  valoare2 = get(guihandles.introducere_b, 'string')
  valoare3 = get(guihandles.introducere_f, 'string')
  
  valoare4 = get(guihandles.nr_iteratii, 'string')
  valoare5 = get(guihandles.toleranta, 'string')
  valoare6 = get(guihandles.eroare, 'string')
  
  if isempty(valoare1) && isempty(valoare2) && isempty(valoare3)
    h = errordlg('Trebuie sa introduceti valori pentru toate campurile!')
    set(h, 'position', [500 500 500 150])
  elseif isempty(valoare1)
    h = errordlg('Introduceti o valoare pentru a!')
    set(h, 'position', [500 500 500 150])
  elseif isempty(valoare2)
    h = errordlg('Introduceti o valoare pentru b!')
    set(h, 'position', [500 500 500 150]) 
  elseif isempty(valoare3)
    h = errordlg('Introduceti functia f')
    set(h, 'position', [500 500 500 150])
  elseif isempty(str2num(valoare1))
     h = errordlg('Trebuie sa introduceti o valoare numerica pentru a!')
    set(h, 'position', [500 500 500 150])
  elseif isempty(str2num(valoare2))
     h = errordlg('Trebuie sa introduceti o valoare numerica pentru b!')
    set(h, 'position', [500 500 500 150])
  elseif (length(str2num(valoare1)) ~= 1)
     h = errordlg('Introduceti o singura valoare pentru a!')
    set(h, 'position', [500 500 500 150])
  elseif (length(str2num(valoare2)) ~= 1)
     h = errordlg('Introduceti o singura valoare pentru b!')
    set(h, 'position', [500 500 500 150])
  elseif str2num(valoare3)
     h=errordlg('Trebuie sa introduceti o functie!')
     set(h, 'position', [500 500 500 150])
  elseif str2num(valoare1) > str2num(valoare2)
      h = warndlg('Introduceti a mai mic ca b!')
      set(h, 'position', [500 500 500 150])
  elseif isempty(valoare4) && isempty(valoare5) && isempty(valoare6)
    h = errordlg('Trebuie sa introduceti cel putin un citeriu de oprire')
    set(h, 'position', [500 500 500 150])
  elseif isempty(str2num(valoare4))
     h = errordlg('Trebuie sa introduceti o valoare numerica pentru nr. de iteratii!')
    set(h, 'position', [500 500 500 150])
  elseif isempty(str2double(valoare4))
     h = errordlg('Trebuie sa introduceti un nr. intreg pentru nr. de iteratii!')
    set(h, 'position', [500 500 500 150])
  elseif (length(str2num(valoare4)) ~= 1)
     h = errordlg('Introduceti o singura valoare pentru nr. de iteratii!')
    set(h, 'position', [500 500 500 150]) 
  elseif isempty(str2num(valoare5))
     h = errordlg('Trebuie sa introduceti o valoare numerica pentru toleranta!')
    set(h, 'position', [500 500 500 150])
  elseif (length(str2num(valoare5)) ~= 1)
     h = errordlg('Introduceti o singura valoare pentru toleranta!')
    set(h, 'position', [500 500 500 150])
  elseif isempty(str2num(valoare6))
     h = errordlg('Trebuie sa introduceti o valoare numerica pentru E(n)!')
    set(h, 'position', [500 500 500 150])
  elseif (length(str2num(valoare6)) ~= 1)
     h = errordlg('Introduceti o singura valoare pentru E(n)!')
    set(h, 'position', [500 500 500 150])
  endif
   
    set(guihandles.calcbis,'string')
   
    set(guihandles.val_aprox,'string',sprintf('%.6f',rezultat()))
    set(guihandles.val_solutii,'string',sprintf('%.6f',rezultat()))
  
 end
function x=metoda_bisectiei(a, b,f,n,er)
  fa=f(a);
  fb=f(b);
  contor=0; 
  t0=clock();
  sec=t0(6)
  while (contor<n) && ((b-a)>er)
    x=(a+b)/2
    fx=f(x);
    if fa*fx<0
      b=x;
      fb=fx;
    elseif fb*fx<0
      a=x;
      fa=fx;
    elseif fx==0
      break;  
   endif
   contor=contor+1;
   
  endwhile
 
   try
    axes(guihandles.axes1)
  catch
    axes('units', 'normalized', 'position', [.4 .1 .5 .5])
  end_try_catch
   plot(x,'-r')
   
  t1=clock();
  sec1=t1(6)
  timp_met=sec1-sec
  set(guihandles.timp_metoda,'String',num2str(timp_met))
  t11=clock();
  sec11=t11(6)
  fz=fzero(f,a+1)
  t2=clock();
  sec2=t2(6)
  timp_fz=sec2-sec11
  set(guihandles.timp_fzero,'String',num2str(timp_fz))
  calc=abs(x-fz)
  set(guihandles.err,'String',num2str(calc))
 end
 
 
 

function rez=rezultat()
  a=get(guihandles.introducere_a,'string')
  aa=str2num(a)
  b=get(guihandles.introducere_b,'string')
  bb=str2num(b)
  f=get(guihandles.introducere_f,'string')
  f=function_handle(sym(f))
  er=get(guihandles.eroare,'string')
  err=str2num(er)
  nit=get(guihandles.nr_iteratii,'string')
  nitt=str2num(nit)
  rez=metoda_bisectiei(aa,bb,f,nitt,err)
  rezz=num2str(rez)
  
end
function calculeaza_callback1(hObject,eventdata)
  valoare1 = get(guihandles.introducere_a, 'string')
  valoare2 = get(guihandles.introducere_b, 'string')
  valoare3 = get(guihandles.introducere_f, 'string')
  
  valoare4 = get(guihandles.nr_iteratii, 'string')
  valoare5 = get(guihandles.toleranta, 'string')
  valoare6 = get(guihandles.eroare, 'string')
  
  if isempty(valoare1) && isempty(valoare2) && isempty(valoare3)
    h = errordlg('Trebuie sa introduceti valori pentru toate campurile!')
    set(h, 'position', [500 500 500 150])
  elseif isempty(valoare1)
    h = errordlg('Introduceti o valoare pentru a!')
    set(h, 'position', [500 500 500 150])
  elseif isempty(valoare2)
    h = errordlg('Introduceti o valoare pentru b!')
    set(h, 'position', [500 500 500 150]) 
  elseif isempty(valoare3)
    h = errordlg('Introduceti functia f')
    set(h, 'position', [500 500 500 150])
  elseif isempty(str2num(valoare1))
     h = errordlg('Trebuie sa introduceti o valoare numerica pentru a!')
    set(h, 'position', [500 500 500 150])
  elseif isempty(str2num(valoare2))
     h = errordlg('Trebuie sa introduceti o valoare numerica pentru b!')
    set(h, 'position', [500 500 500 150])
  elseif (length(str2num(valoare1)) ~= 1)
     h = errordlg('Introduceti o singura valoare pentru a!')
    set(h, 'position', [500 500 500 150])
  elseif (length(str2num(valoare2)) ~= 1)
     h = errordlg('Introduceti o singura valoare pentru b!')
    set(h, 'position', [500 500 500 150])
  elseif str2num(valoare3)
     h=errordlg('Trebuie sa introduceti o functie!')
     set(h, 'position', [500 500 500 150])
  elseif str2num(valoare1) > str2num(valoare2)
      h = warndlg('Introduceti a mai mic ca b!')
      set(h, 'position', [500 500 500 150])
  elseif isempty(valoare4) && isempty(valoare5) && isempty(valoare6)
    h = errordlg('Trebuie sa introduceti cel putin un citeriu de oprire')
    set(h, 'position', [500 500 500 150])
  elseif isempty(str2num(valoare4))
     h = errordlg('Trebuie sa introduceti o valoare numerica pentru nr. de iteratii!')
    set(h, 'position', [500 500 500 150])
  elseif isempty(str2double(valoare4))
     h = errordlg('Trebuie sa introduceti un nr. intreg pentru nr. de iteratii!')
    set(h, 'position', [500 500 500 150])
  elseif (length(str2num(valoare4)) ~= 1)
     h = errordlg('Introduceti o singura valoare pentru nr. de iteratii!')
    set(h, 'position', [500 500 500 150]) 
  elseif isempty(str2num(valoare5))
     h = errordlg('Trebuie sa introduceti o valoare numerica pentru toleranta!')
    set(h, 'position', [500 500 500 150])
  elseif (length(str2num(valoare5)) ~= 1)
     h = errordlg('Introduceti o singura valoare pentru toleranta!')
    set(h, 'position', [500 500 500 150])
  elseif isempty(str2num(valoare6))
     h = errordlg('Trebuie sa introduceti o valoare numerica pentru E(n)!')
    set(h, 'position', [500 500 500 150])
  elseif (length(str2num(valoare6)) ~= 1)
     h = errordlg('Introduceti o singura valoare pentru E(n)!')
    set(h, 'position', [500 500 500 150])
  endif
   
    set(guihandles.calccoarda,'string')
   
    set(guihandles.val_aprox,'string',sprintf('%.6f',rezultat1()))
   
  
 end
function x=met_coardei(a,b,f,n,err)
  pkg load symbolic
  f=get(guihandles.introducere_f,'string')
  f=sym(f)
  fprim=diff(f)
  fsec=diff(fprim);
  f=function_handle(f);
  fprim=function_handle(fprim);
  fsec=function_handle(fsec);
  m1=abs(fprim(a));
  t0=clock();
  sec=t0(6)
  contor=0;
  for i=a:.001:b
    if abs(fprim(i))<m1
      m1=abs(fprim(i));
    endif
  endfor
  if f(a)*fsec(a)<0
    x=a;
    while (contor<n) || (abs(f(x))/m1>err)
      x=x-f(x)*(x-b)/(f(x)-f(b));
      set(guihandles.val_solutii, 'string',num2str(x));
      
      contor=contor+1;
    endwhile
  else
  x=b; 
  while  (contor<n) || (abs(f(x))/m1>err)
    x=x-f(x)*(x-a)/(f(x)-f(a));
    set(guihandles.val_solutii, 'string',num2str(x));
    
    contor=contor+1;
  endwhile
  t1=clock();
  sec1=t1(6)
  timp_met=sec1-sec
  set(guihandles.timp_metoda,'String',num2str(timp_met))
  t11=clock();
  sec11=t11(6)
  
  fz=fzero(f,a)
  t2=clock();
  sec2=t2(6)
  timp_fz=sec2-sec11
  set(guihandles.timp_fzero,'String',num2str(timp_fz))
  calc=abs(x-fz)
  set(guihandles.err,'String',num2str(calc))
 
  endif
  endfunction
 
function rez=rezultat1()
  a=get(guihandles.introducere_a,'string')
  aa=str2num(a)
  b=get(guihandles.introducere_b,'string')
  bb=str2num(b)
  f=get(guihandles.introducere_f,'string')
  er=get(guihandles.eroare,'string')
  err=str2num(er)
  nit=get(guihandles.nr_iteratii,'string')
  nitt=str2num(nit)
  tol=get(guihandles.toleranta,'string')
  toll=str2num(tol)
  rez=met_coardei(aa,bb,f,nitt,err)
  rezz=num2str(rez)
end

function calculeaza_callback3(hObject,eventdata)
  valoare1 = get(guihandles.introducere_a, 'string')
  valoare2 = get(guihandles.introducere_b, 'string')
  valoare3 = get(guihandles.introducere_f, 'string')
  
  valoare4 = get(guihandles.nr_iteratii, 'string')
  valoare5 = get(guihandles.toleranta, 'string')
  valoare6 = get(guihandles.eroare, 'string')
  
  if isempty(valoare1) && isempty(valoare2) && isempty(valoare3)
    h = errordlg('Trebuie sa introduceti valori pentru toate campurile!')
    set(h, 'position', [500 500 500 150])
  elseif isempty(valoare1)
    h = errordlg('Introduceti o valoare pentru a!')
    set(h, 'position', [500 500 500 150])
  elseif isempty(valoare2)
    h = errordlg('Introduceti o valoare pentru b!')
    set(h, 'position', [500 500 500 150]) 
  elseif isempty(valoare3)
    h = errordlg('Introduceti functia f')
    set(h, 'position', [500 500 500 150])
  elseif isempty(str2num(valoare1))
     h = errordlg('Trebuie sa introduceti o valoare numerica pentru a!')
    set(h, 'position', [500 500 500 150])
  elseif isempty(str2num(valoare2))
     h = errordlg('Trebuie sa introduceti o valoare numerica pentru b!')
    set(h, 'position', [500 500 500 150])
  elseif (length(str2num(valoare1)) ~= 1)
     h = errordlg('Introduceti o singura valoare pentru a!')
    set(h, 'position', [500 500 500 150])
  elseif (length(str2num(valoare2)) ~= 1)
     h = errordlg('Introduceti o singura valoare pentru b!')
    set(h, 'position', [500 500 500 150])
  elseif str2num(valoare3)
     h=errordlg('Trebuie sa introduceti o functie!')
     set(h, 'position', [500 500 500 150])
  elseif str2num(valoare1) > str2num(valoare2)
      h = warndlg('Introduceti a mai mic ca b!')
      set(h, 'position', [500 500 500 150])
  elseif isempty(valoare4) && isempty(valoare5) && isempty(valoare6)
    h = errordlg('Trebuie sa introduceti cel putin un citeriu de oprire')
    set(h, 'position', [500 500 500 150])
  elseif isempty(str2num(valoare4))
     h = errordlg('Trebuie sa introduceti o valoare numerica pentru nr. de iteratii!')
    set(h, 'position', [500 500 500 150])
  elseif isempty(str2double(valoare4))
     h = errordlg('Trebuie sa introduceti un nr. intreg pentru nr. de iteratii!')
    set(h, 'position', [500 500 500 150])
  elseif (length(str2num(valoare4)) ~= 1)
     h = errordlg('Introduceti o singura valoare pentru nr. de iteratii!')
    set(h, 'position', [500 500 500 150]) 
  elseif isempty(str2num(valoare5))
     h = errordlg('Trebuie sa introduceti o valoare numerica pentru toleranta!')
    set(h, 'position', [500 500 500 150])
  elseif (length(str2num(valoare5)) ~= 1)
     h = errordlg('Introduceti o singura valoare pentru toleranta!')
    set(h, 'position', [500 500 500 150])
  elseif isempty(str2num(valoare6))
     h = errordlg('Trebuie sa introduceti o valoare numerica pentru E(n)!')
    set(h, 'position', [500 500 500 150])
  elseif (length(str2num(valoare6)) ~= 1)
     h = errordlg('Introduceti o singura valoare pentru E(n)!')
    set(h, 'position', [500 500 500 150])
  endif
   
    set(guihandles.calctg,'string')
   
    
    set(guihandles.val_solutii,'string',sprintf('%.6f\n',rezultat3()))
  
 end
function x=met_tangentei(a,b,f,n,tol,err)
  pkg load symbolic
f=sym(f)
fprim=diff(f);
fsec=diff(fprim);
f=function_handle(f)
fprim=function_handle(fprim);
fsec=function_handle(fsec);

m1=abs(fprim(a));
  for i=a:.001:b
    if abs(fprim(i))<m1
      m1=abs(fprim(i));
    endif
  endfor
m2=abs(fsec(a));

t0=clock();
  sec=t0(6)
 for i=a:.001:b
   if abs(fsec(i))>m2
     m2=abs(fsec(i));
   endif
 endfor
 if f(a)*fsec(a)>0
   x(1)=a;
 else
   x(1)=b;
 endif
 dif=f(x(1))/fprim(x(1));
 x(2)=x(1)-dif;
 nr_iteratii=2;
 while (nr_iteratii<n)&&(dif>tol)&&((m2/(2*m1))*dif^2>err)
   dif=f(x(nr_iteratii))/fprim(x(nr_iteratii));
   x(nr_iteratii+1)=x(nr_iteratii)-dif;
   nr_iteratii=nr_iteratii+1;

   
 endwhile
 
 try
    axes(guihandles.axes1)
  catch
    axes('units', 'normalized', 'position', [.4 .1 .5 .5])
  end_try_catch
   plot(x,'b-')
 y=x(nr_iteratii)
 set(guihandles.val_aprox,'string',num2str(y))
  t1=clock();
  sec1=t1(6)
  timp_met=sec1-sec
  set(guihandles.timp_metoda,'String',num2str(timp_met))
  t11=clock();
  sec11=t11(6)
  fz=fzero(f,a+1)
  
  t2=clock();
  sec2=t2(6)
  timp_fz=sec2-sec11
  set(guihandles.timp_fzero,'String',num2str(timp_fz))
  calc=abs(y-fz)
  set(guihandles.err,'String',num2str(calc))
 end
 
 
 

function rez=rezultat3()
  a=get(guihandles.introducere_a,'string')
  aa=str2num(a)
  b=get(guihandles.introducere_b,'string')
  bb=str2num(b)
  f=get(guihandles.introducere_f,'string')
  er=get(guihandles.eroare,'string')
  err=str2num(er)
  nit=get(guihandles.nr_iteratii,'string')
  nitt=str2num(nit)
  tol=get(guihandles.toleranta,'string')
  toll=str2num(tol)
  rez=met_tangentei(aa,bb,f,nitt,toll,err)
  rezz=num2str(rez)
  
end

function calculeaza_callback4(hObject,eventdata)
  valoare1 = get(guihandles.introducere_a, 'string')
  valoare2 = get(guihandles.introducere_b, 'string')
  valoare3 = get(guihandles.introducere_f, 'string')
  
  valoare4 = get(guihandles.nr_iteratii, 'string')
  valoare5 = get(guihandles.toleranta, 'string')
  valoare6 = get(guihandles.eroare, 'string')
  
  if isempty(valoare1) && isempty(valoare2) && isempty(valoare3)
    h = errordlg('Trebuie sa introduceti valori pentru toate campurile!')
    set(h, 'position', [500 500 500 150])
  elseif isempty(valoare1)
    h = errordlg('Introduceti o valoare pentru a!')
    set(h, 'position', [500 500 500 150])
  elseif isempty(valoare2)
    h = errordlg('Introduceti o valoare pentru b!')
    set(h, 'position', [500 500 500 150]) 
  elseif isempty(valoare3)
    h = errordlg('Introduceti functia f')
    set(h, 'position', [500 500 500 150])
  elseif isempty(str2num(valoare1))
     h = errordlg('Trebuie sa introduceti o valoare numerica pentru a!')
    set(h, 'position', [500 500 500 150])
  elseif isempty(str2num(valoare2))
     h = errordlg('Trebuie sa introduceti o valoare numerica pentru b!')
    set(h, 'position', [500 500 500 150])
  elseif (length(str2num(valoare1)) ~= 1)
     h = errordlg('Introduceti o singura valoare pentru a!')
    set(h, 'position', [500 500 500 150])
  elseif (length(str2num(valoare2)) ~= 1)
     h = errordlg('Introduceti o singura valoare pentru b!')
    set(h, 'position', [500 500 500 150])
  elseif str2num(valoare3)
     h=errordlg('Trebuie sa introduceti o functie!')
     set(h, 'position', [500 500 500 150])
  elseif str2num(valoare1) > str2num(valoare2)
      h = warndlg('Introduceti a mai mic ca b!')
      set(h, 'position', [500 500 500 150])
  elseif isempty(valoare4) && isempty(valoare5) && isempty(valoare6)
    h = errordlg('Trebuie sa introduceti cel putin un citeriu de oprire')
    set(h, 'position', [500 500 500 150])
  elseif isempty(str2num(valoare4))
     h = errordlg('Trebuie sa introduceti o valoare numerica pentru nr. de iteratii!')
    set(h, 'position', [500 500 500 150])
  elseif isempty(str2double(valoare4))
     h = errordlg('Trebuie sa introduceti un nr. intreg pentru nr. de iteratii!')
    set(h, 'position', [500 500 500 150])
  elseif (length(str2num(valoare4)) ~= 1)
     h = errordlg('Introduceti o singura valoare pentru nr. de iteratii!')
    set(h, 'position', [500 500 500 150]) 
  elseif isempty(str2num(valoare5))
     h = errordlg('Trebuie sa introduceti o valoare numerica pentru toleranta!')
    set(h, 'position', [500 500 500 150])
  elseif (length(str2num(valoare5)) ~= 1)
     h = errordlg('Introduceti o singura valoare pentru toleranta!')
    set(h, 'position', [500 500 500 150])
  elseif isempty(str2num(valoare6))
     h = errordlg('Trebuie sa introduceti o valoare numerica pentru E(n)!')
    set(h, 'position', [500 500 500 150])
  elseif (length(str2num(valoare6)) ~= 1)
     h = errordlg('Introduceti o singura valoare pentru E(n)!')
    set(h, 'position', [500 500 500 150])
  endif
   
    set(guihandles.calccontr,'string')
   
    set(guihandles.val_aprox,'string',sprintf('%.6f',rezultat4()))
    set(guihandles.val_solutii,'string',sprintf('%.6f',rezultat4()))
  
 end

 function x=met_contractiei(a,b,f,n,err)
  if a~=Inf
    x0=a
  elseif b~=Inf
    x0=b
  else
    x0=0
  endif
  alpha=0.99;
  x=f(x0)
  er_abs=alpha/(1-alpha)*abs(x-x0);
   n=log(err/abs(x-x0)*(1-alpha))/log(alpha);
 t0=clock();
  sec=t0(6)
  contor=1;
  while (contor<n) || (er_abs>err)
    x=f(x)
    er_abs=alpha*er_abs;
    contor=contor+1;
  endwhile
  try
    axes(guihandles.axes1)
  catch
    axes('units', 'normalized', 'position', [.4 .1 .5 .5])
  end_try_catch
   plot(x,'r-')
  t1=clock();
  sec1=t1(6)
  timp_met=sec1-sec
  set(guihandles.timp_metoda,'String',num2str(timp_met))
  t11=clock();
  sec11=t11(6)
  fz=fzero(f,a)
  t2=clock();
  sec2=t2(6)
  timp_fz=sec2-sec11
  set(guihandles.timp_fzero,'String',num2str(timp_fz))
  calc=abs(x-fz)
  set(guihandles.err,'String',num2str(calc))
 end
  

function rez=rezultat4()
  pkg load symbolic
  a=get(guihandles.introducere_a,'string')
  aa=str2num(a)
  b=get(guihandles.introducere_b,'string')
  bb=str2num(b)
  f=get(guihandles.introducere_f,'string')
  sym(f)
  f=function_handle(sym(f))
  er=get(guihandles.eroare,'string')
  err=str2num(er)
  nit=get(guihandles.nr_iteratii,'string')
  nitt=str2num(nit)
  tol=get(guihandles.toleranta,'string')
  toll=str2num(tol)
  rez=met_contractiei(aa,bb,f,nitt,err)
end
  
 function  callback_reset(hObject,eventdata)
    set(guihandles.introducere_a,'string','')
    set(guihandles.introducere_b,'string','')
    set(guihandles.introducere_f,'string','')
    set(guihandles.val_aprox,'string','')
    set(guihandles.val_solutii,'string','')
    set(guihandles.nr_iteratii,'string','')
    set(guihandles.toleranta,'string','')
    set(guihandles.eroare,'string','')
    set(guihandles.timp_metoda,'string','')
    set(guihandles.timp_fzero,'string','')
    set(guihandles.err,'string','')
    endfunction
 
 





