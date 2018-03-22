function [IR_delayed, DelayTime] = align_refl_response(IRtemp, MS_dist, resp_length, csound, fs, inclRefl)

% *************************************************************************
% Partial function for VirtualRoomDesign:
%
%   [IR_delayed, DelayTime] = align_refl_response(IRtemp, MS_dist, resp_length, csound, fs, inclRefl)
%
% Calculates the delayed response for the reflection
% 
%
% rev. 1.0
% Lars G. Johansen, AU_ASE
%
% *************************************************************************


if inclRefl==1
    DelayTime = MS_dist/csound;
    DelaySamples = round(DelayTime*fs);
    IR_delayed = [zeros(1,DelaySamples) IRtemp];
    IR_delayed = IR_delayed(1: resp_length);
elseif inclRefl==0
    DelayTime = [];
    IR_delayed = 0;
end

