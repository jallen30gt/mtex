function [density,omega] = calcAngleDistribution(odf,varargin)
% compute the angle distribution of an ODF or an MDF 
%
%
%% Input
%  odf - @ODF
%  omega - list of angles
%
%% Flags
%  EVEN       - calculate even portion only
%
%% Output
%  x   - values of the axis distribution
%
%% See also



if ~check_option(varargin,'fast')

  % get resolution
  res = get_option(varargin,'resolution',0.5*degree);
  
  % initialize evaluation grid
  S3G = quaternion;
  iS3G = 0;
  
  % the angle distribution of the uniformODF
  [density,omega] = angleDistribution(get(odf,'CS'));

  % for all angles
  for k=1:numel(omega)  
    
    S2G = S2Grid('equispaced','points',max(1,round(4/3*sin(omega(k)/2).^2/res^2))); % create a grid
        
    % create orientations
    o = axis2quat(S2G,omega(k));
    
    % and select those
    rotAngle = abs(dot_outer(o,get(odf,'CS')));
    maxAngle = max(rotAngle,[],2); 
    o = o(rotAngle(:,1)>maxAngle-0.0001);
    
    % store these orientations
    S3G = [S3G,o]; %#ok<AGROW>
    iS3G(k+1) = numel(S3G); %#ok<AGROW>
    
  end
  
  % evaluate the ODF at the grid
  f = eval(odf,S3G); %#ok<EVLC>
  
  % integrate
  for k = 1:numel(omega)    
    if iS3G(k)<iS3G(k+1)
      density(k) = density(k) * mean(f(iS3G(k)+1:iS3G(k+1)));
    end
  end
  
else
      

  % get resolution
  points = get_option(varargin,'points',100000);
  
  % get resolution
  res = get_option(varargin,'resolution',2.5*degree);
  
  %% simluate EBSD data
  ebsd = calcEBSD(odf,points,'resolution',res);

  % compute angles
  angles = angle(get(ebsd,'orientations'));

  maxangle = max(angles);


  %% perform kernel density estimation

  [bandwidth,density,omega] = kde(angles,2^8,0,maxangle); %#ok<ASGLU>

  density = density ./ mean(density) * pi ./ maxangle;
  
end

% where to evaluate
%omega = linspace(0,maxangle,100);

% 
%sigma = 20;
%psi = @(a,b) exp(-(a-b).^2*sigma.^2);

%
%x = sum(bsxfun(psi,angles,omega));
%x = x./sum(x)*numel(x);
