function vs_dist = virtual_source_dist(vrc)

% *************************************************************************
% Partial function for VirtualRoomDesign:
%
%   vs_dist = virtual_source_dist(vrc, room_dim, source_coord, receiver_coord)
%
% Calculates the travel distance in meters between the virtual source
% in a mirror room and the receiver
%
% rev. 1.0
% Lars G. Johansen, AU_ASE
%
% *************************************************************************


[room_dim, source_coord, receiver_coord] = def_room_coord;

if mod(vrc(1),2) == 0  % even number of mirrors in x dimension
    position_x = vrc(1)*room_dim(1)+source_coord(1);
elseif mod(vrc(1),2) == 1  % odd number of mirrors in x dimension
    position_x = (vrc(1)+1)*room_dim(1)-source_coord(1);
end

if mod(vrc(2),2) == 0  % even number of mirrors in y dimension
    position_y = vrc(2)*room_dim(2)+source_coord(2);
elseif mod(vrc(2),2) == 1  % odd number of mirrors in y dimension
    position_y = (vrc(2)+1)*room_dim(2)-source_coord(2);
end

if mod(vrc(3),2) == 0  % even number of mirrors in z dimension
    position_z = vrc(3)*room_dim(3)+source_coord(3);
elseif mod(vrc(3),2) == 1  % odd number of mirrors in z dimension
    position_z = (vrc(3)+1)*room_dim(3)-source_coord(3);
end


% Calculating distance between mirror source and the receiver
vs_dist = sqrt((position_x-receiver_coord(1))^2 + ...
               (position_y-receiver_coord(2))^2 + ...
               (position_z-receiver_coord(3))^2);

