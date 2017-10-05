function PLATGUI

h.fig = figure;

h.channelExp = uicontrol('style', 'text', 'position', [10, 360, 260, 50], 'String', 'Channel to be plated (0-63) or `411` for all channels', 'FontSize', 16);
h.channel = uicontrol('style', 'edit', 'position', [280, 360, 260, 50], 'FontSize', 30);

h.currentExp = uicontrol('style', 'text', 'position', [10, 300, 260, 50], 'String', 'Platinization current (0-500) in nA', 'FontSize', 16);
h.current = uicontrol('style', 'edit', 'position', [280, 300, 260, 50], 'FontSize', 30);

h.timeExp = uicontrol('style', 'text', 'position', [10, 240, 260, 50], 'String', 'Time for plating in seconds', 'FontSize', 16);
h.time = uicontrol('style', 'edit', 'position', [280, 240, 260, 50], 'FontSize', 30);

h.run = uicontrol('style', 'pushbutton', 'position', [10, 180, 530, 50], 'String', 'Run', 'FontSize', 32);
set(h.run, 'callback', {@sPLAT, h});

end

function sPLAT(hObject, eventdata, h)

h.inprogress = uicontrol('style', 'text', 'position', [10, 120, 530, 50], 'String', 'In Progress', 'FontSize', 30);
set(h.channel, 'enable', 'off');
set(h.current, 'enable', 'off');
set(h.time, 'enable', 'off');
set(h.run, 'enable', 'off');

global handle;

IOPort('CloseAll');
handle = IOPort('OpenSerialPort', 'COM3');

IOPort('Verbosity', 1);

channel = str2double(get(h.channel, 'String'));
current = str2double(get(h.current, 'String'));
platTime = str2double(get(h.time, 'String'));

[startStream, stopStream] = inputCMD(channel, current);

bufferCLK(10);

for n = 1:size(startStream, 2)
   
    IOPort('ConfigureSerialPort', handle, 'RTS=0');
    
    switch(startStream(n))
        case 0
            IOPort('ConfigureSerialPort', handle, 'TXD=1');
        case 1
            IOPort('ConfigureSerialPort', handle, 'TXD=0');
    end

    pause(0.0005);
    
    IOPort('ConfigureSerialPort', handle, 'RTS=1');
    
    pause(0.0005);
    
end

bufferCLK(10);

pause(platTime - .02);

bufferCLK(10);

for n = 1:19
   
    IOPort('ConfigureSerialPort', handle, 'RTS=0');
    
    switch(stopStream(n))
        case 0
            IOPort('ConfigureSerialPort', handle, 'TXD=1');
        case 1
            IOPort('ConfigureSerialPort', handle, 'TXD=0');
    end

    pause(0.0005);
    
    IOPort('ConfigureSerialPort', handle, 'RTS=1');
    
    pause(0.0005);
    
end

bufferCLK(10);

delete(h.inprogress);
h.again = uicontrol('style', 'pushbutton', 'position', [10, 120, 530, 50], 'String', 'New Platinization', 'FontSize', 32);
set(h.again, 'callback', {@again, h});

end

function again(hObject, eventdata, h)

delete(h.again);
set(h.channel, 'enable', 'on');
set(h.current, 'enable', 'on');
set(h.time, 'enable', 'on');
set(h.run, 'enable', 'on');

end