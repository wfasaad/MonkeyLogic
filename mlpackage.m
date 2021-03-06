%mlpackage
% Creates a zip archive containing all MonkeyLogic files
% Created 10/21/07 -WA
% Last modified 7/23/08 -WA

files = {...
    'adjust_eye_calibration.m' ...
    'behaviorgraph.m' ...
    'behaviorsummary.m' ...
    'benchmarkmov.avi' ...
    'benchmarkpic.jpg' ...
    'bhv_read.m' ...
    'bhv_write.m' ...
    'changevars.m' ...
    'chartblocks.m' ...
    'chooseblock.m'...
    'chooseerrorhandling.m'...
    'codes.txt' ...
    'earth.jpg' ...
    'embedtimingfile.m' ...
    'generate_condition.m' ...
    'genicon.jpg' ...
    'impokehole.m' ...
    'initcontrolscreen.m' ...
    'initializing.avi' ...
    'initstim.m' ...
    'initio.m' ...
    'ioheader.jpg' ...
    'ioscan.m' ...
    'iotest.m' ...
    'load_conditions.m' ...
    'makecircle.m' ...
    'makesquare.m' ...
    'mlflush.m' ...
    'mlkbd.m' ...
    'mlmenu.m' ...
    'mlpackage.m' ...
    'mltimetest.m' ...
    'mlvideo.m' ...
    'mlwebsummary.html'...
    'mlwebsummary.m'...
    'monkeylogic.m' ...
    'monkeylogic_alert.m' ...
    'monkeys2.jpg' ...
    'movieicon.jpg' ...
    'pad_image.m' ...
    'parse.m' ...
    'parse_object.m' ...
    'runbutton.jpg' ...
    'runbuttondim.jpg' ...
    'runbuttonoff.jpg' ...
    'science.wav' ...
    'set_ml_directories.m' ...
    'set_ml_preferences.m' ...
    'smooth.m' ...
    'sort_taskobjects.m' ...
    'sortblocks.m' ...
    'soundicon.jpg' ...
    'stimulationicon.jpg' ...
    'taskheader.jpg' ...
    'textblank.jpg' ...
    'tfinit.jpg' ...
    'threemonkeys.jpg' ...
    'timetest.txt' ...
    'trackvarchanges.m' ...
    'trialholder.m' ...
    'ttlicon.jpg' ...
    'videoheader.jpg' ...
    'xycalibrate.m' ...
    };

for i = 1:length(files),
    files{i} = [' ' files{i}];
end
flist = cat(2, files{:});

doscommand = ['!zip MonkeyLogic-' date ' ' flist];
savedir = pwd;
mldir = fileparts(which('monkeylogic'));
cd(mldir);
eval(doscommand);
cd(savedir);
disp(sprintf('Archived %i files to MonkeyLogic-%s.zip', length(files), date))

    