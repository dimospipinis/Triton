function ag_init_detector_params_window

global REMORA

defaultPos = [0.25,0.35,0.38,0.4];
if isfield(REMORA.fig, 'ag')
    % Check if the figure already exists. If so, don't move it.
    if isfield(REMORA.fig.ag, 'detector') && isvalid(REMORA.fig.ag.detector)
        defaultPos = get(REMORA.fig.ag.detector,'Position');
    else
        REMORA.fig.ag.detector = figure;
    end
else 
    REMORA.fig.ag.detector = figure;
end

clf

set(REMORA.fig.ag.detector,'NumberTitle','off', ...
    'Name','Airgun Detector - v1.0',...
    'Units','normalized',...
    'MenuBar','none',...
    'Position',defaultPos, ...
    'Visible', 'on',...
    'ToolBar', 'none');

figure(REMORA.fig.ag.detector)

% Load/save settings pulldown:

if ~isfield(REMORA.fig.ag,'AGfileMenu') || ~isvalid(REMORA.fig.ag.AGfileMenu)
    REMORA.fig.ag.AGfileMenu = uimenu(REMORA.fig.ag.detector,'Label',...
        'Save/Load Settings','Enable','on','Visible','on');
    
    % Spectrogram load/save params:
    uimenu(REMORA.fig.ag.AGfileMenu,'Label','&Load Settings',...
        'Callback','ag_detector_control(''ag_detector_settingsLoad'')');
    uimenu(REMORA.fig.ag.AGfileMenu,'Label','&Save Settings',...
        'Callback','ag_detector_control(''ag_detector_settingsSave'')');
end

% Button grid layouts
% 14 rows, 2 columns
r = 16; % Rows (Extra space for separations between sections)
c = 2;  % Columns
h = 1/r;
w = 1/c;
dy = h * 0.8;
% dx = 0.008;
ybuff = h*.2;
% Y Position (Rrelative Units)
y = 1:-h:0;

% X Position (Relative Units)
x = 0:w:1;

% Colors
bgColor = [1 1 1];  % White
bgColorRed = [1 .6 .6];  % Red
% bgColorGray = [.86 .86 .86];  % Gray
bgColor3 = [.75 .875 1]; % Light Green 
bgColor4 = [.76 .87 .78]; % Light Blue 

REMORA.ag.verify = [];

REMORA.ag.params_help = ag_get_help_strings;

% Title:

labelStr = 'Airgun Detector Settings';
btnPos=[x(1) y(2) 2*w h];
REMORA.ag.detector.headtext = uicontrol(REMORA.fig.ag.detector, ...
    'Style','text', ...
    'Units','normalized', ...
    'Position',btnPos, ...
    'String',labelStr, ...
    'FontUnits','points', ...
    'FontWeight','bold',...
    'FontSize',12,...
    'Visible','on');
% Set paths and strings
%***********************************
%% Base Folder Text
labelStr = 'Audio Base Directory';
btnPos=[x(1) y(3)-ybuff w/2 h];
REMORA.ag.verify.baseDirTxt = uicontrol(REMORA.fig.ag.detector,...
   'Style','text',...
   'Units','normalized',...
   'Position',btnPos,...
   'String',sprintf(labelStr,'Interpreter','tex'),...
   'FontUnits','normalized', ...
   'Visible','on',...
   'TooltipString',sprintf(REMORA.ag.params_help.baseDirHelp));
%  'BackgroundColor',bgColor3,...

% Base Folder Editable Text
labelStr=num2str(REMORA.ag.detect_params.baseDir);
btnPos=[x(1)+w/2 y(3) w h];
REMORA.ag.verify.baseDirEdTxt = uicontrol(REMORA.fig.ag.detector,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'HorizontalAlignment','left',...
    'Visible','on',...
    'Callback','ag_detector_control(''setbaseDir'')');

labelStr = 'Search Sub-Folders';
btnPos=[x(1)+w/2 y(4) w h];
REMORA.ag.verify.recursSearch = uicontrol(REMORA.fig.ag.detector,...
   'Style','checkbox',...
   'Units','normalized',...
   'Position',btnPos,...
   'String',sprintf(labelStr,'Interpreter','tex'),...
   'Value',REMORA.ag.detect_params.recursSearch,...
   'FontUnits','normalized', ...
   'Visible','on',...
   'Callback','ag_detector_control(''recursSearch'')');

