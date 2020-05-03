load inliers1.mat
x_i = inlier_data(:,1);
y_i = inlier_data(:,2);
z_i = inlier_data(:,3);
n = size(x_i,1);

ind1 = randperm(n);
p1 = [x_i(ind1(1)), y_i(ind1(1)), z_i(ind1(1))];
p2 = [x_i(ind1(2)), y_i(ind1(2)), z_i(ind1(2))];
p3 = [x_i(ind1(3)), y_i(ind1(3)), z_i(ind1(3))];
normal = cross(p1-p2,p1-p3);


% translation
x1 = x_i - mean(x_i);
y1 = y_i - mean(y_i);
z1 = z_i - mean(z_i);
% 
% C = [m1 m2 m3];
% Pw = [0 0 0];
% 
Z = normal;
Z = Z/norm(Z);

X = cross([0 0 1],Z);
X = X/norm(X);
    
Y = cross(Z,X); 
Y = Y/norm(Y);

R = [X; Y; Z];
% %R = [R(1,:) 0;R(2,:) 0;R(3,:) 0; 0 0 0 1];
% 
% %t = [-m1; -m2; -m3]
% %Pose = [R t];
% %Pose = [Pose; 0 0 0 1]
Pw = zeros(3,size(x_i,1));
Pu = zeros(3,size(x_i,1));
for i=1:size(x1,1)
    Pw(:,i) = [x1(i,1); y1(i,1); z1(i,1)];
    Pu(:,i) = R*Pw(:,i);
end

%save('transformed.mat','Pu')

%% Creating a box
bs = 1;
box1 = [bs,bs,0];
box2 = [bs,-bs,0];
box3 = [-bs,-bs,0];
box4 = [-bs,bs,0];
box5 = [bs,bs,bs];
box6 = [bs,-bs,bs];
box7 = [-bs,-bs,bs];
box8 = [-bs,bs,bs];

Pc_box = [box1.' box2.' box3.' box4.' box5.' box6.' box7.' box8.'; 1 1 1 1 1 1 1 1];
Pbox = zeros(3,8);
for i=1:8
    Pw(:,i) = [Pc_box(1,i); Pc_box(2,i); Pc_box(3,i)];
    Pbox(:,i) = R*Pw(:,i);
end


%% Project 3d to 2d
m1 = mean(x_i);
m2 = mean(y_i);
m3 = mean(z_i);
C = [1 0 0 -m1;0 1 0 -m2;0 0 1 -m3;0 0 0 1];
R1 = [R(1,:) 0;R(2,:) 0;R(3,:) 0;0 0 0 1]; 
A = R1*C;
Pw_box = [];

for i=1:8
    B = Pc_box(:,i) ;
    pw_i = linsolve(A,B);
    Pw_box = [Pw_box pw_i];
end

Pu_points = [];
for i=1:size(Pu,2)
    B = [Pu(:,i);1];
    pw_i = linsolve(A,B);
    Pu_points = [Pu_points pw_i];
end

figure(1)
box(box1,box2,box3,box4,box5,box6,box7,box8,1)
hold on;
plot3(Pu(1,:),Pu(2,:),Pu(3,:),'r.'); %new coordinate system
xlabel('x'); ylabel('y'); zlabel('z');
hold off;


figure(2)
box(Pw_box(:,1)', Pw_box(:,2)', Pw_box(:,3)', Pw_box(:,4)', Pw_box(:,5)', Pw_box(:,6)', Pw_box(:,7)', Pw_box(:,8)', 1)
hold on;
grid on;
plot3(Pu_points(1,:),Pu_points(2,:),Pu_points(3,:),'g.'); % should be same as world points
xlabel('x'); ylabel('y'); zlabel('z');


figure(3)
box(Pw_box(:,1)', Pw_box(:,2)', Pw_box(:,3)', Pw_box(:,4)', Pw_box(:,5)', Pw_box(:,6)', Pw_box(:,7)', Pw_box(:,8)', 1)
hold on;
grid on;
xlabel('x'); ylabel('y'); zlabel('z');
plot3(x_i,y_i,z_i,'b.');

%% New section
integrate(Pu_points,Pw_box)
