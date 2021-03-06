function varargout = l2_pref(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @l2_pref_OpeningFcn, ...
                   'gui_OutputFcn',  @l2_pref_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end


% --- Executes just before l2_pref is made visible.
function l2_pref_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);
%% ����_���������
load('Pref.mat');
% ����������� ����������� ��������
set(handles.edit1,'String',Pref{1,2});

set(handles.popupmenu1,'Value',find(strcmp(Pref{2,2},get(handles.popupmenu1,'String'))==1))

set(handles.popupmenu2,'Value',find(strcmp(Pref{3,2},get(handles.popupmenu2,'String'))==1))

set(handles.edit4,'String',numel(Pref{1,2}));


% --- Outputs from this function are returned to the command line.
function varargout = l2_pref_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)
clc
set(handles.edit4,'String',num2str(numel(get(handles.edit1,'String'))));
m=numel(get(handles.edit1,'String'));
var_a=1:7;
ch=[2 3 5 7];
res=mod(m,ch);
n2d=[];
if res(1)==0
    n2d=[n2d 2 4 6];
end
if res(2)==0
    n2d=[n2d 3 6];
end
if res(3)==0
    n2d=[n2d 5];
end

if res(4)==0
    n2d=[n2d 7];
end
n2d=unique(n2d);
var_a(n2d)='';

for i=1:numel(var_a)
   a_str{i,:}=var_a(i); 
end
set(handles.popupmenu1,'Value',1);
set(handles.popupmenu1,'String',a_str);




function edit1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit2_Callback(hObject, eventdata, handles)

function edit2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)


function edit3_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit4_Callback(hObject, eventdata, handles)



function edit4_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function pushbutton1_Callback(hObject, eventdata, handles)
%% ������ "�������"
load('Pref.mat');
% ��������� ����� ��������
Pref{1,2}=get(handles.edit1,'String');

a_str=get(handles.popupmenu1,'String');
Pref{2,2}=a_str(get(handles.popupmenu1,'Value'));

b_str=get(handles.popupmenu2,'String');
Pref{3,2}=b_str(get(handles.popupmenu2,'Value'));


Pref{4,2}=numel(Pref{1,2});
a=get(handles.popupmenu1,'String');
b=get(handles.popupmenu2,'String');
save('a.mat','a');
save('b.mat','b');
% ���������� ��������
save('Pref.mat','Pref');
% �������� ����� ��������
close('���������')

function pushbutton2_Callback(hObject, eventdata, handles)
%% ������ "������"
% �������� ����� ��������
close('���������')


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)



% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
