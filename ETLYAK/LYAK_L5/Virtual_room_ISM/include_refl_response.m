function sw_incl = include_refl_response(desired_order, virtual_room_coord)

% *************************************************************************
% Partial function for VirtualRoomDesign:
%
%   sw_incl = include_refl_response(desired_order, virtual_room_coord)
%
% Determines if the actual reflection is to be included in the final response
% based on desired virtual room order (0: all, N: only if order N)
%
% rev. 1.0
% Lars G. Johansen, AU_ASE
%
% *************************************************************************


if desired_order==100
    sw_incl = 1;
else
    if sum(abs(virtual_room_coord))==desired_order
        sw_incl = 1;
    else
        sw_incl = 0;
    end
end

