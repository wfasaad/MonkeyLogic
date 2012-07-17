function textline = generate_condition(cond_number, varargin)
%SYNTAX:
%        textline = generate_condition(cond_number, relative_frequency, cond_in_block, timing_file, TaskObject, [fid])
%
% Where cond_number is the condition number, cond_in_block is the array of
% block numbers in which that condition can occur, timing_file is the
% string containing the name of the timing script, and TaskObject is a
% structure with fields:
%
%   TaskObject(n).Type
%   TaskObject(n).Arg{k}
%
% in which n is the TaskObject number and the field Arg is a cell array containing
% each of the arguments for the indicated TaskObject type.
%
% The optional input argument, fid, can specify the FID of the text file to which 
% this condition should be written.
%
% Alternatively, the syntax:
%
%       textline = generate_condition('header', [fid])
%
% can be used to generate a conditions file header.
%
% The output, textline, is the text as it is to be printed to the conditions file.
%
% Created by WA 9/3/06
% Last modified 9/11/06 -WA

textline = '';

fid = [];
if ~isempty(varargin),
    fid = varargin{1};
end

if strcmpi(cond_number, 'header'),
    txtline = 'Condition\tFrequency\tBlock\t\tTiming File\t\tTaskObject#1\t\t\tTaskObject#2\t\t\tTaskObject#3\t\t\tTaskObject#4\t\t\tTaskObject#5\t\t\tTaskObject#6\t\t\tTaskObject#7\t\t\tTaskObject#8\t\t\tTaskObject#9\r\n';
    textline = sprintf(txtline);
    if ~isempty(fid),
        fprintf(fid, txtline);
    end
    return
end

relative_frequency = varargin{1};
cond_in_block = varargin{2};
timing_file = varargin{3};
TaskObject = varargin{4};
if length(varargin) > 4,
    fid = varargin{5};
else
    fid = [];
end

fn = fieldnames(TaskObject);
numfields = length(fn);
ftype = find(strcmp(fn, 'Type'));
if isempty(ftype) || length(ftype) > 1,
    error('Must have one field called TaskObject.Type');
    return
end
farg = find(strmatch('Arg', fn));
if isempty(farg) || (length(farg)+1) ~= numfields,
    error('Only allowed fields for TaskObject are "Type" and "Arg"');
    return
end

for i = 1:length(TaskObject),
    numargs = length(TaskObject(i).Arg);
    for j = 1:numargs,
        if j == numargs,
            txtsep = ')';
        else
            txtsep = ',';
        end
        thisarg = TaskObject(i).Arg{j};
        if ischar(thisarg),
            txt{j} = sprintf('%s%s', thisarg, txtsep);
        elseif length(thisarg) > 1,
            txt{j} = ['[' sprintf('%3.3f ', thisarg) ']' txtsep];
        else
            txt{j} = sprintf('%3.3f%s', thisarg, txtsep);
        end
    end
    TOstring{i} = sprintf('%s(%s', TaskObject(i).Type, strcat(txt{:}));
    TOstring{i} = strcat(TOstring{i}, '\t\t');
end

cinb = cond_in_block;
[h w] = size(cinb);
if h > w,
    cinb = cinb';
end
rf = sprintf('%i ', relative_frequency);
cinb = sprintf('%i ', cinb);
txtstr = strcat('%i\t\t%s\t\t%s\t\t%s\t\t', strcat(TOstring{:}), '\r\n');
textline = sprintf(txtstr, cond_number, rf, cinb, timing_file);

if ~isempty(fid),
    fprintf(fid, txtstr, cond_number, rf, cinb, timing_file);
end

