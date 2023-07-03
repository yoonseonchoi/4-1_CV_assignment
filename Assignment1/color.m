img = imread("peppers.png");

r = img(:,:,1); g = img(:,:,2); b = img(:,:,3);
r_n = double(r)/255; g_n = double(g)/255; b_n = double(b)/255;

% (1) Display RGB components
subplot(2,2,1); imshow(r); title('R');
subplot(2,2,2); imshow(g); title('G');
subplot(2,2,3); imshow(b); title('B');
subplot(2,2,4); imshow(img); title('RGB img');

% (2) Display YCbCr
y = 0.299*r_n + 0.587*g_n + 0.114*b_n;
cb = -0.169*r_n - 0.331*g_n + 0.5*b_n + 0.5;
cr = 0.5*r_n - 0.419*g_n - 0.081*b_n + 0.5;
ycbcr = cat(3,y,cb,cr);

subplot(2,2,1); imshow(y); title('Y');
subplot(2,2,2); imshow(cb); title('Cb');
subplot(2,2,3); imshow(cr); title('Cr');
subplot(2,2,4); imshow(ycbcr); title('YCbCr img');

% (3) Display HSI
i = (r_n+g_n+b_n)/3;
s = 1-(3./(r_n+g_n+b_n)).*min(min(r_n,g_n),b_n);
h = acos((2*r_n-g_n-b_n)./(2.*sqrt((r_n-g_n).^2+(r_n-b_n).*(g_n-b_n))))/(2*pi);
hsi = cat(3,h,s,i);

subplot(2,2,1); imshow(h); title('H');
subplot(2,2,2); imshow(s); title('S');
subplot(2,2,3); imshow(i); title('I');
subplot(2,2,4); imshow(hsi); title('HSI img');

% (4) Modified Image
new_h = 0.5.*h;
new_s = 0.25.*s;
new_i = 0.75.*i;
new_hsi = cat(3, new_h, new_s, new_i);

subplot(1,2,1); imshow(hsi); title('HSI img');
subplot(1,2,2); imshow(new_hsi); title('Modified HSI img')

new_h = new_h*360;
new_r = zeros(size(new_h));
new_g = zeros(size(new_h));
new_b = zeros(size(new_h));

for i = 1:numel(new_h)
    % 0 <= new_h < 120
    if (new_h(i) >= 0) && (new_h(i) < 120)
        new_b(i) = new_i(i).*(1-new_s(i));
        new_r(i) = new_i(i).*(1+(new_s(i).*cosd(new_h(i)))./cosd(60-new_h(i)));
        new_g(i) = 3.*new_i(i)-(new_r(i)+new_b(i));
        temp_h(i) = new_h(i)-120;
    % 120 <= new_h < 240   
    elseif (new_h(i) >= 120) && (new_h(i) < 240)
        new_r(i) = new_i(i).*(1-new_s(i));
        new_g(i) = new_i(i)*(1+((new_s(i).*cosd(temp_h(i)))./cosd(60-temp_h(i))));
        new_b(i) = 3.*new_i(i)-(new_r(i)+new_g(i));
        temp_h(i) = new_h(i)-240;
    % 240 <= new_h < 360
    elseif (new_h(i) >= 240) && (new_h(i) < 360)
        new_g(i) = new_i(i).*(1-new_s(i));
        new_b(i) = new_i(i).*(1+((new_s(i).*cosd(temp_h(i)))./cosd(60-temp_h(i))));
        new_r(i) = 2.*new_i(i)-(new_g(i)+new_b(i));
    end
end

new_rgb = cat(3,new_r,new_g,new_b);

subplot(1,2,1); imshow(img); title('RGB img');
subplot(1,2,2); imshow(new_rgb); title('Modified RGB img');

% For my own image
my_img = imread("phones.jpg");

my_r = my_img(:,:,1); my_g = my_img(:,:,2); my_b = my_img(:,:,3);
my_r_n = double(my_r)/255; my_g_n = double(my_g)/255; my_b_n = double(my_b)/255;

