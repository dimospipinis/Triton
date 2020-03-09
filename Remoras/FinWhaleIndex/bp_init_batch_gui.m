function bp_init_batch_gui
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% sh_init_batch_gui.m
%
% Verify settings in GUI before running on entire drive.
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global REMORA

% button grid layouts
% 14 rows, 4 columns
r = 13; % rows      (extra space for separations btw sections)
c = 2;  % columns
h = 1/r;
w = 1/c;
dy = h * 0.8;
% dx = 0.008;
ybuff = h*.2;
xbuff = w*.1;
% y position (relative units)
y = 1:-h:0;

% x position (relative units)
x = 0:w:1;

% colors
bgColor = [1 1 1];  % white
bgColorGrayLight = [.92 .92 .92];  % gray
bgColorGray = [.86 .86 .86];  % gray

REMORA.bp_verify = [];
labelStr = 'Fin Whale Index Detector Settings';
btnPos=[x(1) y(2) w*2 h];
REMORA.bp_verify.headtext = uicontrol(REMORA.fig.bp.detector, ...
    'Style','text', ...
    'Units','normalized', ...
    'Position',btnPos, ...
    'BackgroundColor',bgColorGray,...
    'String',labelStr, ...
    'FontUnits','points', ...
    'FontWeight','bold',...
    'FontSize',10,...
    'Visible','on');


% Set paths and strings
%***********************************
%% User text
labelSr = 'User ID';
btnPos=[x(1) y(3)-ybuff w/2 h];
REMORA.bp.verify.useridTxt = uicontrol(REMORA.fig.bp.detector,...
   'Style','text',...
   'Units','normalized',...
   'Position',btnPos,...
   'String',sprintf(labelStr,'Interpreter','tex'),...
   'FontUnits','normalized', ...
   'Visible','on');

% User ID Editable Text
labelStr=num2str(REMORA.bp.detect_params.userid);
btnPos=[x(1)+w/2 y(3) w h];
REMORA.bp.verify.useridEdTxt = uicontrol(REMORA.fig.bp.detector,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'HorizontalAlignment','left',...
    'Visible','on',...
    'Callback','bp_detector_control(''setUserID'')');
%%
% Input Folder Text
labelStr = 'LTSA directory';
btnPos=[x(1)+xbuff  y(3) w dy];
REMORA.bp_verify.inDirTxt = uicontrol(REMORA.fig.bp.detector,...
    'Style','text',...
    'Units','normalized',...
        'HorizontalAlignment','left',...
    'Position',btnPos,...
    'String',sprintf(labelStr,'Interpreter','tex'),...
    'FontUnits','normalized', ...
    'Visible','on');

