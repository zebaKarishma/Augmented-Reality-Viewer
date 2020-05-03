function draw2Dbox(x_coords,y_coords)
b1_x = x_coords(1,1);
b2_x = x_coords(1,2);
b3_x = x_coords(1,3);
b4_x = x_coords(1,4);
b5_x = x_coords(1,5);
b6_x = x_coords(1,6);
b7_x = x_coords(1,7);
b8_x = x_coords(1,8);

b1_y = y_coords(1,1);
b2_y = y_coords(1,2);
b3_y = y_coords(1,3);
b4_y = y_coords(1,4);
b5_y = y_coords(1,5);
b6_y = y_coords(1,6);
b7_y = y_coords(1,7);
b8_y = y_coords(1,8);


% s2_x = [b5_x, b7_x];
% s2_y = [b5_y, b7_y];
% plot(s2_x, s2_y,'r')
% 
% s3_x = [b4_x, b8_x];
% s3_y = [b4_y, b8_y];
% plot(s3_x, s3_y,'r')


%bottom surface
s4_x = [b3_x, b7_x, b6_x, b2_x, b3_x];
s4_y = [b3_y, b7_y,  b6_y,b2_y, b3_y];
fill(s4_x, s4_y,'r')


%back surface
s5_x = [b1_x, b2_x, b3_x, b4_x, b1_x];
s5_y = [b1_y, b2_y,  b3_y,b4_y, b1_y];
fill(s5_x, s5_y,'r')

%left surface
s6_x = [b5_x, b1_x, b2_x, b6_x, b5_x];
s6_y = [b5_y, b1_y,  b2_y,b6_y, b5_y];
fill(s6_x, s6_y,[0.4 0 0])

%right surface
s3_x = [b4_x, b3_x, b7_x, b8_x, b4_x];
s3_y = [b4_y, b3_y,  b7_y,b8_y, b4_y];
fill(s3_x, s3_y,[0.4 0 0])

%front surface
s2_x = [b5_x, b8_x, b7_x, b6_x, b5_x];
s2_y = [b5_y, b8_y,  b7_y,b6_y, b5_y];
fill(s2_x, s2_y,[0.7 0 0])

%top surface
s1_x = [b1_x, b4_x, b8_x, b5_x, b1_x];
s1_y = [b1_y, b4_y, b8_y, b5_y, b1_y];
fill(s1_x, s1_y,[0.9 0 0])
hold on;

end