%% Output Folder Text
labelStr = 'Output Folder';
btnPos=[x(1) y(5)-ybuff w/2 h];
REMORA.ag.verify.outDirTxt = uicontrol(REMORA.fig.ag.detector,...
   'Style','text',...
   'Units','normalized',...
   'Position',btnPos,...
   'String',sprintf(labelStr,'Interpreter','tex'),...
   'FontUnits','normalized', ...
   'Visible','on',...
   'TooltipString',sprintf(REMORA.ag.params_help.outDirHelp));%   'BackgroundColor',bgColor3,...

% Output Folder Editable Text
labelStr=num2str(REMORA.ag.detect_params.outDir);
btnPos=[x(1)+w/2 y(5) w h];
REMORA.ag.verify.outDirEdTxt = uicontrol(REMORA.fig.ag.detector,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'HorizontalAlignment','left',...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','ag_detector_control(''setOutDir'')');

% Data input type
labelStr = 'Type of data';
btnPos=[x(1) y(6)-ybuff w/2 h];
REMORA.ag.verify.datatypeTxt = uicontrol(REMORA.fig.ag.detector,...
    'Style','text',...
    'Units','normalized',...
    'Position',btnPos,...
    'String',sprintf(labelStr,'Interpreter','tex'),...
    'FontUnits','normalized',...
    'Visible','on',...
    'TooltipString',sprintf(REMORA.ag.params_help.datatypeHelp));

% Data input drop-down box
labelStr = {'HARP','Sound Trap'};
btnPos=[x(2) y(6) w/2 h];
REMORA.ag.verify.datatype = uicontrol(REMORA.fig.ag.detector,...
    'Style','popup',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized',...
    'Visible','on',...
    'Callback','ag_detector_control(''setDataType'')');
%% Airgun Detector Settings Header
labelStr = 'Airgun Detector Parameters';
btnPos=[x(1) y(7) 2*w h-ybuff];
REMORA.ag.verify.detectParmTxt = uicontrol(REMORA.fig.ag.detector, ...
    'Style','text', ...
    'Units','normalized', ...
    'Position',btnPos, ...
    'BackgroundColor',bgColorRed,...
    'String',labelStr, ...
    'FontWeight','bold',...    
    'FontSize',11,...
    'FontUnits','points',...
    'Visible','on');

%% Threshold Text
labelStr = 'Threshold';
btnPos=[x(1) y(9)-ybuff w/2 h];
REMORA.ag.verify.thresholdTxt = uicontrol(REMORA.fig.ag.detector,...
   'Style','text',...
   'Units','normalized',...
   'Position',btnPos,...
   'String',sprintf(labelStr,'Interpreter','tex'),...
   'FontUnits','normalized', ...
   'Visible','on',...
   'TooltipString',sprintf(REMORA.ag.params_help.thresholdHelp));

% Threshold Editable Text
labelStr=num2str(REMORA.ag.detect_params.threshold);
btnPos=[x(1)+w/2 y(9) w/4 h];
REMORA.ag.verify.threshEdTxt = uicontrol(REMORA.fig.ag.detector,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','ag_detector_control(''setThresh'')');

%% Threshold Offset Text
labelStr = 'Threshold Offset';
btnPos=[x(1) y(10)-ybuff w/2 h];
REMORA.ag.verify.thresholdOffsetTxt = uicontrol(REMORA.fig.ag.detector,...
   'Style','text',...
   'Units','normalized',...
   'Position',btnPos,...
   'String',sprintf(labelStr,'Interpreter','tex'),...
   'FontUnits','normalized', ...
   'Visible','on',...
   'TooltipString',sprintf(REMORA.ag.params_help.thresholdOffsetHelp));

% Threshold Editable Text
labelStr=num2str(REMORA.ag.detect_params.c2_offset);
btnPos=[x(1)+w/2 y(10) w/4 h];
REMORA.ag.verify.thresholdOffsetEdTxt = uicontrol(REMORA.fig.ag.detector,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','ag_detector_control(''setThreshOffset'')');

%% Minimum Time Distance Text
labelStr = 'Minimum Time Distance';
btnPos=[x(1) y(11)-ybuff w/2 h];
REMORA.ag.verify.minTimeTxt = uicontrol(REMORA.fig.ag.detector,...
   'Style','text',...
   'Units','normalized',...
   'Position',btnPos,...
   'String',sprintf(labelStr,'Interpreter','tex'),...
   'FontUnits','normalized', ...
   'Visible','on',...
   'TooltipString',sprintf(REMORA.ag.params_help.minTimeHelp));

% Minimum Time Distance Editable Text
labelStr=num2str(REMORA.ag.detect_params.diff_s);
btnPos=[x(1)+w/2 y(11) w/4 h];
REMORA.ag.verify.minTimeEdTxt = uicontrol(REMORA.fig.ag.detector,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','ag_detector_control(''setMinTime'')');

%% # of Noise Samples Text
labelStr = '# of Noise Samples';
btnPos=[x(1) y(12)-ybuff w/2 h];
REMORA.ag.verify.noiseSampTxt = uicontrol(REMORA.fig.ag.detector,...
   'Style','text',...
   'Units','normalized',...
   'Position',btnPos,...
   'String',sprintf(labelStr,'Interpreter','tex'),...
   'FontUnits','normalized', ...
   'Visible','on',...
   'TooltipString',sprintf(REMORA.ag.params_help.noiseSampHelp));

% # of Noise Samples Editable Text
labelStr=num2str(REMORA.ag.detect_params.nSamples);
btnPos=[x(1)+w/2 y(12) w/4 h];
REMORA.ag.verify.noiseSampEdText = uicontrol(REMORA.fig.ag.detector,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','ag_detector_control(''setNoiseSamp'')');

%% RMS Noise After Signal Samples Text
labelStr = 'RMS Noise After Signal';
btnPos=[x(1) y(13)-ybuff w/2 h];
REMORA.ag.verify.rmsNoiseAfterTxt = uicontrol(REMORA.fig.ag.detector,...
   'Style','text',...
   'Units','normalized',...
   'Position',btnPos,...
   'String',sprintf(labelStr,'Interpreter','tex'),...
   'FontUnits','normalized', ...
   'Visible','on',...
   'TooltipString',sprintf(REMORA.ag.params_help.rmsNoiseAfterHelp));

% RMS Noise After Signal Editable Text
labelStr=num2str(REMORA.ag.detect_params.rmsAS);
btnPos=[x(1)+w/2 y(13) w/4 h];
REMORA.ag.verify.rmsNoiseAfterEdText = uicontrol(REMORA.fig.ag.detector,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','ag_detector_control(''setRMSNoiseAfter'')');

%% RMS Noise Before Signal Text
labelStr = 'RMS Noise Before Signal';
btnPos=[x(2) y(9)-ybuff w/2 h];
REMORA.ag.verify.rmsNoiseBeforeTxt = uicontrol(REMORA.fig.ag.detector,...
   'Style','text',...
   'Units','normalized',...
   'Position',btnPos,...
   'String',sprintf(labelStr,'Interpreter','tex'),...
   'FontUnits','normalized', ...
   'Visible','on',...
   'TooltipString',sprintf(REMORA.ag.params_help.rmsNoiseBeforeHelp));

% RMS Noise Before Signal Editable Text
labelStr=num2str(REMORA.ag.detect_params.rmsBS);
btnPos=[x(2)+w/2 y(9) w/4 h];
REMORA.ag.verify.rmsNoiseBeforeEdText = uicontrol(REMORA.fig.ag.detector,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','ag_detector_control(''setRMSNoiseBefore'')');

%% PP Noise After Signal Text
labelStr = 'PP Noise After Signal';
btnPos=[x(2) y(10)-ybuff w/2 h];
REMORA.ag.verify.ppNoiseAfterTxt = uicontrol(REMORA.fig.ag.detector,...
   'Style','text',...
   'Units','normalized',...
   'Position',btnPos,...
   'String',sprintf(labelStr,'Interpreter','tex'),...
   'FontUnits','normalized', ...
   'Visible','on',...
   'TooltipString',sprintf(REMORA.ag.params_help.ppNoiseAfterHelp));

% PP Noise After Signal Editable Text
labelStr=num2str(REMORA.ag.detect_params.ppAS);
btnPos=[x(2)+w/2 y(10) w/4 h];
REMORA.ag.verify.ppNoiseAfterEdText = uicontrol(REMORA.fig.ag.detector,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','ag_detector_control(''setPPNoiseAfter'')');

%% PP Noise Before Signal Text
labelStr = 'PP Noise Before Signal';
btnPos=[x(2) y(11)-ybuff w/2 h];
REMORA.ag.verify.ppNoiseBeforeTxt = uicontrol(REMORA.fig.ag.detector,...
   'Style','text',...
   'Units','normalized',...
   'Position',btnPos,...
   'String',sprintf(labelStr,'Interpreter','tex'),...
   'FontUnits','normalized', ...
   'Visible','on',...
   'TooltipString',sprintf(REMORA.ag.params_help.ppNoiseBeforeHelp));

% PP Noise Before Signal Editable Text
labelStr=num2str(REMORA.ag.detect_params.ppBS);
btnPos=[x(2)+w/2 y(11) w/4 h];
REMORA.ag.verify.ppNoiseBeforeEdText = uicontrol(REMORA.fig.ag.detector,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','ag_detector_control(''setPPNoiseBefore'')');

%% Duration After Airgun Signal Text
labelStr = 'Duration After Airgun';
btnPos=[x(2) y(12)-ybuff w/2 h];
REMORA.ag.verify.durAfterTxt = uicontrol(REMORA.fig.ag.detector,...
   'Style','text',...
   'Units','normalized',...
   'Position',btnPos,...
   'String',sprintf(labelStr,'Interpreter','tex'),...
   'FontUnits','normalized', ...
   'Visible','on',...
   'TooltipString',sprintf(REMORA.ag.params_help.durAfterHelp));

% Duration After Airgun Editable Text
labelStr=num2str(REMORA.ag.detect_params.durLong_s);
btnPos=[x(2)+w/2 y(12) w/4 h];
REMORA.ag.verify.durAfterEdText = uicontrol(REMORA.fig.ag.detector,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','ag_detector_control(''setDurAfter'')');

%% Duration Before Airgun? Signal Text
labelStr = 'Duration Before Airgun';
btnPos=[x(2) y(13)-ybuff w/2 h];
REMORA.ag.verify.durBeforeTxt = uicontrol(REMORA.fig.ag.detector,...
   'Style','text',...
   'Units','normalized',...
   'Position',btnPos,...
   'String',sprintf(labelStr,'Interpreter','tex'),...
   'FontUnits','normalized', ...
   'Visible','on',...
   'TooltipString',sprintf(REMORA.ag.params_help.durBeforeHelp));

% Duration Before Airgun? Editable Text
labelStr=num2str(REMORA.ag.detect_params.durShort_s);
btnPos=[x(2)+w/2 y(13) w/4 h];
REMORA.ag.verify.durBeforeEdText = uicontrol(REMORA.fig.ag.detector,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','ag_detector_control(''setDurBefore'')');

labelStr = 'Plotting On';
btnPos=[x(1)+w/2 y(14) w h];
REMORA.ag.verify.plotOn = uicontrol(REMORA.fig.ag.detector,...
   'Style','checkbox',...
   'Units','normalized',...
   'Position',btnPos,...
   'String',sprintf(labelStr,'Interpreter','tex'),...
   'Value',REMORA.ag.detect_params.plotOn,...
   'FontUnits','normalized', ...
   'Visible','on',...
   'Callback','ag_detector_control(''plotOn'')');

%% Run Button
labelStr = 'Run Airgun Detector';
btnPos=[x(2)-w/2 y(16) w h];

REMORA.ag.verify.runTxt = uicontrol(REMORA.fig.ag.detector,...
    'Style','pushbutton',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor3,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'FontSize',.5,...
    'Visible','on',...
    'FontWeight','bold',...
    'Callback','ag_detector_control(''runAirgunDetector'')');
