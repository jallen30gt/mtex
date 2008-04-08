function wizard = import_frame( varargin )
%% option handle

if ~check_option(varargin,'type')
  return
else type = get_option(varargin,'type');
end

w = get_option(varargin,'width',400,'double');
h = get_option(varargin,'height',380,'double');
name = get_option(varargin,'name','Wizard','char');

%% define gui
scrsz = get(0,'ScreenSize');
wizard = figure('MenuBar','none',...
 'Name',[type ' ' name],...
 'Resize','off',...
 'WindowStyle','modal',...
 'NumberTitle','off',...
 'color',[0.71 0.71 0.71],...
 'Position',[(scrsz(3)-w)/2 (scrsz(4)-h)/2 w h]);

uicontrol('BackgroundColor',[1 1 1],...
 'Parent',wizard,...
 'Position',[-3 h-45 w+5 50],...
 'String','',...
 'Style','text',...
 'HandleVisibility','off',...
 'HitTest','off');
name = uicontrol(...
  'Parent',wizard,...
 'FontSize',12,...
 'FontWeight','bold',...
 'BackgroundColor',[1 1 1],...
 'HorizontalAlignment','right',...
 'Position',[w-100 h-37 90 20],...
 'String',type,...
 'Style','text',...
 'HandleVisibility','off',...
 'HitTest','off');