function [startStream, stopStream] = inputCMD(Chan, Curr)

%inputCMD(Chan, Curr)
%Chan is channel to be plated (0 - 63) or '411' for all channels
%Curr is platinization current (0 - 500) in mA

HIA = [1, 0, 1, 0, 1, 0, 0];

OCCHAN = [0, 0, 0];

OCDV = [0, 0, 1];

OCSTART = [0, 1, 0];

OCSTOP = [1, 0, 0];

NULL = [0, 0, 0, 0, 0, 0, 0, 0, 0];

if Chan == 411
    
    CA = [0, 0, 1, 0, 0, 0, 0, 0, 0];

elseif Chan <= 63
    
    chanAdr = de2bi(Chan, 6, 'left-msb');
    CA = [[0, 0, 0], chanAdr];

end

scaledCurr = Curr / 500;
scaledCurr = scaledCurr * 32;
scaledCurr = round(scaledCurr);
    
dvValue = de2bi(scaledCurr, 5, 'left-msb');
DV = [0, dvValue, [0, 0, 0]];
 
startStream = [HIA, OCCHAN, CA, HIA, OCDV, DV, HIA, OCSTART, NULL];
stopStream = [HIA, OCSTOP, NULL];