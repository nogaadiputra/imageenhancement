function varargout = enhanc(varargin)
% ENHANC MATLAB code for enhanc.fig
%      ENHANC, by itself, creates a new ENHANC or raises the existing
%      singleton*.
%
%      H = ENHANC returns the handle to a new ENHANC or the handle to
%      the existing singleton*.
%
%      ENHANC('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ENHANC.M with the given input arguments.
%
%      ENHANC('Property','Value',...) creates a new ENHANC or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before enhanc_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to enhanc_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help enhanc

% Last Modified by GUIDE v2.5 21-May-2022 19:08:05

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @enhanc_OpeningFcn, ...
                   'gui_OutputFcn',  @enhanc_OutputFcn, ...
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


% --- Executes just before enhanc is made visible.
function enhanc_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to enhanc (see VARARGIN)

% Choose default command line output for enhanc
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes enhanc wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = enhanc_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Btn_Input.
function Btn_Input_Callback(hObject, eventdata, handles)
% hObject    handle to Btn_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Button Input Citra
global citra;
[filename, pathname, filterindex] = uigetfile({'*.jpg'},'Plih citra');
handles.myImage = strcat(pathname, filename);
citra = imread(handles.myImage);
gg = strcat(pathname, filename);
axes(handles.axes1);
imshow(citra);

set (handles.W1,'string');
set (handles.W2,'string');
set (handles.W3,'string');
set (handles.S1,'string');
set (handles.S2,'string');
set (handles.S3,'string');
set (handles.Btn_MSR,'enable','on');

% --- Executes on button press in Btn_MSR.
function Btn_MSR_Callback(hObject, eventdata, handles)
% hObject    handle to Btn_MSR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Button Proses Multiscale Retinex
global citra;
global MSR;
global I;
I=citra;
Ir=I(:,:,1);
Ig=I(:,:,2);
Ib=I(:,:,3);
G = 192;
b = -30;
alpha = 125;
beta = 46;
Ir_double=double(Ir);
Ig_double=double(Ig);
Ib_double=double(Ib);
sigma_1=str2double(get(handles.S1,'string'));
sigma_2=str2double(get(handles.S2,'string'));
sigma_3=str2double(get(handles.S3,'string'));
weight_1=str2double(get(handles.W1,'string'));
weight_2=str2double(get(handles.W2,'string'));
weight_3=str2double(get(handles.W3,'string'));

%Perhitungan Gaussian
[x, y]=meshgrid((-(size(Ir,2)-1)/2):(size(Ir,2)/2),(-(size(Ir,1)-1)/2):(size(Ir,1)/2));
gauss_1=exp(-(x.^2+y.^2)/(2*sigma_1*sigma_1));
Gauss_1=gauss_1/sum(gauss_1(:));
gauss_2=exp(-(x.^2+y.^2)/(2*sigma_2*sigma_2));
Gauss_2=gauss_2/sum(gauss_2(:));
gauss_3=exp(-(x.^2+y.^2)/(2*sigma_3*sigma_3));
Gauss_3=gauss_3/sum(gauss_3(:));
Ir_log=log(Ir_double+1);
f_Ir=fft2(Ir_double);
fgauss=fft2(Gauss_1,size(Ir,1),size(Ir,2));
fgauss=fftshift(fgauss);
Rr=ifft2(fgauss.*f_Ir);
min1=min(min(Rr));
Rr_log= log(Rr - min1+1);
Rr1=Ir_log-Rr_log;
fgauss=fft2(Gauss_2,size(Ir,1),size(Ir,2));
fgauss=fftshift(fgauss);
Rr= ifft2(fgauss.*f_Ir);
min1=min(min(Rr));
Rr_log= log(Rr - min1+1);
Rr2=Ir_log-Rr_log;
fgauss=fft2(Gauss_3,size(Ir,1),size(Ir,2));
fgauss=fftshift(fgauss);
Rr= ifft2(fgauss.*f_Ir);
min1=min(min(Rr));
Rr_log= log(Rr - min1+1);
Rr3=Ir_log-Rr_log;
Rr=(weight_1*Rr1)+(weight_2*Rr2)+(weight_3*Rr3); 

%Weighted summation
MSR1 = Rr;
SSR1 = Rr2;
CRr = beta*(log(alpha*Ir_double+1)-log(Ir_double+Ig_double+Ib_double+1));
%SSR
min1 = min(min(SSR1));
max1 = max(max(SSR1));
SSR1 = uint8(255*(SSR1-min1)/(max1-min1));

min1 = min(min(MSR1));
max1 = max(max(MSR1));
MSR1 = uint8(255*(MSR1-min1)/(max1-min1));
%MSR
Rr = G*(CRr.*Rr+b);
min1 = min(min(Rr));
max1 = max(max(Rr));
Rr_final = uint8(255*(Rr-min1)/(max1-min1));
Ig_log=log(Ig_double+1);
f_Ig=fft2(Ig_double);
fgauss=fft2(Gauss_1,size(Ig,1),size(Ig,2));
fgauss=fftshift(fgauss);
Rg= ifft2(fgauss.*f_Ig);
min2=min(min(Rg));
Rg_log= log(Rg-min2+1);
Rg1=Ig_log-Rg_log;
fgauss=fft2(Gauss_2,size(Ig,1),size(Ig,2));
fgauss=fftshift(fgauss);
Rg= ifft2(fgauss.*f_Ig);
min2=min(min(Rg));
Rg_log= log(Rg-min2+1);
Rg2=Ig_log-Rg_log;
fgauss=fft2(Gauss_3,size(Ig,1),size(Ig,2));
fgauss=fftshift(fgauss);
Rg= ifft2(fgauss.*f_Ig);
min2=min(min(Rg));
Rg_log= log(Rg-min2+1);
Rg3=Ig_log-Rg_log;
Rg=(weight_1*Rg1)+(weight_2*Rg2)+(weight_3*Rg3);
%Perhitungan Weight
SSR2 = Rg2;
MSR2 = Rg;
CRg = beta*(log(alpha*Ig_double+1)-log(Ir_double+Ig_double+Ib_double+1));
%SSR:
min2 = min(min(SSR2));
max2 = max(max(SSR2));
SSR2 = uint8(255*(SSR2-min2)/(max2-min2));
%MSR
min2 = min(min(MSR2));
max2 = max(max(MSR2));
MSR2 = uint8(255*(MSR2-min2)/(max2-min2));
Rg = G*(CRg.*Rg+b);
min2 = min(min(Rg));
max2 = max(max(Rg));
Rg_final = uint8(255*(Rg-min2)/(max2-min2));
Ib_log=log(Ib_double+1);
f_Ib=fft2(Ib_double);
fgauss=fft2(Gauss_1,size(Ib,1),size(Ib,2));
fgauss=fftshift(fgauss);
Rb= ifft2(fgauss.*f_Ib);
min3=min(min(Rb));
Rb_log= log(Rb-min3+1);
Rb1=Ib_log-Rb_log;
fgauss=fft2(Gauss_2,size(Ib,1),size(Ib,2));
fgauss=fftshift(fgauss);
Rb= ifft2(fgauss.*f_Ib);
min3=min(min(Rb));
Rb_log= log(Rb-min3+1);
Rb2=Ib_log-Rb_log;
fgauss=fft2(Gauss_3,size(Ib,1),size(Ib,2));
fgauss=fftshift(fgauss);
Rb= ifft2(fgauss.*f_Ib);
min3=min(min(Rb));
Rb_log= log(Rb-min3+1);
Rb3=Ib_log-Rb_log;
Rb=(weight_1*Rb1)+(weight_2*Rb2)+(weight_3*Rb3);
CRb = beta*(log(alpha*Ib_double+1)-log(Ir_double+Ig_double+Ib_double+1));
SSR3 = Rb2;
MSR3 = Rb;
%SSR:
min3 = min(min(SSR3));
max3 = max(max(SSR3));
SSR3 = uint8(255*(SSR3-min3)/(max3-min3));
%MSR
min3 = min(min(MSR3));
max3 = max(max(MSR3));
MSR3 = uint8(255*(MSR3-min3)/(max3-min3));
Rb = G*(CRb.*Rb+b);
min3 = min(min(Rb));
max3 = max(max(Rb));
Rb_final = uint8(255*(Rb-min3)/(max3-min3));
Int = (Ir_double + Ig_double + Ib_double) / 3.0;
Int_log = log(Int+1);
f_Int=fft2(Int_log);
fgauss=fft2(Gauss_1,size(Int,1),size(Int,2));
fgauss=fftshift(fgauss);
RInt=ifft2(fgauss.*f_Int);
min1=min(min(RInt));
RInt_log= RInt - min1+1;
RInt1=Int_log-RInt_log;
fgauss=fft2(Gauss_2,size(Int,1),size(Int,2));
fgauss=fftshift(fgauss);
RInt= ifft2(fgauss.*f_Int);
min1=min(min(RInt));
RInt_log= RInt - min1+1;
RInt2=Int_log-RInt_log;
fgauss=fft2(Gauss_3,size(Int,1),size(Int,2));
fgauss=fftshift(fgauss);
RInt= ifft2(fgauss.*f_Int);
min1=min(min(RInt));
RInt_log= RInt - min1+1;
RInt3=Int_log-RInt_log;
RInt=(weight_1*RInt1)+(weight_2*RInt2)+(weight_3*RInt3);
minInt = min(min(RInt));
maxInt = max(max(RInt));
Int1 = uint8(255*(RInt-minInt)/(maxInt-minInt));
MSRr = zeros(size(I, 1), size(I, 2));
MSRg = zeros(size(I, 1), size(I, 2));
MSRb = zeros(size(I, 1), size(I, 2));
for ii = 1 : size(I, 1)
for jj = 1 : size(I, 2)
 C = max(Ig_double(ii, jj), Ib_double(ii, jj));
 B = max(Ir_double(ii, jj), C);
 A = min(255.0 / B, Int1(ii, jj) / Int(ii, jj));
 MSRr(ii, jj) = A * Ir_double(ii, jj);
 MSRg(ii, jj) = A * Ig_double(ii, jj);
 MSRb(ii, jj) = A * Ib_double(ii, jj);
end
end
minInt = min(min(MSRr));
maxInt = max(max(MSRr));
MSRr = uint8(255*(MSRr-minInt)/(maxInt-minInt));
minInt = min(min(MSRg));
maxInt = max(max(MSRg));
MSRg = uint8(255*(MSRg-minInt)/(maxInt-minInt));
minInt = min(min(MSRb));
maxInt = max(max(MSRb));
MSRb = uint8(255*(MSRb-minInt)/(maxInt-minInt));
SSR1 = cat(3,SSR1,SSR2,SSR3);
SSR2 = cat(3,MSR1,MSR2,MSR3);
SSR3=cat(3,Rr_final,Rg_final,Rb_final);
MSR = cat(3, MSRr, MSRg, MSRb);
if (sigma_1 > 0) && (sigma_2 > 0) && (sigma_3 > 0) && (weight_1 > 0) && (weight_2 > 0) && (weight_3 >0)
if (weight_1 + weight_2 + weight_3) == 1
 sigma_1=str2double(get(handles.S1,'string'));
 sigma_2=str2double(get(handles.S2,'string'));
 sigma_3=str2double(get(handles.S3,'string'));
 weight_1=str2double(get(handles.W1,'string'));
 weight_2=str2double(get(handles.W2,'string'));
 weight_3=str2double(get(handles.W3,'string'));
 
 axes(handles.axes2);
 imshow(SSR1);
 
 axes(handles.axes3);
 imshow(SSR2);
 
 axes(handles.axes4);
 imshow(SSR3);
 Im=citra;
 L = max(Im, [], 3);
 %MSRetinex2(Im, sigmaS, saturatedpix, precision)
 ret = MSRetinex2(mat2gray(L), [sigma_1,sigma_2,sigma_3], [weight_1 weight_2], 8);
 %ret2 = MSRetinex2(mat2gray(L), sigmaS,saturatedpix, precision);
 Ihsv = rgb2hsv(Im);
 Ihsv(:, :, 3) = mat2gray(ret);
 R2 = hsv2rgb(Ihsv);
 MSR=R2;
 axes(handles.axes5);
 imshow(MSR);
 set (handles.BtnMed,'enable','on');
 set (handles.Btn_MSR,'enable','off');
else
 msgbox('Total Weight harus = 1');
end
else
 msgbox('Isi Parameter Sigma dan Weight dengan benar');
end

% --- Executes on button press in SaveMSR.
function SaveMSR_Callback(hObject, eventdata, handles)
% hObject    handle to SaveMSR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Button Simpan Citra MSR
global MSR;
[namafile,direktori]=uiputfile({'*.jpg';'*.bmp'},'simpan citra hasil');
if isequal (namafile,0)
 errordlg('Error ..!','Nama file citra tidak ada');
return;
else
 imwrite(MSR,strcat(direktori,namafile));
 msgbox('Berhasil Menyimpan Citra');
end
set (handles.saveMSR,'enable','off');

% --- Executes on button press in BtnMed.
function BtnMed_Callback(hObject, eventdata, handles)
% hObject    handle to BtnMed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Button Proses Median Filter
global MSR;
global MSRFilter;
img = MSR;
R = img (:,:,1);
G = img (:,:,2);
B = img (:,:,3);
medfilimg (:,:,1) = medfilt2 (R);
medfilimg (:,:,2) = medfilt2 (G);
medfilimg (:,:,3) = medfilt2 (B);
MSRFilter = medfilimg;
axes(handles.axes6);
imshow(MSRFilter);

set(handles.BtnMed,'enable','off');

% --- Executes on button press in SaveMed.
function SaveMed_Callback(hObject, eventdata, handles)
% hObject    handle to SaveMed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Button Simpan Citra Median Filter
global MSRFilter;
[namafile,direktori]=uiputfile({'*.jpg'},' Simpan citra hasil Median Filter');
if isequal (namafile,0)
 errordlg('Error ..!','Nama file citra tidak ada');
return;
else
 imwrite(MSRFilter,strcat(direktori,namafile));
 msgbox('Berhasil Menyimpan Citra');
end
set (handles.SaveMed,'enable','off');

% --- Executes on button press in BtnReset.
function BtnReset_Callback(hObject, eventdata, handles)
% hObject    handle to BtnReset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Button Reset
set (handles.W1,'string','');
set (handles.W2,'string','');
set (handles.W3,'string','');
set (handles.S1,'string','');
set (handles.S2,'string','');
set (handles.S3,'string','');

cla(handles.axes1,'reset');
cla(handles.axes2,'reset');
cla(handles.axes3,'reset');
cla(handles.axes4,'reset');
cla(handles.axes5,'reset');
cla(handles.axes6,'reset');

set(gca,'XTick',[])
set(gca,'YTick',[])
clear all; 


function W1_Callback(hObject, eventdata, handles)
% hObject    handle to W1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of W1 as text
%        str2double(get(hObject,'String')) returns contents of W1 as a double


% --- Executes during object creation, after setting all properties.
function W1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to W1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function S1_Callback(hObject, eventdata, handles)
% hObject    handle to S1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of S1 as text
%        str2double(get(hObject,'String')) returns contents of S1 as a double


% --- Executes during object creation, after setting all properties.
function S1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to S1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function W2_Callback(hObject, eventdata, handles)
% hObject    handle to W2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of W2 as text
%        str2double(get(hObject,'String')) returns contents of W2 as a double


% --- Executes during object creation, after setting all properties.
function W2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to W2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function S2_Callback(hObject, eventdata, handles)
% hObject    handle to S2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of S2 as text
%        str2double(get(hObject,'String')) returns contents of S2 as a double


% --- Executes during object creation, after setting all properties.
function S2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to S2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function W3_Callback(hObject, eventdata, handles)
% hObject    handle to W3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of W3 as text
%        str2double(get(hObject,'String')) returns contents of W3 as a double


% --- Executes during object creation, after setting all properties.
function W3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to W3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function S3_Callback(hObject, eventdata, handles)
% hObject    handle to S3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of S3 as text
%        str2double(get(hObject,'String')) returns contents of S3 as a double


% --- Executes during object creation, after setting all properties.
function S3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to S3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
% Fungsi Menu
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(enhanc,'visible','off');
HCover;

% --------------------------------------------------------------------
function Untitled_2_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_3_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(enhanc,'visible','off');
histt;

% --------------------------------------------------------------------
function Untitled_4_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(enhanc,'visible','off');
bantu;

% --------------------------------------------------------------------
function Untitled_5_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
closereq();
