////////////////////////////////////////////////
//// File generated by IDL2Matlab V2.0.     ////
////////////////////////////////////////////////

function [varargout] = test(varargin)

////Initialization of parameters
  I2Mkwn=['I2M_a1', 'I2M_pos'];
  I2Mkwv=['a', 'I2M_pos'];
  a=[]; I2M_pos=[];
  I2M_lst=[]; I2M_out=[];  lv=length(varargin); if (~(modulo(lv,2)==0)), I2M_ok=0;  else,   I2M_ok=1;
  for I2M=1:2:lv, I2M_tmp=varargin(I2M); if (typeof(I2M_tmp)~='string'); I2M_ok=0;break; end;[varquisertarien,I2Mx]=grep(I2M_tmp,I2Mkwn); if length(I2Mx) ~=1; I2M_ok=0;break; end; str=string(I2Mkwv(I2Mx)) + '=' + string(varargin(I2M+1)) + ';'; execstr([str]); I2M_lst((I2M+1)/2)=I2Mkwv(I2Mx); end; end;
  if ~I2M_ok; for I2M=1:lv; str=string(I2Mkwv(I2M)) + '=' + string(varargin(I2M)) + ';';  execstr([str]);end; end;
  if ~isempty(I2M_pos); for I2M=1:length(I2M_pos);str='varargout(' + string(I2M) + ') = ' + I2M_lst(I2M_pos(I2M)) + ';'; I2M_out= [I2M_out  str]; end; end;

////End of parameters initialization

  a = a + 1;
  if ~(isempty(I2M_out)); execstr([I2M_out]); else varargout(1)=[]; end 
return;

if ~(isempty(I2M_out)); execstr([I2M_out]); else varargout(1)=[]; end 
return;
//// end of function test