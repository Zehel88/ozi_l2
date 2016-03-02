%% Инициализационная часть 
function varargout = l2_main(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @l2_main_OpeningFcn, ...
                   'gui_OutputFcn',  @l2_main_OutputFcn, ...
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

function l2_main_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);

function varargout = l2_main_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;



function pref_btn_ClickedCallback(hObject, eventdata, handles)
%% Кнопка настроек
run('l2_pref.m')



function T1_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function T1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function T1s_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function T1s_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function pushbutton1_Callback(hObject, eventdata, handles)
%% Зашифровать
% Загрузка настроек
load('Pref.mat');
clc
% Алфавит
alf=Pref{1,2};
% Значения для мнодителя (взаимно однозначные)
a=str2double(Pref{2,2});
% Значения слагаемого
b=str2double(Pref{3,2});
% Обьем алфавита
m=numel(alf);
% Исходный первый текст
T1=upper(get(handles.T1,'String'));
% Исходный второй текст
T2=upper(get(handles.T2,'String'));

% Шифруем первый текст
for t1=1:numel(T1)
% Определяем индекс отн алфавита
ind_in_alf=find(T1(t1)==alf)-1;
% Вычисляем новое значение
new_ind=mod(a*ind_in_alf+b,m);
% Получаем шифрованный символ      
T1s(t1)=alf(new_ind+1);
end
% Выводим результат
set(handles.T1s,'String',T1s);

% Шифруем второй текст
for t2=1:numel(T2)
% Определяем индекс отн алфавита  
ind_in_alf=find(T2(t2)==alf)-1;
% Вычисляем новое значение
new_ind=mod(a*ind_in_alf+b,m);
% Получаем шифрованный символ    
T2s(t2)=alf(new_ind+1);
end
% Выводим результат
set(handles.T2s,'String',T2s)

function T22_Callback(hObject, eventdata, handles)

function T22_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function T2s_Callback(hObject, eventdata, handles)

function T2s_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function pushbutton2_Callback(hObject, eventdata, handles)
%% Расшифровать
clc
% Исходный первый текст
T1=upper(get(handles.T1,'String'));
% Исходный второй текст
T2=upper(get(handles.T2,'String'));
% Первый шифротекст
T1s=upper(get(handles.T1s,'String'));
% Второй шифротекст
T2s=upper(get(handles.T2s,'String'));
% Первоначальный анализ указывает на то, что при шифровании используется
% как минимум Русский алфавит
alf='АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЬЫЪЭЮЯ';
% Символы употребляющиеся в тексте и не входящие в алфавит
mb_alf=(unique(strcat(T1,T2,T1s)));
% Обьединенный алфавит используем для расшифровки
alf=(strcat(alf,mb_alf(~ismember(mb_alf,alf))));
% Буферные переменные для нахождения связанных символов
xx=1;yy=1;
X=[];Y=[];
% Определение первой пары связанных символов
while numel(X)<2 
    if ~isempty(find(T1(xx)==alf)) && ~isempty(find(T1s(xx)==alf)) 
    X=[X find(T1(xx)==alf)-1 find(T1s(xx)==alf)-1]
    end
    xx=xx+1;
end
% Определение второй пары связанных символов
while numel(Y)<2 
    if ~isempty(find(T1(yy)==alf)) && ~isempty(find(T1s(yy)==alf))  && yy~=xx-1
    Y=[Y find(T1(yy)==alf)-1 find(T1s(yy)==alf)-1]
    end
    yy=yy+1;
end
% Установив соответствие между символами (благодаря исходному первому тексту)
% определим возможные значения ключа

% Буферная переменная цикла
n2stop=0;
% Обьем алфавита
m=numel(alf);
% Буферные переменные
A=[];B=[];
% Значения слагаемого (отн варианта 5)
b=3:15;
% Цикл поиска ключа
while n2stop~=1
% Определение взаимно однозначных чисел для обьема
a=VzaimOD(m);
for i=1:numel(a)
    for j=1:numel(b)
% Проверка на соответствие проверяемых a b
        res=try_ab(a(i),b(j),m,X,Y);
% Если они удовлетворяют выбранным соответствиям то записываем их        
        if res(1)==0 &&  res(2)==0
          A=[A a(i)];
           B=[B b(j)];
        end
    end
end
% В случае не нахождения подходящих a b
if isempty(A)==1
% Увеличиваем обьем алфавита
               m=m+1;
% Выходим из цикла в случае превышения некоторого значения
               if m>200
                   return
               end
% Дополняем алфавит
alf=strcat(alf,char(174)); 
else
% В случае нахождения подходящих a b 
% Определяем обратное число к a по модулю m
[G C D]=gcd(A,m);
if D>0
   a_=m+C; 
else
    a_=C;
end
% Пробуем расшифровать второй шифротекст при помощи найденного ключа
for i=1:numel(T2s)
% Определяем индекс символа в алфавите
s_ind=find(T2s(i)==alf)-1;
if ~isempty(s_ind)
% Вычисляем индекс для исходного символа
ind=mod(a_*(s_ind-B),m);
% Получаем символ
T22(i)=alf(ind+1);
end
end
% Выводим результат
set(handles.T22,'String',T22);
% Сохраним данные параметры, для продолжения поиска ключа, позволяющего
% максимально точно расшифровать 2 текст
prev.X=X; prev.Y=Y;
prev.m=m;prev.alf=alf;
save('prev.mat','prev')

n2stop=1;
end

end


%% функция проверки ключа 
function res=try_ab(a,b,m,x,y)
res(1)=mod(a*x(1)+b,m)-x(2);
res(2)=mod(a*y(1)+b,m)-y(2);

%% функция поиска возимно однозначных чисел 
function a_s=VzaimOD(m)
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
   a_s(i)=var_a(i); 
end


function edit5_Callback(hObject, eventdata, handles)



function edit5_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function T2_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function pushbutton3_Callback(hObject, eventdata, handles)
%% Уточнить 
% Получаем второй шифротекст
T2s=get(handles.T2s,'String');
% Загружаем параметры декодирования
load('prev.mat');
% Буферные переменные
n2stop=0;b=3:15;
A=[];B=[];
% Цикл поиска ключа
while n2stop~=1
% Поиск взаимно-однозначных чисел
   a=VzaimOD(prev.m);
% Цикл поиска ключа   
for i=1:numel(a)
    for j=1:numel(b)
% Проверка ключа на соответствие
res=try_ab(a(i),b(j),prev.m,prev.X,prev.Y);
% Запись подходящего ключа        
if res(1)==0 &&  res(2)==0
          A=[A a(i)];
           B=[B b(j)];
        end
    end
end
if isempty(A)==1
               prev.m=prev.m+1;
	if prev.m>200
                            errordlg('Превышено время ожидания');
                                return
   	end
prev.alf=strcat(prev.alf,char(174)); 
else
% Определение обратного числа по модулю
[G C D]=gcd(A,prev.m);
if D>0
   a_=prev.m+C; 
else
    a_=C;
end
% Декодирование
for i=1:numel(T2s)
s_ind=find(T2s(i)==prev.alf)-1;
if ~isempty(s_ind)
ind=mod(a_*(s_ind-B),prev.m);
T22(i)=prev.alf(ind+1);
end
end
% Вывод результата
set(handles.T22,'String',T22);

prev.m=prev.m+1;
save('prev.mat','prev')

n2stop=1;
end

end