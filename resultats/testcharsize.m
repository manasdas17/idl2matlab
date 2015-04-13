%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% File generated by IDL2Matlab v1.1. %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function testcharsize()

  global i2mvs_p i2mvs_x % SYSTEM VARIABLES

  x = findgen(100);
  y = x.^2 - x + 5;
  i2mvs_p.multi = d1_array(0,2,2,0,0);
  i2mvs_p.charsize = 2;
  i2mvs_x.charsize = 0.5;
  [y] = plott('I2M_a1', y, 'title', 'charsize = 1', 'charsize', 1, 'I2M_pos', [1]);
  xyouts(15,30,'charsize = 2');
  [y] = plott('I2M_a1', y, 'title', 'charsize = 2', 'I2M_pos', [1]);
  xyouts('I2M_a1', 15, 'I2M_a2', 30, 'I2M_a3', 'charsize = 1', 'charsize', 1);
  xyouts('I2M_a1', 30, 'I2M_a2', 45, 'I2M_a3', 'charsize = 3', 'charsize', 3);
  [y] = plott('I2M_a1', y, 'I2M_pos', [1]);
  i2mvs_p.charsize = 0;

return;
% end of function testcharsize