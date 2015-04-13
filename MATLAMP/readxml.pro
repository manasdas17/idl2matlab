;** ********
pro read_xml, FileName , Data , XC=x, YC=y , ZC=z , E=e  , N=n   $
                         , PR=p, PV=pv, PAR_TXT=p_txt            $
                         , W_tit=wt   , X_tit=xt , Y_TIT=yt      $
                         , Z_tit=zt   , OTHER_TIT=ot , SNAP=snap $
                         , SOURCE=src , Img=immg , HIST=his

CATCH,stat & IF stat ne 0 then begin print,!err_string & return & endif
STATUS=24
X=0 & Y=0 & Z=0 & E=0 & N=0 & P=0. & PV=0. & P_TXT='' & time='' & lampF=0
LIM   ="" &  WT='' & XT='' & YT='' & ZT='' & OT='' & SNAP=0 & SRC='' & HIS=''
if Data(0) eq -88 then look=1 else look=0  & Data=0
FileN =FILENAME
imm= 1 & if n_elements(immg) ne 1 then img=1 else begin
		simg=str_sep(string(immg),'.')   &  img=long(simg(0))>1
		if n_elements(simg) eq 2 then begin img=long(simg(1))>1 & imm=long(simg(0))>1 & endif
         endelse
ok =1 & NXF='XML' & tiip='UNKNOWN' & nxcur="" & nxI="" & imi =0 & imj  =0
nxdata=0 & nxmonitor=0 & nxsample=0 & nxinstrument=0 & nxbeam=0 & nxlog=0

