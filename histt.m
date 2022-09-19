function varargout = histt(varargin)
% HISTT MATLAB code for histt.fig
%      HISTT, by itself, creates a new HISTT or raises the existing
%      singleton*.
%
%      H = HISTT returns the handle to a new HISTT or the handle to
%      the existing singleton*.
%
%      HISTT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HISTT.M with the given input arguments.
%
%      HISTT('Property','Value',...) creates a new HISTT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before histt_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to histt_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help histt

% Last Modified by GUIDE v2.5 01-Aug-2022 15:50:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @histt_OpeningFcn, ...
                   'gui_OutputFcn',  @histt_OutputFcn, ...
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
% End initialization code - DO NOT EDIT


% --- Executes just before histt is made visible.
function histt_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to histt (see VARARGIN)

% Choose default command line output for histt
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes histt wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = histt_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Btn_CitraAsli.
function Btn_CitraAsli_Callback(hObject, eventdata, handles)
% hObject    handle to Btn_CitraAsli (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Button Input Citra Asli Untuk Histogram
[filename, pathname] = uigetfile({'*.jpg';});
citra = imread([pathname, filename]);
axes(handles.axes3);
imshow(citra);

handles.input = citra;
guidata(hObject,handles);

cla(handles.axes6);


% --- Executes on button press in Btn_HistAsli.
function Btn_HistAsli_Callback(hObject, eventdata, handles)
% hObject    handle to Btn_HistAsli (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Button Proses Histogram Citra Asli
inputCitra = handles.input;
axes(handles.axes6);

histogram(inputCitra);
grid on;

ir = inputCitra(:,:,1);
ig = inputCitra(:,:,2);
ib = inputCitra(:,:,3);

histogram(ir,'FaceColor','r','EdgeColor','r');
hold on;
grid on;
histogram(ig,'FaceColor','g','EdgeColor','g');
histogram(ib,'FaceColor','b','EdgeColor','b');


% --- Executes on button press in Btn_CitraAsli.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to Btn_CitraAsli (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Btn_HistAsli.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to Btn_HistAsli (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Btn_HistMed.
function Btn_HistMed_Callback(hObject, eventdata, handles)
% hObject    handle to Btn_HistMed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Button Proses Histogram Median Filter
inputCitra3 = handles.input3;
axes(handles.axes8);

histogram(inputCitra3);
grid on;

ir = inputCitra3(:,:,1);
ig = inputCitra3(:,:,2);
ib = inputCitra3(:,:,3);

histogram(ir,'FaceColor','r','EdgeColor','r');
hold on;
grid on;
histogram(ig,'FaceColor','g','EdgeColor','g');
histogram(ib,'FaceColor','b','EdgeColor','b');

% --- Executes on button press in Btn_HistMSR.
function Btn_HistMSR_Callback(hObject, eventdata, handles)
% hObject    handle to Btn_HistMSR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Button Proses Histogram MSR
inputCitra2 = handles.input2;
axes(handles.axes7);

histogram(inputCitra2);
grid on;

ir = inputCitra2(:,:,1);
ig = inputCitra2(:,:,2);
ib = inputCitra2(:,:,3);

histogram(ir,'FaceColor','r','EdgeColor','r');
hold on;
grid on;
histogram(ig,'FaceColor','g','EdgeColor','g');
histogram(ib,'FaceColor','b','EdgeColor','b');


% --- Executes on button press in Btn_CitraMed.
function Btn_CitraMed_Callback(hObject, eventdata, handles)
% hObject    handle to Btn_CitraMed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Button Input Citra Median Filter
[filename, pathname] = uigetfile({'*.jpg';});
citra3 = imread([pathname, filename]);
axes(handles.axes5);
imshow(citra3);

handles.input3 = citra3;
guidata(hObject,handles);

cla(handles.axes8);

% --- Executes on button press in Btn_CitraMSR.
function Btn_CitraMSR_Callback(hObject, eventdata, handles)
% hObject    handle to Btn_CitraMSR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Button Input CItra MSR
[filename, pathname] = uigetfile({'*.jpg';});
citra2 = imread([pathname, filename]);
axes(handles.axes4);
imshow(citra2);

handles.input2 = citra2;
guidata(hObject,handles);

cla(handles.axes7);


% --------------------------------------------------------------------
function home1_Callback(hObject, eventdata, handles)
% hObject    handle to home1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(histt,'visible','off');
HCover;

% --------------------------------------------------------------------
function enhanc1_Callback(hObject, eventdata, handles)
% hObject    handle to enhanc1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(histt,'visible','off');
enhanc;

% --------------------------------------------------------------------
function hist1_Callback(hObject, eventdata, handles)
% hObject    handle to hist1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function help1_Callback(hObject, eventdata, handles)
% hObject    handle to help1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(histt,'visible','off');
bantu;

% --------------------------------------------------------------------
function exit1_Callback(hObject, eventdata, handles)
% hObject    handle to exit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
closereq();
