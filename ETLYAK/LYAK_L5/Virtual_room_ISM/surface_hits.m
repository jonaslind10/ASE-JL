function number_of_reflections = surface_hits(virtual_room_coord)

% *************************************************************************
% Partial function for VirtualRoomDesign:
%
%   number_of_reflections = surface_hits(virtual_room_coord)
%
% Calculates the number of reflections on each surface for a given
% mirror source (left-right-front-back-up-down)
%
% rev. 1.0
% Lars G. Johansen, AU_ASE
%
% *************************************************************************


number_of_reflections = [];


% Number of hits on Left and Right surfaces (x-direction)
if mod(abs(virtual_room_coord(1)),2) == 1
    if virtual_room_coord(1) > 0
        hit_number_Right = ceil(abs(virtual_room_coord(1))/2);
        hit_number_Left  = abs(virtual_room_coord(1)) - hit_number_Right;
    else
        hit_number_Left  = ceil(abs(virtual_room_coord(1))/2);
        hit_number_Right = abs(virtual_room_coord(1)) - hit_number_Left;
    end
else
    hit_number_Right = abs(virtual_room_coord(1))/2;
    hit_number_Left  = hit_number_Right;
end

number_of_reflections(1:2,1) = [hit_number_Left hit_number_Right];


% Number of hits on Front and Back surfaces (y-direction)
if mod(abs(virtual_room_coord(2)),2) == 1
    if virtual_room_coord(2) > 0
        hit_number_Back  = ceil(abs(virtual_room_coord(2))/2);
        hit_number_Front = abs(virtual_room_coord(2)) - hit_number_Back;
    else
        hit_number_Front = ceil(abs(virtual_room_coord(2))/2);
        hit_number_Back  = abs(virtual_room_coord(2)) - hit_number_Front;
    end
else
    hit_number_Back  = abs(virtual_room_coord(2))/2;
    hit_number_Front = hit_number_Back;
end

number_of_reflections(3:4,1) = [hit_number_Front hit_number_Back];


% Number of hits on Up and Down surfaces (z-direction)
if mod(abs(virtual_room_coord(3)),2) == 1
    if virtual_room_coord(3) > 0
        hit_number_Down = ceil(abs(virtual_room_coord(3))/2);
        hit_number_Up   = abs(virtual_room_coord(3)) - hit_number_Down;
    else
        hit_number_Up   = ceil(abs(virtual_room_coord(3))/2);
        hit_number_Down = abs(virtual_room_coord(3)) - hit_number_Up;
    end
else
    hit_number_Down = abs(virtual_room_coord(3))/2;
    hit_number_Up   = hit_number_Down;
end

number_of_reflections(5:6,1) = [hit_number_Up hit_number_Down];

