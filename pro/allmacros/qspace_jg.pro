pro qspace_jg,w,nn,d0,p0,dr,pr,sizex,sizez,neww1,qx,qz,w8,x8,y8,p
print,'readback',nn,d0,p0,dr,pr
close,3
y=size(w)
print,y
TAKE_DATP,P
help,p
if (y(0) eq 3) then begin
   print,y
   
   xsize=y(1)
   ysize=y(2)
   tsize=y(3)

   print,'Three dimensions x,y,t =',xsize,ysize,tsize
   print,'Will sum over the y dimension'
   ww=lonarr(xsize,tsize)
   ww=total(w,2)
   
   
endif else begin
   
   tsize=y(2)
   xsize=y(1)
   print,'Two dimensions x,t =',xsize,tsize
   ww=lonarr(xsize,tsize)
   ww=w
      
endelse

print,'hello world'
print,'no of chans= ',p.p(1),' chan width= ',p.p(6),' tof delay= ',p.p(7)
print,'x1= ',p.p(2),' x2= ',p.p(3),' y1= ',p.p(4),' y2= ',p.p(5)
nx=p.p(8)
ny=p.p(9)
print,'nx= ',nx,' ny= ',ny
print,'chop 1 speed req= ',p.p(10),' chop 1 phase req= ',p.p(11)
print,'chop 2 speed req= ',p.p(12),' chop 2 phase req= ',p.p(13)
print,'chop 1 speed act= ',p.p(14),' chop 1 phase act= ',p.p(15)
print,'chop 2 speed act= ',p.p(16),' chop 2 phase act= ',p.p(17)

; useful chopper variables
openr=45.-(p.p(13)-p.p(11))
opena=45.-(p.p(17)-p.p(15))
opena=opena-1.1
period=60./p.p(14)
dela=(285.-opena-3.3776)/2.
delt=(dela/360.)*period
chopsam=4.1135-(85.e-3)/2.
tofd=chopsam+(p.p(23)/1000.)
chanpa=(tofd/3956.)/(p.p(6)*1e-6)
chanpam=(chopsam/3956.)/(p.p(6)*1e-6)
delchan=delt/(p.p(6)*1e-6)
delechan=p.p(7)/p.p(6)
print,'TOF distance    = ',tofd, ' period chans    =',period/(p.p(6)*1e-6)
print,'channels/Ang    = ',chanpa,' chop del chans  = ',delchan
print,'chopper period  = ',period*1000.,' elec del chans  = ',delechan
print,'opening      req= ',openr,' opening      act= ',opena
print,'chop delay angle= ',dela,' chop delay  time= ',delt*1000.,' ms'
print,'san= ',p.p(24),' deg.','dan= ',p.p(25),' deg.'
san=p.p(24)
dan=p.p(25)
print,' 27A TOF        = ',27.*chanpa,' 4.5A TOF        = ',4.5*chanpa
time=p.p(26)/10.
print,'run time= ',time,' s',' det= ',p.p(23)
det=p.p(23)


print,'well done chaps...'
;make lambda array
yy=indgen(tsize)
;larr=(yy+delechan-delchan)/chanpa
larr=(yy)/chanpa
m=(yy+delechan-delchan)/chanpam



lfirst=(delchan-delechan+0.5)
print,'channel shift = ',lfirst

; loose nn channels at the beginning to avoid infinities in reciprocal space

;nn=1
aa=shift(ww,1,-round(lfirst))

neww1=aa(*,nn:tsize-1)
newlarr=larr(nn:tsize-1)

q=fltarr(xsize,tsize-nn)
th=fltarr(xsize,tsize-nn)
qx=fltarr(xsize,tsize-nn)
qz=fltarr(xsize,tsize-nn)

 

;  conversion to reciprocal space

dpr=180./!pi

pcen=135.79/nx
mmpp=1.04*nx
pmin=150./nx
pmax=233./nx


print,'pcen= ',pcen,' mmpp= ',mmpp
print,'ref th= ',(dr+dpr*atan((pcen-pr)*mmpp/det))/2-(d0+dpr*atan((pcen-p0)*mmpp/det))/2
lmax=max(newlarr)
lmin=min(newlarr)

;expt information d0=dan for diect beam p0=pixel for direct beam
;dr=dan for reflection pr=pixel for reflection



;find limits in reciprocal space

for i=pmin,pmax do begin
  for j=0,tsize-nn-1 do begin
  
;   l=newlarr(j)
   th(i,j)=(dr+dpr*atan((pcen-i)*mmpp/det))/2-(d0+dpr*atan((pcen-p0)*mmpp/det))/2.0
   h1=th(i,j)
   h2=(h1-san)/dpr
   q(i,j)=4*!pi*sin(h1/dpr)/newlarr(j)
   h3=q(i,j)
   qx(i,j)=h3*sin(h2)
   qz(i,j)=h3*cos(h2)

;   l=newlarr(j)
;   th(i,j)=(dr+dpr*atan((pcen-i)*mmpp/det))/2-(d0+dpr*atan((pcen-p0)*mmpp/det))/2
;   q(i,j)=4*!pi*sin(th(i,j)/dpr)/newlarr(j)
;   qx(i,j)=q(i,j)*sin((th(i,j)-san)/dpr)
;   qz(i,j)=q(i,j)*cos((th(i,j)-san)/dpr)

  
   endfor
 endfor

   
  
   print,'limits....'
   print,'thmax= ',max(th),'thmin= ',min(th),'qmin= ',min(q),'qmax= ',max(q)
   print,'qxmax= ',max(qx),'qxmin= ',min(qx),'qzmax= ',max(qz),'qzmin= ',min(qz)



;nfac=1
;sizex=120.*nfac
;sizez=300.*nfac
print,min(qx),max(qx),min(qz),max(qz),sizex,sizez

gs=[(max(qx)*1.001-min(qx))/sizex,(max(qz)*1.001-min(qz))/sizez]

print,gs(0),gs(1),max(qz)/gs(1)

;**********************
;  nicks bit

;  bin neww1 into a square array qx qz of size sizex X sizez

xpixelsize=gs(0)
zpixelsize=gs(1)
minz=min(qz)
minx=min(qx)

x8=indgen(sizex)*xpixelsize + minx
y8=indgen(sizez)*ypixelsize + minz

w8=congrid(neww1, sizex, sizez, /INTERP, /MINUS_ONE)

;print,tsize-nn
;w8=fltarr(sizex,sizez)

;      loop about input array neww1
;          for k=0,xsize-1 do begin
;		i=floor((qx(k,*)-minx)/xpixelsize)
;                j=floor((qz(k,*)-minz)/zpixelsize)
;              
;		w8(i,j)=w8(i,j)+neww1(k,*)
;
;          endfor




print,'done'



;*********************




return

end
