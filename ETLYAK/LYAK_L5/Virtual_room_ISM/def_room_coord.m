function [dimensions_room, coord_source, coord_receiver] = def_room_coord

% *************************************************************************
% Partial function for VirtualRoomDesign:
%
%   [dimensions_room, coord_source, coord_receiver] = def_room_coord
%
% Defines the coordinates for source and receiver in the virtual room
% as well as the room dimensions
%
% rev. 1.0
% Lars G. Johansen, AU_ASE
%
% *************************************************************************


dimensions_room  = [4, 7, 2.5];

coord_source     = [0.8, 5.5, 0.9];
%coord_source     = [3, 6, 0.9];
coord_receiver   = [2.5, 1, 1.1];
%coord_receiver   = [3, 3, 1.1];

