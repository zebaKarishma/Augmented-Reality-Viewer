function integrate(Pu,virtual_box) 

fileID = fopen('points3D.txt','r');
formatSpec = '%d %f %f %f %*[^\n]';
sizeA = [4 Inf];
data3d = fscanf(fileID,formatSpec, sizeA);
data3d = data3d';



%Read cameras.txt
fileID = fopen('cameras.txt','rt');

% Read the first 3 lines of the file.
textLine = fgetl(fileID); % Read and throw away line 1
textLine = fgetl(fileID); % Read and throw away line 2
textLine = fgetl(fileID); % Read and throw away line 3
data = [];
K=[]; %intrinsic camera parameter
rot_trans=[]; % extrinsic camera parameter

while ischar(textLine)
	% Read the next line.
	textLine = fgetl(fileID);
	% Print out what line we're operating on.
	%fprintf('%s\n', textLine)
    data = split(textLine,' ');
    data = data(3:end,:);

    
    arr=[];
    for i=1:6
       arr = [arr;(string(data(i)))];
    end
    arr = str2double(arr);
    K = [arr(3,1) arr(6,1) arr(4,1);0 arr(3,1) arr(5,1);0 0 1];
    break
end
% All done reading all lines, so close the file.
fclose(fileID);

%Read Images.txt
fileID = fopen('images.txt','rt');

% Read the first 3 lines of the file.
textLine = fgetl(fileID); % Read and throw away line 1
textLine = fgetl(fileID); % Read and throw away line 2
textLine = fgetl(fileID); % Read and throw away line 3
textLine = fgetl(fileID); % Read and throw away line 3
data = [];
line=5;

while ischar(textLine) && line< 39
    % Read the next line.
    if rem(line,2)==1
        line
        % Print out what line we're operating on.
        textLine = fgetl(fileID);
        fprintf('%s\n', textLine);
        data = split(textLine,' ');
        data = data(2:end,:);
        img_name = string(data(9))
        quat=[];
        trans=[];
        nb = 7;
        for i=1:nb
            if i<5
                quat  = [quat (string(data(i)))];
            else
                trans = [trans (string(data(i)))];
            end
        end
        quat = str2double(quat);
        trans = str2double(trans);
        
        %form rotational matrix from quaternion
        rotm = quat2rotm(quat);
        rot_trans = [rotm trans'];
        line =line+1
    else
        line = line+1
        textLine = fgetl(fileID);
        disp('project here')
        %print your image
        [corn_indexed,map] = imread(img_name);
        figure()
        imshow(corn_indexed,map)
        hold on;
        
        %project your inlier points
        %load inliers1.mat
        inlier_data = Pu;
        for i= 1:size(inlier_data,2)
            X = inlier_data(1,i);
            Y = inlier_data(2,i);
            Z = inlier_data(3,i);
            world_point = [X;Y;Z;1]
            proj = K*rot_trans*world_point
            proj =(proj/proj(3,1));
            %scatter(proj(1,1),proj(2,1))
            plot(proj(1,1),proj(2,1),'.')
            rotate3d()
            grid on;
            hold on
        end
        
        box_2d_x = [];
        box_2d_y = [];
        %project the box
        for i= 1:8
            X = virtual_box(1,i);
            Y = virtual_box(2,i);
            Z = virtual_box(3,i);
            world_point = [X;Y;Z;1]
            proj_box = K*rot_trans*world_point
            proj_box =(proj_box/proj_box(3,1));
            %scatter(proj(1,1),proj(2,1))
            scatter(proj_box(1,1),proj_box(2,1),'filled')
            box_2d_x = [box_2d_x proj_box(1,1)];
            box_2d_y = [box_2d_y proj_box(2,1)];
            rotate3d()
            grid on;
            hold on
        end
        
        %make a wireframe
        %plot(box_2d_x,box_2d_y,'-')
        draw2Dbox(box_2d_x,box_2d_y)
        %break; 
    end
end
% All done reading all lines, so close the file.
fclose(fileID);
   % outputArg1 = inputArg1;
   % outputArg2 = inputArg2;
end

