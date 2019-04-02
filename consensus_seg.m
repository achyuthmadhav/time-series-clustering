function [] = consensus_seg(num_ts,subsequence_len)
%CONSENSUS_SEG Summary of this function goes here
%   Detailed explanation goes here
inp_filename = 'ts_matrix.txt';
outp_filename = 'results.txt';
all_ts = 1:num_ts;
%num_classes = 3;
fid = fopen(outp_filename,'w');
unselected = all_ts;
class_found = zeros([1,num_ts]);
class_count = 1;
tic;
while size(unselected,2) > 0
    unselected = remove_selected(unselected, class_found);
    if size(unselected,2) == 0
        break;
    end
    [selected_ts, radii] = find_radii(inp_filename, unselected, subsequence_len);

    split = ischange(radii(2:end));
    if any(split)
        k = find(split,1);
        class_found = selected_ts(k,:);
    else
        class_found = unselected;
    end
    figure;
    plot(1:size(radii,1),radii);
    write_results(selected_ts, class_found,class_count, radii,split, fid);
    class_count = class_count+1;
end
t = toc;
disp(t);
fclose(fid);
end

function [rem_ts] = remove_selected(unselected, class_found)
for i = class_found(class_found~=0)
    unselected(unselected==i)=[];
end
rem_ts = unselected;
end

function [selected_ts, radii] = find_radii(inp_filename, unselected, subsequence_len)
ts_matrix = transpose(load(inp_filename));
class_labels = ts_matrix(1,:);
ts_matrix = ts_matrix(2:end,:);
num_ts = size(ts_matrix,2);
ts_size = size(ts_matrix(:,1),1);
first_selection = unselected(1);
unselected(1) = [];
count = size(unselected,2)+1;
selected_ts = zeros(num_ts);
radii = 0;
min_sofar = 0;

best_selection = first_selection;
level_result = first_selection;
selected_ts(1,first_selection) = first_selection;
ts_main = ts_matrix(:,first_selection);

%number of selections
for level = 2:count
    new_selection = true;       %flag to assign new min_radius
    %time series to pick
    for ts_id = unselected
        ts_current = ts_matrix(:,ts_id);
        selection = [ts_main; NaN; ts_current];
        [sol,obj] = consensus_search.from_nan_cat(selection,subsequence_len,false);
        if new_selection
            min_sofar = sol.radius;
            best_selection = ts_id;
            new_selection = false;
        end
        if min_sofar > sol.radius
            min_sofar = sol.radius;
            best_selection = ts_id;
        end
    end
    level_result = [level_result, best_selection];
    selected_ts = update_selection(level, level_result,selected_ts);
    radii = [radii;min_sofar];
    %figure;
    %plot(1:size(radii,1),radii);
    ts_main = [ts_main; NaN; ts_matrix(:,best_selection)];
    unselected(unselected == best_selection) = [];
end
end

function [result] = update_selection(level, level_result, sel_matrix)
for i = level_result
    sel_matrix(level, i) = i;
end
result = sel_matrix;
end

function [] = write_results(selected_ts, class_found,class_count, radii,split, fid)
%disp(unselected);
disp(selected_ts);
%disp(class_found);
disp(radii);
%disp(split);
fprintf(fid,'Class: %d\n',class_count);
fprintf(fid,'%d\t',class_found(class_found~=0));
fprintf(fid,'\n***************\n');
end
