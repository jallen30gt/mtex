function odf = mrdivide(odf,s)
% scaling of the ODF
%
% overload the / operator, i.e. one can now write @ODF / 2  in order
% to scale an ODF
%
%% See also
% ODF_index ODF/plus ODF/mtimes

argin_check(odf,'ODF');
argin_check(s,'double');

for i = 1:length(odf)
  odf(i).c_hat = odf(i).c_hat ./ s;
  odf(i).c = odf(i).c ./ s;
end
