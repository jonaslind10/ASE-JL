function IR_reflected = absorption_surfs(IR_surfs, SurfaceHits)

% *************************************************************************
% Partial function for VirtualRoomDesign:
%
%   IR_reflected = absorption_surfs(IR_surfs, SurfaceHits)
%
% Calculates the total absorption in the surfaces
% 
%
% rev. 1.0
% Lars G. Johansen, AU_ASE
%
% *************************************************************************


Dim_of_IR = size(IR_surfs);

if Dim_of_IR(2) == 1
    IR_reflected = prod((1-IR_surfs).^SurfaceHits);
else
    tempIR=1;
    for surf=1:6
        if SurfaceHits(surf) > 0
            for k=1:SurfaceHits(surf)
                tempIR = conv(tempIR, IR_surfs(surf,:));
            end
        end
    end
    IR_reflected = tempIR;
end

