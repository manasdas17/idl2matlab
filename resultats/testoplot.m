%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% File generated by IDL2Matlab V2.0.      %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function testoplot()

  a = findgen(100);
  y = 3 .* a + 11;
  z = 2 .* a + 14;
  [a, z] = plott('I2M_a1', a, 'I2M_a2', z, 'thick', 2.5, 'min_value', 50, 'I2M_pos', [1, 2]);
  % oplot, y
  [a, y] = oplott('I2M_a1', a, 'I2M_a2', y, 'thick', 3.5, 'max_value', 150, 'I2M_pos', [1, 2]);

return;
% oplot,y, thick=4, min_value=50
% oplot,y, thick=4, min_value=50, max_value=150
% oplot,y,y,/polar
% oplot,y,y,/polar, thick=2
% oplot,y,y,/polar, thick=2, min_value=10
% oplot,y,y,/polar, thick=2, min_value=10, max_value=150
% end of function testoplot