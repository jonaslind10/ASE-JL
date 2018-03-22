function absorp_coeff = def_absorp_coef

% *************************************************************************
% Partial function for VirtualRoomDesign:
%
%   abs_coeff = absorp_coeff
%
% Defines the absorption coefficients for the six room surfaces
% in eight octave bands (63, 125, 250, 500, 1k, 2k, 4k, 8k)
%
% rev. 1.0
% Lars G. Johansen, AU_ASE
%
% *************************************************************************


absorp_coeff = 0.6*[0.21 0.29 0.41 0.55 0.58 0.70 0.90 0.96; ...    
                     0.25 0.29 0.47 0.35 0.53 0.78 0.90 0.98; ...
                     0.35 0.22 0.36 0.35 0.48 0.79 0.92 0.94; ...
                     0.35 0.26 0.29 0.45 0.55 0.79 0.96 0.96; ...
                     0.20 0.32 0.38 0.45 0.60 0.85 0.92 0.95; ...
                     0.15 0.32 0.41 0.35 0.51 0.74 0.90 0.94];

