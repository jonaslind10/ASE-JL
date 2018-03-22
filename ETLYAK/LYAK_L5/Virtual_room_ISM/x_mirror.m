function [IR_final DelayRef] = x_mirror(VR_order_max, fs, sw_surfIRs, sw_lspk, sw_diffuse, sw_aural)

% *************************************************************************
% Partial function for VirtualRoomDesign:
%
%   IR_final = x_mirror(virtual_room_order, fs, sw_surfIRs, sw_lspk, sw_diffuse, sw_aural)
%
% Determines the set of early reflections in a virtual room response
% using the Image Source Method
%
% rev. 1.4
% Lars G. Johansen, AU_ASE
%
% *************************************************************************


ResponseTime = 2;
LengthResponse = ResponseTime*fs;
csound = 343;

% ***** Initialiseringer mm ***********************************************
IR_final = zeros(1,LengthResponse);
IR_temp0 = [1 zeros(1,LengthResponse-1)];
DelayRef = [];

% *************************************************************************


for vrx = -VR_order_max:VR_order_max
for vry = -VR_order_max:VR_order_max
for vrz = -VR_order_max:VR_order_max

virtual_room_coord = [vrx vry vrz];
if sum(abs(virtual_room_coord)) <= VR_order_max


% **************************************************************************** 
% Calculates total absorption for each reflection
%    sw=0: Average absorption for each surface is used
%    sw=1: Frequency dependent absorption used (surface IRs)
% ****************************************************************************
SurfaceHits = surface_hits(virtual_room_coord);
absorp_coeff = def_absorp_coef;
absorp_cavrg = mean(absorp_coeff')';
switch sw_surfIRs
    case 0
        IR_reflected = absorption_surfs(absorp_cavrg, SurfaceHits);
    case 1
        IR_surfs = surface_IRs(absorp_coeff);
        IR_reflected = absorption_surfs(IR_surfs, SurfaceHits);
    case 2
        IR_reflected = 1;
end
IR_temp1 = conv(IR_temp0, IR_reflected);
% **************************************************************************** 


% **************************************************************************** 
% Puts on loudspeaker response - optional
%    sw=0: No speaker response imposed
%    sw=1: On-axis response imposed as omnidirectional characteristic
%    sw=2: Full omnidirectional characteristic
% **************************************************************************** 
IR_temp2 = IR_temp1;
switch sw_lspk
    case 0
        IR_speaker = 1;
    case 1
        IR_speaker = speaker_onaxIR(fs);  % finder en on-axis response
    case 2
        [angle_src_h, angle_src_v] = angles_emitted(virtual_room_coord, room_dim, src, rec);
        IR_speaker = speaker_onaxIR;  % finder en on-axis response
        IR_spk_charact = speaker_charact(angle_src_h, angle_src_v);
        IR_temp2 = conv(IR_temp1, IR_spk_charact);
end
IR_temp2 = conv(IR_temp2, IR_speaker);
% ****************************************************************************


% **************************************************************************** 
% Inserts diffuse reflections - optional
%    sw=0: No diffusion, only specular reflections
% **************************************************************************** 
switch sw_diffuse
    case 0
        IR_temp3 = IR_temp2;
    otherwise
        IR_temp3 = diffuse_refl(IR_temp2, sw_diffuse);
end
% ****************************************************************************


% **************************************************************************** 
% Puts on HRTF - optional
%    sw=0: No HRTF imposed
%    sw=1: 
%    sw=2: HRTF
% **************************************************************************** 
switch sw_aural
    case 0
        IR_hrtf = 1;
    case 'leftright'
        [angle_rec_h, angle_rec_v] = angles_received(virtual_room_coord, room_dim, src, rec);
        IR_hrtf = HRTF_base(angle_rec_h, angle_rec_v, leftright);
end
IR_temp4 = conv(IR_temp3, IR_hrtf);
% ****************************************************************************


% **************************************************************************** 
% Calculates distance absorption for each reflection
% **************************************************************************** 
MirrorSourceDist = virtual_source_dist(virtual_room_coord);
distance_absorp = absorption_dist(MirrorSourceDist, csound);
IR_temp5 = distance_absorp*IR_temp4;


% **************************************************************************** 
% Include reflection in final IR (based on desired order)
%   sw=100: All reflections
%   sw=N: Only order N reflections
% **************************************************************************** 
des_order = 100;
sw_incl = include_refl_response(des_order, virtual_room_coord);


% **************************************************************************** 
% Aligns the reflection response according to delay
% **************************************************************************** 
[IR_aligned, DelayTime] = align_refl_response(IR_temp5, MirrorSourceDist, LengthResponse, csound, fs, sw_incl);

IR_final = IR_final + IR_aligned;
DelayRef = [DelayRef DelayTime];


end
end
end
end

DelayRef = sort(DelayRef);
timeaxis = [0:1/fs:ResponseTime-1/fs];
figure(1)
plot(1000*timeaxis(1:round(0.07*fs)), IR_final(1:round(0.07*fs)),'b');
xlabel('t (ms)'), ylabel('amplitude (normalized)')

