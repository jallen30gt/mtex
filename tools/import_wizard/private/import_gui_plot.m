function handles = import_gui_plot( handles )
%IMPORT_GUI_PLOT Summary of this function goes here
%   Detailed explanation goes here

pos = get(handles.wzrd,'Position');
h = pos(4);
w = pos(3);

ph = 270;


handles.page4 = get_panel(w,h,ph);

uicontrol(...
  'Parent',handles.page4,...
  'BackgroundColor',[1 1 1],...
  'FontName','monospaced',...
  'HorizontalAlignment','left',...
  'Position',[10 25 w-40 ph-35 ],...
  'String',blanks(0),...
  'Style','edit',...
  'Enable','inactive');

handles.runmfile = uicontrol(...
  'Parent',handles.page4,...
  'Style','checkbox',...
  'String','Generate M-File',...
  'FontWeight','bold',...
  'position',[10 5 130 20]);