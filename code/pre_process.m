clear;clc;

mode = 'test';
img_data_path = '../data/raw_data/';
save_datasets_path = '../result/mat_data/';
if ~exist(save_datasets_path)
    mkdir(save_datasets_path);
end

x = 512;
y = 512;
z = 150;

files = dir(img_data_path);
files(1:2)=[];
num = length(files);

fprintf('Extracting %s dataset ... \n',mode);
for jj = 1:num
    data_volume = zeros(x,y,z);
    fprintf('Loading No.%d %s subject (total %d).\n', jj,mode,num);
    nii = load_untouch_nii([img_data_path files(jj).name]);
    [xrange yrange zrange] = size(nii.img);
    data_volume(1:xrange,1:yrange,1:zrange) = nii.img(:,:,:);
    data_volume = data_volume(1:end,1:end,1:end-2);
    data = single(reshape(data_volume,[1 prod(size(data_volume))]));
    save([save_datasets_path num2str(jj) '_' mode '.mat'],'data','-v7.3');  
    clear nii data data_volume
end




    
    