function surf_IR = surface_IRs(abs_coeff)

% *************************************************************************
% Partial function for VirtualRoomDesign:
%
%   surf_IR = surface_IRs(abs_coeff)
%
% Calculates the equivalent surface impulse responses based on absorption
% coefficients given in eight octave bands (and extrapolated)
%
% rev. 1.0
% Lars G. Johansen, AU_ASE
%
% *************************************************************************


freq_full = 1:24000;
freq_for_abs = [1 16 31 63 125 250 500 1000 2000 ...
                4000 8000 12000 16000 20000 24000];
N_fir = 2400;
N_lpc = 512;
N_end = 512;


% Extrapolation of absorption down in frequency (1 16 31 Hertz)
abs_extr_down = [0.05*ones(6,1) 0.1*ones(6,1) 0.15*ones(6,1)];
abs_coeff_extr = [abs_extr_down abs_coeff];

% Extrapolation of absorption up in frequency (12k 16k 20k 24k Hertz)
abs_extr_up = [0.96*ones(6,1) 0.98*ones(6,1) 0.99*ones(6,1) 0.99*ones(6,1)];
abs_coeff_extr = [abs_coeff_extr abs_extr_up];


% Calculating reflection magnitudes and 
% equivalent surface impulse responses
reflection_mag = 1-abs_coeff_extr;

for i=1:6
    refl_spectrum = spline(freq_for_abs, reflection_mag(i,:), freq_full);
    h_linearphase = fir2(N_fir, [0:23999]/23999, refl_spectrum);
    [alpc, pred_error] = lpc(h_linearphase,N_lpc);
    gain = sqrt(pred_error*N_fir);
    surf_IR(i,:) = gain*filter(1,alpc,[1 zeros(1,N_fir-1)]);
end

surf_IR = surf_IR(:,1:N_end);

