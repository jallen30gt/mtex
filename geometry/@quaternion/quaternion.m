classdef quaternion
    
  properties
    a % real part
    b % * i
    c % * j
    d % * k
  end
  
  methods
    function q = quaternion(varargin)
      
      if nargin == 0, return;end
      
      if isa(varargin{1},'quaternion')   % copy constructor
              
          q.a = varargin{1}.a(varargin{2:end});
          q.b = varargin{1}.b(varargin{2:end});
          q.c = varargin{1}.c(varargin{2:end});
          q.d = varargin{1}.d(varargin{2:end});
          
      elseif isa(varargin{1},'vector3d')
          
        q.a = zeros(size(varargin{1}));
        [q.b,q.c,q.d] = double(varargin{1});
          
      elseif isnumeric(varargin{1})
          
        switch nargin
            
          case 1
              
            D = varargin{1};
              
            [q.a, q.b, q.c, q.d] = deal(D(1,:),D(2,:),D(3,:),D(4,:));
            
            s = size(D);
            s = [1 s(2:ndims(D))];
            
            q = reshape(q,s);
              
          case 2
              
            if length(varargin{1}) ~= 1
              q.a = varargin{1};
            else
              q.a = repmat(varargin{1},size(varargin{2}));
            end
            [q.b,q.c,q.d] = double(varargin{2});
            
          case 4
            
              [q.a, q.b, q.c, q.d] = deal(varargin{:});
              
        end
      end
      
    end
  end
  
end
