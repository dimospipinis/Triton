function MT_init_settings

global REMORA

settings.inDir = '';
settings.outDir  = '';
settings.tagchoice = '2015';
settings.highpass = 10;   
settings.lowpass = 90; %If sample rate of accelerometer data is <180, only a high-pass filter will be used.
settings.bin = 0.5; 
settings.fs = 10; % The (usually downsampled) sample rate of the tag data at which you will want the final speed values to match.
settings.filter = 0.5; %
settings.minDepth = 10;
settings.minPitch = 45;
settings.minSpeed = 0.5;
settings.minTime = 0.2;
REMORA.MT.settings = settings;