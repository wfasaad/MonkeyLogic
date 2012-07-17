function varargout = trackvarchanges(trial)
%tracks changes made to "editable" variables for storage in the BHV data file
persistent VarChanges
    
if trial == -1,
    varargout{1} = VarChanges;
    return
end

VV = get(findobj('tag', 'loadbutton'), 'userdata');
fn = fieldnames(VV);
numf = length(fn);

if isempty(VarChanges),
    for i = 1:numf,
        VarChanges.(fn{i}).Trial = [];
        VarChanges.(fn{i}).Value = [];
    end
end
for i = 1:numf,
    currentval = VV.(fn{i});
    if isfield(VarChanges, fn{i}),
        tlist = VarChanges.(fn{i}).Trial;
        vlist = VarChanges.(fn{i}).Value;
        appendflag = 1;
        if ~isempty(tlist),
            if currentval == vlist(length(vlist)),
                appendflag = 0;
            end
        end
        if appendflag,
            tlist = [tlist trial]; %#ok<AGROW>
            vlist = [vlist currentval]; %#ok<AGROW>
            VarChanges.(fn{i}).Trial = tlist;
            VarChanges.(fn{i}).Value = vlist;
        end
    end
end
