function bufferCLK(iter)

%bufferCLK(iter)
%Ends and starts with no voltage, with a net 1ms pause
%Note: Logical 1 returns no voltage, logical 0 returns a positive voltage

global handle;

for n = 1:iter

    IOPort('ConfigureSerialPort', handle, 'RTS=0');
    pause(0.0005);
    IOPort('ConfigureSerialPort', handle, 'RTS=1');
    pause(0.0005);
    
end