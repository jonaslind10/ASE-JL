function IR_speaker = speaker_onaxIR(fs)

% *************************************************************************
% Partial function for VirtualRoomDesign:
%
%   IR_speaker = speaker_onaxIR
%
% Finds an anechoic speaker response from data file
% (presently simply a bandpass filter)
%
% rev. 1.0
% Lars G. Johansen, AU_ASE
%
% *************************************************************************


[b,a] = butter(6,[80 15000]/(0.5*fs));

IR_speaker = filter(b,a,[1 zeros(1,999)]);