% (1) Display RGB components
subplot(2,2,1); imshow(my_r); title('R');
subplot(2,2,2); imshow(my_g); title('G');
subplot(2,2,3); imshow(my_b); title('B');
subplot(2,2,4); imshow(my_img); title('RGB img');

% (2) Display YCbCr
my_y = 0.299*my_r_n + 0.587*my_g_n + 0.114*my_b_n;
my_cb = -0.169*my_r_n - 0.331*my_g_n + 0.5*my_b_n + 0.5;
my_cr = 0.5*my_r_n - 0.419*my_g_n - 0.081*my_b_n + 0.5;
my_ycbcr = cat(3,my_y,my_cb,my_cr);

subplot(2,2,1); imshow(my_y); title('Y');
subplot(2,2,2); imshow(my_cb); title('Cb');
subplot(2,2,3); imshow(my_cr); title('Cr');
subplot(2,2,4); imshow(my_ycbcr); title('YCbCr img');

% (3) Display HSI
my_i = (my_r_n+my_g_n+my_b_n)/3;
my_s = 1-(3./(my_r_n+my_g_n+my_b_n)).*min(min(my_r_n,my_g_n),my_b_n);
my_h = acos((2*my_r_n-my_g_n-my_b_n)./(2.*sqrt((my_r_n-my_g_n).^2+(my_r_n-my_b_n).*(my_g_n-my_b_n))))/(2*pi);
my_hsi = cat(3,my_h,my_s,my_i);

subplot(2,2,1); imshow(my_h); title('H');
subplot(2,2,2); imshow(my_s); title('S');
subplot(2,2,3); imshow(my_i); title('I');
subplot(2,2,4); imshow(my_hsi); title('HSI img');

% (4) Modified Image
my_new_h = 0.75.*my_h;
my_new_s = 0.25.*my_s;
my_new_i = 0.5.*my_i;
my_new_hsi = cat(3, my_new_h, my_new_s, my_new_i);

subplot(1,2,1); imshow(my_hsi); title('HSI img');
subplot(1,2,2); imshow(my_new_hsi); title('Modified HSI img');

my_new_h = my_new_h*360;
my_new_r = zeros(size(my_new_h));
my_new_g = zeros(size(my_new_h));
my_new_b = zeros(size(my_new_h));

for j = 1:numel(my_new_h)
    % 0 <= my_new_h < 120
    if (my_new_h(j) >= 0) && (my_new_h(j) < 120)
        my_new_b(j) = my_new_i(j).*(1-my_new_s(j));
        my_new_r(j) = my_new_i(j).*(1+(my_new_s(j).*cosd(my_new_h(j)))./cosd(60-my_new_h(j)));
        my_new_g(j) = 3.*my_new_i(j)-(my_new_r(j)+my_new_b(j));
    % 120 <= my_new_h < 240   
    elseif (my_new_h(j) >= 120) && (my_new_h(j) < 240)
        my_new_r(j) = my_new_i(j).*(1-my_new_s(j));
        my_new_g(j) = my_new_i(j)*(1+((my_new_s(j).*cosd(my_new_h(j)-120))./cosd(180-my_new_h(j))));
        my_new_b(j) = 3.*my_new_i(j)-(my_new_r(j)+my_new_g(j));
    % 240 <= my_new_h < 360
    elseif (my_new_h(j) >= 240) && (my_new_h(j) < 360)
        my_new_g(j) = my_new_i(j).*(1-my_new_s(j));
        my_new_b(j) = my_new_i(j).*(1+((my_new_s(j).*cosd(my_new_h(j)-240))./cosd(300-my_new_h(j))));
        my_new_r(j) = 2.*my_new_i(j)-(my_new_g(j)+my_new_b(j));
    end
end

my_new_rgb = cat(3,my_new_r,my_new_g,my_new_b);

subplot(1,2,1); imshow(my_img); title('RGB img');
subplot(1,2,2); imshow(my_new_rgb); title('Modified RGB img');