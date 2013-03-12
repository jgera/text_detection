addpath_for_me;

path = '../../../../KCD_NoSync/temp1/MSRATD500/[001] IMG_0059.JPG_400x400_ER_candidate_img_0_[0228_1555]/';
fds = dir([path 'ER*_reverse_0.*']) ;

in_mat_path = '../../../../KCD_NoSync/temp1/MSRATD500/400x400/';
in_mat_file = '[001] IMG_0059.JPG_400x400_reverse_0.mat';
load([in_mat_path in_mat_file]);

im = [];
im = imfeat('init', 'swt', im);
% im = imfeat('init', 'binary', im);
for i=1:numel(fds)

fn_in = fds(i,1).name;
n1 = min(strfind(fn_in,'('));
n2 = min(strfind(fn_in,','));
n3 = min(strfind(fn_in,')'));
t = str2num(fn_in(n1+1:n2-1));
r = str2num(fn_in(n2+1:n3-1));
ER = ft_ert.feat_raw.tree{t,r};
I = imread([path fds(i,1).name]);
I = I(ER.data_t:ER.data_b,ER.data_l:ER.data_r);


% im = imfeat('set_image', uint8(I), im);
% out = imfeat('extract_feature_raw_reflectpointno_all', '', im);

if 1
im = imfeat('set_image', I, im);
im = imfeat('extract_feature_mask', '', im);
imshow(im.feat_mask);
all = sum(sum(I==1));
swt = mean(mean(im.feat_mask>0));

swt = mean(out(find(im.feat_mask.*I>0)));
 
end
fprintf('ER(%d,%d):%f\n',t,r,swt);

end