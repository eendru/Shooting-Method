function varargout = basicmatrix(varargin)
% BASICMATRIX MATLAB code for basicmatrix.fig
%      BASICMATRIX, by itself, creates a new BASICMATRIX or raises the existing
%      singleton*.
%
%      H = BASICMATRIX returns the handle to a new BASICMATRIX or the handle to
%      the existing singleton*.
%
%      BASICMATRIX('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BASICMATRIX.M with the given input arguments.
%
%      BASICMATRIX('Property','Value',...) creates a new BASICMATRIX or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before basicmatrix_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to basicmatrix_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help basicmatrix

% Last Modified by GUIDE v2.5 21-Dec-2014 17:47:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @basicmatrix_OpeningFcn, ...
                   'gui_OutputFcn',  @basicmatrix_OutputFcn, ...
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


% --- Executes just before basicmatrix is made visible.
function basicmatrix_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to basicmatrix (see VARARGIN)

% Choose default command line output for basicmatrix

  dimension = varargin{1}
  selectF   = varargin{2}
  
  %select = va
  handles.output = hObject;
  % Update handles structure
  guidata(hObject, handles);

% UIWAIT makes basicmatrix wait for user response (see UIRESUME)

  set(handles.text_dimension, 'String', dimension);
  set(handles.uitable_basicmatrix, 'ColumnEditable', true, 'ColumnWidth', num2cell(ones(1, dimension)*60));
    data = cell(dimension, dimension);

    for i = 1 : 1 : dimension
        for j = 1 : 1 : dimension
            data{i, j} =  0;
        end
    end
    if selectF == 3
        set(handles.edit_pv, 'Visible', 'on');
    else
        set(handles.edit_pv, 'Visible', 'off');
    end
    set(handles.uitable_basicmatrix, 'Data', data);
    



% --- Outputs from this function are returned to the command line.
function varargout = basicmatrix_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_OK.
function pushbutton_OK_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_OK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

     dimension =  str2double(get(handles.text_dimension, 'String'));
     data = get (handles.uitable_basicmatrix, 'Data');
     
     if strcmp(get(handles.edit_pv, 'Visible'), 'on') == 1
         pv = get(handles.edit_pv, 'String');
         wrfilepvmtrx(data, pv, dimension);
     else
         wrfilebscmtrx(data, dimension);
     end
     
     lamda = str2double(get(handles.edit_lambda, 'String'));
     writelamdafile(lamda);
     delete(handles.figure1);



function edit_pv_Callback(hObject, eventdata, handles)
% hObject    handle to edit_pv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_pv as text
%        str2double(get(hObject,'String')) returns contents of edit_pv as a double

    str2double(get(hObject,'String'))
    

% --- Executes during object creation, after setting all properties.
function edit_pv_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_pv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_lambda_Callback(hObject, eventdata, handles)
% hObject    handle to edit_lambda (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_lambda as text
%        str2double(get(hObject,'String')) returns contents of edit_lambda as a double

  lambda = str2double(get(hObject,'String'));
  if (isnan(lambda))
        lambda = 1;
  end
  
  set(hObject, 'String', num2str(lambda));
  
  
% --- Executes during object creation, after setting all properties.
function edit_lambda_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_lambda (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