% Input Folder Editable Text
labelStr=num2str(REMORA.bp.settings.inDir);
btnPos=[x(2)-w/4 y(3) w*1.2 dy];
REMORA.bp_verify.inDirEdTxt = uicontrol(REMORA.fig.bp.batch,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'HorizontalAlignment','left',...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','bp_control(''setInDir'')');

% Output Folder Text
labelStr = 'Output Folder';
btnPos=[x(1)+xbuff  y(4) w dy];
REMORA.bp_verify.outDirTxt = uicontrol(REMORA.fig.bp.batch,...
    'Style','text',...
    'Units','normalized',...
        'HorizontalAlignment','left',...
    'Position',btnPos,...
    'String',sprintf(labelStr,'Interpreter','tex'),...
    'FontUnits','normalized', ...
    'Visible','on');

% Output Folder Editable Text
labelStr=num2str(REMORA.bp.settings.outDir);
btnPos=[x(2)-w/4 y(4) w*1.2 dy];
REMORA.bp_verify.outDirEdTxt = uicontrol(REMORA.fig.bp.batch,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'HorizontalAlignment','left',...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','bp_control(''setOutDir'')');


% Detector settings
labelStr = 'Adjustable Detector Settings';
btnPos=[x(1) y(6) w*2 h];
REMORA.bp_verify.headtext = uicontrol(REMORA.fig.bp.batch, ...
    'Style','text', ...
    'Units','normalized', ...
    'Position',btnPos, ...
    'BackgroundColor',bgColorGray,...
    'String',labelStr, ...
    'FontUnits','normalized', ...
    'FontWeight','bold',...
    'Visible','on');


% col names
labelStr='Parameter';
btnPos=[x(1) y(7) w*1.5 h];
REMORA.bp_verify.headtext = uicontrol(REMORA.fig.bp.batch, ...
    'Style','text', ...
    'Units','normalized', ...
    'Position',btnPos, ...
    'BackgroundColor',bgColorGrayLight,...
    'String',labelStr, ...
    'FontUnits','normalized', ...
    'FontWeight','bold',...
    'Visible','on');

labelStr='Value';
btnPos=[x(2) y(7) w/2 h];
REMORA.bp_verify.headtext = uicontrol(REMORA.fig.bp.batch, ...
    'Style','text', ...
    'Units','normalized', ...
    'Position',btnPos, ...
    'BackgroundColor',bgColorGrayLight,...
    'String',labelStr, ...
    'FontUnits','normalized', ...
    'FontWeight','bold',...
    'Visible','on');


%***********************************
% Threshold Text
%***********************************

%  Threshold Text
labelStr = 'Threshold (dB)';
btnPos=[x(1)+xbuff*2 y(8)-ybuff w*2 h];
REMORA.bp_verify.ThreshText = uicontrol(REMORA.fig.bp.batch,...
    'Style','text',...
    'Units','normalized',...
    'HorizontalAlignment','left',...
    'Position',btnPos,...
    'String',sprintf(labelStr,'Interpreter','tex'),...
    'FontUnits','normalized', ...
    'Visible','on');

% Threshold Editable Text
labelStr=num2str(REMORA.bp.settings.thresh(1,1));
btnPos=[x(2) y(8) w/2 h];
REMORA.bp_verify.ThreshEdText = uicontrol(REMORA.fig.bp.batch,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','bp_control(''setThresh'')');

%***********************************
% Species detection
%***********************************
%   Species text
labelStr= 'Species';
btnPos =[x(1)+xbuff*2 y(10)-ybuff w*2 h];
REMORA.bp_verify.SpeciesText = uicontrol(REMORA.fig.bp.batch,...
    'Style','text',...
    'Units','normalized',...
    'HorizontalAlignment','left',...
    'Position',btnPos,...
    'String',sprintf(labelStr,'Interpreter','tex'),...
    'FontUnits','normalized',...
    'Visible','on');

%   Species drop-down box
labelStr = {'Blue whale','Fin whale'};
btnPos =[x(2) y(10) w/2 h];
REMORA.bp_verify.SpeciesChoice = uicontrol(REMORA.fig.bp.batch,...
    'Style','popup',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized',...
    'Visible','on',...
    'Callback','bp_control(''setSpecies'')');

%***********************************
% File type Text
%***********************************
%labelStr = 'HARP Data';
%btnPos=[x(1)+xbuff*2 y(9) w h];
%REMORA.bp_verify.HARPdataCheckbox = uicontrol(REMORA.fig.bp.batch,...
%    'Style','checkbox',...
%    'Units','normalized',...
%    'Position',btnPos,...
%    'String',labelStr,...
%    'Value',REMORA.bp.settings.HARPdata,...
%    'FontUnits','normalized', ...
%    'Visible','on',...
%    'Callback','bp_control(''setHARPdata'')');

%labelStr = 'Sound Trap Data';
%btnPos=[x(2) y(9) w h];
%REMORA.bp_verify.SoundTrapdataCheckbox = uicontrol(REMORA.fig.bp.batch,...
%    'Style','checkbox',...
%    'Units','normalized',...
%    'Position',btnPos,...
%    'String',labelStr,...
%    'Value',REMORA.bp.settings.SoundTrap,...
%    'FontUnits','normalized', ...
%    'Visible','on',...
%    'Callback','bp_control(''setSoundTrapdata'')');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%***********************************
% Save .tlab file Checkbox
%***********************************
%labelStr = 'Create .csv Output File';
%btnPos=[x(1)+xbuff*2 y(10) w h];
%REMORA.bp_verify.csvCheckbox = uicontrol(REMORA.fig.bp.batch,...
%    'Style','checkbox',...
%    'Units','normalized',...
%    'Position',btnPos,...
%    'String',labelStr,...
%    'Value',REMORA.bp.settings.saveCsv,...
%    'FontUnits','normalized', ...
%    'Visible','on',...
%    'Callback','bp_control(''setCsvFile'')');

% Run button
labelStr = 'Run Detector';
btnPos=[x(1)+1/2*w y(12) w h];
REMORA.bp_verify.RunDetectorEdTxt = uicontrol(REMORA.fig.bp.batch,...
    'Style','pushbutton',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',[.47,.67,.19],...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'FontSize',.5,...
    'Visible','on',...
    'FontWeight','bold',...
    'Callback','bp_control(''RunBatchDetection'')');


