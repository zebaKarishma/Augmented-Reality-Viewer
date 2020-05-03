function box(box1,box2,box3,box4,box5,box6,box7,box8,i)

sx1 = [box1(1) box2(1) box3(1) box4(1)];
sy1 = [box1(2) box2(2) box3(2) box4(2)];
sz1 = [box1(3) box2(3) box3(3) box4(3)];
%figure(i)
fill3(sx1, sy1, sz1, 1);
hold on

sx2 = [box5(1) box6(1) box7(1) box8(1)];
sy2 = [box5(2) box6(2) box7(2) box8(2)];
sz2 = [box5(3) box6(3) box7(3) box8(3)];
fill3(sx2, sy2, sz2, 1);

hold on

sx3 = [box1(1) box5(1) box6(1) box2(1)];
sy3 = [box1(2) box5(2) box6(2) box2(2)];
sz3 = [box1(3) box5(3) box6(3) box2(3)];
fill3(sx3, sy3, sz3, 1);


hold on

sx4 = [box3(1) box7(1) box8(1) box4(1)];
sy4 = [box3(2) box7(2) box8(2) box4(2)];
sz4 = [box3(3) box7(3) box8(3) box4(3)];
fill3(sx4, sy4, sz4, 1);

hold on

sx5 = [box1(1) box4(1) box8(1) box5(1)];
sy5 = [box1(2) box4(2) box8(2) box5(2)];
sz5 = [box1(3) box4(3) box8(3) box5(3)];
fill3(sx5, sy5, sz5, 1);

hold on

sx6 = [box2(1) box3(1) box7(1) box6(1)];
sy6 = [box2(2) box3(2) box7(2) box6(2)];
sz6 = [box2(3) box3(3) box7(3) box6(3)];
fill3(sx6, sy6, sz6, 1);

hold on

end