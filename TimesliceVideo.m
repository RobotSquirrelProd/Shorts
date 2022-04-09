clear all
close all
clc

%%
% Setup the file names
str_anim_base = 'BallAnimation';
str_out_base = 'BallTimebase';

% Define the location of the vertical line used to extract the pixels
i_col = 500;

%%
% These steps assemble the frames created by POV-Ray into an animation and
% create the frames that will be assembled later for the timebase
cl_files = dir([str_anim_base '*.png']);
assert(~isempty(cl_files), 'Failed to find files')
nImages = length(cl_files);

% Set frame properties for the timebase using the first frame of this
% animation.
[d_frame,~] = imread(cl_files(1).name);

% Create the empty image frame for the timebase
d_timebase = ones(size(d_frame))*65535;

% Create the animated video file for the input images
str_ball = [str_anim_base '.avi'];
video = VideoWriter(str_ball);
open(video)

% Create the animated video file for the timebase image
str_timebase_video = [str_out_base '.avi'];
video_timebase = VideoWriter(str_timebase_video);
open(video_timebase);

% Number of loops
for n_rep = 1:3
    for idx_frame = 1:nImages

        % Read in the files created by POV-Ray
        [d_frame,~] = imread(cl_files(idx_frame).name);

        % Add the frame to the video
        writeVideo(video,double(d_frame)/65536);

        % For the cube arrangement, it looks best if the pixels shift to
        % the right.
        d_timebase(:,2:end,1) = d_timebase(:,1:(end-1),1);
        d_timebase(:,2:end,2) = d_timebase(:,1:(end-1),2);
        d_timebase(:,2:end,3) = d_timebase(:,1:(end-1),3);

        % Extract the pixels, update the timebase image
        d_timebase(:,1,1) = d_frame(:,i_col,1);
        d_timebase(:,1,2) = d_frame(:,i_col,2);
        d_timebase(:,1,3) = d_frame(:,i_col,3);

        % Write this new frame to the timebase animation
        writeVideo(video_timebase, d_timebase/65536);

    end
end

% Close out the video files
close(video)
close(video_timebase)