WHILE (ok) do begin
	 ok=NXmlparse(fileN, lun, tag,att,str, value ,look=look)
		;print,'<'+tag+' '+att+'>'+str & print,value
	 jj=0
	 WHILE jj lt n_elements(tag) DO begin ON_IOERROR,misloop
	  CASE strlowcase(tag(jj)) of

	 'nxmlfile':begin	searchATT, att(jj), 'file_name' , his  & NXF='NXml'
				searchATT, att(jj), 'file_time' , time & his=his+' '+time
				searchATT, att(jj), 'instrument', ins
				searchATT, att(jj), 'user'      , src  & if ins gt "" then src=ins+" " +src
				if strpos( str(jj), 'LAMP') gt 0 then begin time=str(jj) & lampF=1  & endif
			end
	 'nxentry': begin	imi = imi+1 & if imi le imm then if str(jj) gt ' ' then  his=str(jj)
				if imi gt imm then begin ok=0 & jj=n_elements(tag)  & nxcur="Entry" & endif
			end
	 'nxdata':  begin imj = imj+1 & if imj eq img then nxdata=1 else nxdata=0
				if nxdata  then begin
				searchATT, att(jj), 'title'    , wt   & lim=str(jj) & nxcur="Data"
				searchATT, att(jj), 'sub_title', ot   & if ot  eq ''  then ot=FILENAME(0)
				searchATT, att(jj), 'source'   , hit  & if hit gt ' ' then src=hit
				searchATT, att(jj), 'param'    , hit  & if hit gt ' ' then begin p_txt=[p_txt,'(data) param =']
				                                                                 p    =[p,float(hit)] & endif
				endif & end
	 'parameters':if nxdata then begin
				cn=n_elements(value) & P=fltarr(cn) & p_txt=strarr(cn)  & lampF=1
				for j=0,cn-1 do begin  tmp=value (j)  & r=RSTRPOS(tmp,'=')>0
                                if r ge 0 then begin P(j)=FLOAT(STRMID(tmp,r+1,30))
                                                     p_txt(j)=  STRMID(tmp,0,r+1)   & endif
				endfor
			  endif
	 'var_params':if nxdata then pv= value

	 'errors':    if nxdata then e = value

	 'snapshot':  if nxdata then begin
			  endif
	 'monitors':  begin if  nxmonitor then n=value else if nxdata then if n(0) eq 0 then n=value
			  end
	 'nxinstrument': begin  nxinstrument=1 & nxcur="Instrument" & nxI="I " & end
	 'nxmonitor':    begin  nxmonitor=1    & nxcur="Monitor"  & end
	 'nxsample':     begin  nxsample=1     & nxcur="Sample"  & end
	 'nxbeam':       begin  nxbeam=1       & nxcur="Beam"  & end
	 'nxlog':        begin  nxlog=1        & nxcur="Log"  & pv= value & end

	 '/nxinstrument':begin  nxinstrument=0 & nxcur="" & nxI="" & end
	 '/nxmonitor':   begin  nxmonitor=0    & nxcur="" & end
	 '/nxsample':    begin  nxsample=0     & nxcur="" & end
	 '/nxdata':      begin  nxdata=0       & nxcur="" & end
	 '/nxbeam':      begin  nxbeam=0       & nxcur="" & end
	 '/nxlog':       begin  nxlog=0        & nxcur="" & end
	  ELSE:
	  ENDCASE

	  getallATT, att(jj),  names , values & flg=''
	  if  strpos(strlowcase(tag(jj)),'nx') eq 0 then nxcur=nxI+strmid(tag(jj),2,15)
	  FOR ii=1,n_elements(names)-1 do begin val=values(ii)
				 CASE strlowcase(names(ii)) of
				'signal':begin
				         if val eq '1' then if nxdata then begin DATA=value & flg='d' & endif
				         end
				'axis':  if nxdata then begin
				         if val eq '1'  then begin x=value & flg='1' & endif
				         if val eq '2'  then begin y=value & flg='2' & endif
				         if val eq '3'  then begin z=value & flg='3' & endif
				         endif
				'label': if nxdata then begin
				         if flg eq 'd'  then wt=wt+' '+val
				         if flg eq '1'  then xt=xt+' '+val
				         if flg eq '2'  then yt=yt+' '+val
				         if flg eq '3'  then zt=zt+' '+val
				         endif
				'units': if nxdata then begin
				         if flg eq 'd'  then wt=wt+' '+val
				         if flg eq '1'  then xt=xt+' '+val
				         if flg eq '2'  then yt=yt+' '+val
				         if flg eq '3'  then zt=zt+' '+val
				         endif
				'y_value':  if nxdata then y=float(val)
				'z_value':  if nxdata then z=float(val)
				'file_name':
				'file_time':
				'sub_title':
				'title':
				'lines':
				'size':
				'user':
				'min':
				'max':
				'dims':  if flg eq ''  then begin nc=n_elements(value)
				            if nc le 9 then begin
				               p_txt=[p_txt,strarr(nc)+tag(jj)]  & p=[p,value] & endif
				         end
				'type':  if nxdata then if flg eq 'd' then tiip=val
				 else:   begin mesi='('+nxcur+') '+names(ii) & id=strpos(p_txt,mesi)
				               id=where(id ge 0)  & if id(0) lt 0 then begin   uk=0
				                  ON_IOERROR,misF & valf=0 & valf=float(val) & uk=1 & misF:
							ON_IOERROR,misloop
				                  if uk eq 0 then mesi=mesi+': '+val
				                  p_txt=[p_txt,mesi+' ='] & p=[p,valF]
				                  if strpos(names(ii),'monitor') eq 0 then if n(0) eq 0 then n=valF
				               endif & end
				 ENDCASE
	  ENDFOR
	  misloop:jj=jj+1
	 ENDWHILE
ENDWHILE

if (n_elements(p) gt 1) and (p(0) eq 0) then begin p_txt=p_txt(1:*) & p=p(1:*) & endif

if n_elements(Data) gt 1 then STATUS=0

 IF look then begin
      Data=[time,' ']
      Data=[Data,' SOURCE:         '+src,' '  ,' HISTORY:        '+his ,' ']
	Data=[Data,' FORMAT:         '+NXF      ,' TYPE:           '+tiip,' ',' RANGES:         '+lim ,' ']
	Data=[Data,' TITLES: '+wt,'      X: '+xt,'      Y: '+yt ,'      Z: '+zt,'  OTHER: '+ot,' ']

	Data=[Data,' PARAMETERS:',' ----------']
	for i=0,n_elements(p_txt)-1 do $
	Data=[Data,' * '+p_txt(i)+string(p(i))]
 ENDIF
 END
