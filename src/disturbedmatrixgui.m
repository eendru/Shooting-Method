function varargout = disturbedmatrixgui(varargin)
% DISTURBEDMATIXGUI MATLAB code for disturbedmatixgui.fig
%      DISTURBEDMATIXGUI, by itself, creates a new DISTURBEDMATIXGUI or raises the existing
%      singleton*.
%
%      H = DISTURBEDMATIXGUI returns the handle to a new DISTURBEDMATIXGUI or the handle to
%      the existing singleton*.
%
%      DISTURBEDMATIXGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DISTURBEDMATIXGUI.M with the given input arguments.
%
%      DISTURBEDMATIXGUI('Property','Value',...) creates a new DISTURBEDMATIXGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before disturbedmatixgui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to disturbedmatixgui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help disturbedmatixgui

% Last Modified by GUIDE v2.5 21-Dec-2014 18:01:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @disturbedmatixgui_OpeningFcn, ...
                   'gui_OutputFcn',  @disturbedmatixgui_OutputFcn, ...
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


% --- Executes just before disturbedmatixgui is made visible.
function disturbedmatixgui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to disturbedmatixgui (see VARARGIN)

% Choose default command line output for disturbedmatixgui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

    dimension = varargin{:};
    set(handles.text_dimension, 'String', dimension);
    set(handles.uitable_disturbedmatrix, 'ColumnEditable', true, 'ColumnWidth', num2cell(ones(1, dimension)*60));
    data = cell(dimension, dimension);
    for i = 1 : 1 : dimension
        for j = 1 : 1 : dimension
            data{i, j} = sprintf('');
        end
    end
    
    set(handles.uitable_disturbedmatrix, 'Data', data);
    
% UIWAIT makes disturbedmatixgui wait for user response (see UIRESUME)
% 


% --- Outputs from this function are returned to the command line.
function varargout = disturbedmatixgui_OutputFcn(hObject, eventdata, handles) 
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
     data = get (handles.uitable_disturbedmatrix, 'Data');
     basicA = basicmatrixfile(dimension);
     wrfiledistmtrx(basicA, data, dimension);

     delete(handles.figure1)
