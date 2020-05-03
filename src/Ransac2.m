function Ransac2()
%% Extract points

fileID = fopen('points3D.txt','r');
formatSpec = '%d %f %f %f %*[^\n]';
sizeA = [4 Inf];
A = fscanf(fileID,formatSpec, sizeA);
A = A';
id = A(:, 1)';
x = A(:, 2)';
y = A(:, 3)';
z = A(:, 4)';

figure(1);
plot3(x',y',z','.');
grid on;
xlabel('X');
ylabel('Y');
zlabel('Z'); 


%% Plane fitting
format short
N = 70;
s = 3;
e = 0.6;


n = size(x,2);
for i=1:N
    i
    inlier = [];
    outlier = [];
    
    ind1 = randperm(n);
    p1 = [x(ind1(1)), y(ind1(1)), z(ind1(1))];
    p2 = [x(ind1(2)), y(ind1(2)), z(ind1(2))];
    p3 = [x(ind1(3)), y(ind1(3)), z(ind1(3))];
    normal = cross(p1-p2,p1-p3);
    syms x0 y0 z0;
    P = [x0,y0,z0];
    planefunction = dot(normal,P-p1);
    for j=1:n
        testp = [x(j), y(j), z(j)];
        sol = subs(planefunction, P, testp);
        
        if sol < 0.6 && sol > -0.6
            double(sol)
            inlier = [inlier j];
        else
            outlier = [outlier j];
        end
    end
    if numel(inlier) > 0.5*n
         disp("Plane found!!!");
         numel(inlier)
         planefunction
         break;
    end
  
end


%% Inlier plotting n save
figure(2);
hold on;
grid on;

inlier_data = [];
for i=1:n    
    view(3);
    if sum(inlier==i) > 0 
        plot3(x(i), y(i), z(i), '.r');
        inlier_data = [inlier_data; 
            x(i), y(i), z(i)];
    else
        plot3(x(i), y(i), z(i), '.b');
    end
end
rotate3d on 

save('inliers1.mat','inlier_data')

end