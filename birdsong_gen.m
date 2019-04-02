function [] = birdsong_gen()
%BIRDSONG_GEN Summary of this function goes here
%   Detailed explanation goes here
bird_count = 1;
class_label = 1;
matrix = [];
ds = [];
while bird_count > 0
    mybird=melfcc_test;
    ts = input('Select one of the twelve MFCC time series.'); 
    show_matrixprofile(mybird,ts);
    [temp, dsTemp] = split_birdsong(mybird(ts,:), class_label);
    matrix = [matrix;temp(:,1:10001)];
    ds = [ds; dsTemp; NaN];
    bird_count = input('Enter 1 for new bird. 0 to exit.');
    class_label = class_label+1;
end
rows = size(matrix,1);
P = randperm(rows);
outp = matrix(P,:);

dlmwrite('class_mapping.txt',outp(:,1));
dlmwrite('dataset.txt',ds);
dlmwrite('ts_matrix.txt',outp);
end

function[matrix, ds] = split_birdsong(row, class_label)
matrix = [];
ds = [];
sz = size(row,2)/4;
for i=0:3
    sp = sz*i+1;
    temp = row(1,sp:sp+sz-1);
    matrix = [matrix;[class_label,temp]];
    temp = transpose(temp);
    ds = [ds;temp(1:10000,1);NaN];
end
ds = ds(1:end-1,1);
end

function[] = show_matrixprofile(mybird,ts)
%figure;
%plot(mybird(ts,:));
subsequence_len = input('Enter a subsequence length');
while subsequence_len > 0
[matrixProfileLOW, profileIndex, motifIndex, discordIndex] = interactiveMatrixProfileVer2(mybird(ts,:), subsequence_len);
subsequence_len = input('Enter a subsequence length. Enter 0 to quit');
end
end