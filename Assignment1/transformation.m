img = imread("peppers.png");

% (1) Scaling
scaling = projtform2d([3,0,0; ...
                       0,2,0; ...
                       0,0,1]);
scaled_img = imwarp(img, scaling);

% (2) Rotation
rotation = projtform2d([cos(pi/6),-sin(pi/6),0; ...
                        sin(pi/6),cos(pi/6),0; ...
                        0,0,1]);
rotated_img = imwarp(img, rotation);

% (3) Similarity transform
similarity = projtform2d([3*cos(pi/6),-2*sin(pi/6),50;
                          3*sin(pi/6),2*cos(pi/6),100;
                          0,0,1]);
similarity_img = imwarp(img, similarity);

% (4) Affine transform
affine = projtform2d([3*cos(pi/6),-2*sin(pi/6)+1,50; ...
                      3*sin(pi/6)+0.5,2*cos(pi/6),100; ...
                      0,0,1]);
affine_img = imwarp(img, affine);

% (5) Projective transform
projective = projtform2d([3,0,50; ...
                          0,2,100; ...
                          0.003,0.002,1]);
projective_img = imwarp(img, projective);

% For my own image
my_img = imread("thun.jpg");

% (1) Scaling
my_scaling = projtform2d([0.5,0,0; ...
                          0,0.1,0; ...
                          0,0,1]);
my_scaled_img = imwarp(my_img, my_scaling);

% (2) Rotation
my_rotation = projtform2d([cos(pi/4),-sin(pi/4),0; ...
                           sin(pi/4),cos(pi/4),0; ...
                           0,0,1]);
my_rotated_img = imwarp(my_img, my_rotation);

% (3) Similarity transform
my_similarity = projtform2d([0.5*cos(pi/4),-0.1*sin(pi/4),20; ...
                             0.5*sin(pi/4),0.1*cos(pi/4),40; ...
                             0,0,1]);
my_similarity_img = imwarp(my_img, my_similarity);

% (4) Affine transform
my_affine = projtform2d([0.5*cos(pi/4),-0.1*sin(pi/4)+0.5,20; ...
                         0.5*sin(pi/4)+0.7,0.1*cos(pi/4),40; ...
                         0,0,1]);
my_affine_img = imwarp(my_img, my_affine);

% (5) Projective transform
my_projective = projtform2d([0.5,0,20; ...
                             0,0.1,40; ...
                             0.001,0.0005,1]);
my_projective_img = imwarp(my_img, my_projective);