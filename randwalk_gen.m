function [] = randwalk_gen(num_series, ts_size)
%RANDWALK_GEN Creates a dataset
%   Creates a dataset of "num_series" number of time series, 
%   each of size "ts_size". 
%   provide appropriate class labels in class1, class2.
%   input filename in "motif_matrix"
%   Generates two output files, "ts_matrix.txt" and "dataset.txt"
motif_matrix = load('Trace_TRAIN.tsv');
class1 = 1;
class2 = 2;
class3 = 3;
indices_ex = []; %time series with class 2. Remaining will be class 1.
indices_ex3 = [];
% Manipulate the above values for different results.
num_ts = num_series;
N = ts_size;
classes = motif_matrix(:,1);
motif1 = motif_matrix(classes==class1,2:end);
motif2 = motif_matrix(classes==class2,2:end);
motif3 = motif_matrix(classes==class3,2:end);
dataset = [];
ts_matrix = [];
%fid = fopen('class_mapping.txt', 'w');
%fprintf(fid,'motif length = %d\n',size(motif_matrix,2)-1);
for count = 1:num_ts
    x = randperm(size(motif1,1)-1);
    motif = motif1(x,:);
    %motif = sinewave_gen();
    if ismember(count,indices_ex) == 1
        x = randperm(size(motif2,1)-1);
        motif = motif2(x,:);
        %motif = abs(sinewave_gen());
    end
    if ismember(count,indices_ex3) == 1
        x = randperm(size(motif3,1)-1);
        motif = motif3(x,:);
        %motif = abs(sinewave_gen());
    end
    %randomwalk = cumsum(normrnd(0,1,[N,1]));
    randomwalk = randn(N,1);
    randomwalk = insert_motif(randomwalk, motif);
    %randomwalk = [c;randomwalk];
    ts_matrix = [ts_matrix randomwalk];
    dataset = vertcat(dataset,randomwalk,NaN);
end
plot(1:ts_size,ts_matrix(:,1));
dataset = dataset(1:end-1);
dlmwrite('dataset.txt',dataset);
dlmwrite('ts_matrix.txt', transpose(ts_matrix));
%fclose(fid);
end

function [time_series] = insert_motif(time_series,motif_insert)
%INSERT_MOTIF Inserts motif in a time-series
%   Inserts the given motif at a random position in the given time series.
MOTIF_LEN = size(motif_insert,2)-1;
N = size(time_series,1)-1;

rnd_x = randi([1 N-MOTIF_LEN], 1);
    diff = motif_insert(1) - time_series(rnd_x);
    for i = rnd_x : rnd_x+MOTIF_LEN
        time_series(i) = motif_insert(1,i+1-rnd_x) - diff;
    end
    diff = time_series(rnd_x+MOTIF_LEN) - time_series(rnd_x+MOTIF_LEN+1);
    for i = rnd_x+MOTIF_LEN+1:N
        time_series(i) = diff + time_series(i);
    end
end

function [y] = sinewave_gen()
f=0.5;
A=10;
ts=1/32;
T=8;
t=0:ts:T;
y=A*sin(2*pi*f*t); % generates sine wave of length 256
y = awgn(y,10); %adds gaussian noise to the wave
%plot(t,y)
end

