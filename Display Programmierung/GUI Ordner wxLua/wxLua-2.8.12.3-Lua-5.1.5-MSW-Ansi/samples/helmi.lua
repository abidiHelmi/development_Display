-- Goal of the programm : to show  the string
package.cpath = package.cpath..";./?.dll;./?.so;../lib/?.so;../lib/vc_dll/?.dll;../lib/bcc_dll/?.dll;../lib/mingw_dll/?.dll;"
require("wx")





function sleep(a) 
  local sec = tonumber(os.clock() + a); 
  while (os.clock() < sec) do end 
  end
function main_axis1()
print('ich bin aktiviert') ; 
local user_label = wx.wxTextCtrl(mon_frame, wx.wxID_ANY, 'the presehjklrkljknt frequency', wx.wxPoint(10,60), wx.wxSize(100,80),wx.wxTE_PROCESS_ENTER, wx.wxDefaultValidator, 'editable string') ; 
user_label : Enable(false) ; 
return 
end 
function main_axis2()
print('ich bin aktiviert') ; 
local this = wx.wxControl(mon_frame, wx.wxID_ANY,wx.wxPoint(450,150), wx.wxSize(150,30), wx.wxNO_BORDER)      -- local this = wx.wxControl(parent, id, pos, size, wx.wxNO_BORDER) /////////// i need to know more about the styles ; 
local dc = wx.wxPaintDC(this) ; 
dc : DrawRectangle(80,80,150,30) ;  --void DrawRectangle(wxCoord x, wxCoord y, wxCoord width, wxCoord height ); 

return 
end 
----try to connect mon_bouton 
function mon_bouton_clicked(event)
  mon_bouton :SetForegroundColour(wx.wxRED) ; 
return 
end 
-----

function main()
-- to create the frame  
local mon_frame= wx.wxFrame(wx.NULL ,wx.wxID_ANY,'my first frame',wx.wxPoint(25,25),wx.wxSize(1000,1000),wx.wxDEFAULT_FRAME_STYLE) ;  
-- i will create first of all a wxsize and a wxpoint object : 

-- to create a wxwindow 
-- need to create its size 
--local taille_window , position_window = wx.wxSize(150,150) , wx.wxPoint(20,20) ; 
--local parent_window = wx.wxWindow(wx.NULL, wx.wxID_ANY,position_window,taille_window,wx.wxBORDER_SIMPLE,'helmi_first_window') ; 


-- to create the wxsize and the wxPOint correspondly for size and position 
local taille, position  = wx.wxSize(50,35) ,wx.wxPoint(200,150) ; 
-- i need to know how to set the size and the colour of the label 
-- to create the static text object 
local text = wx.wxStaticText(mon_frame,wx.wxID_ANY,'Frequency',position,taille,0,'static') ; 
local text_2 = wx.wxStaticText(mon_frame,wx.wxID_ANY,'Amplitude',wx.wxPoint(500,500), wx.wxSize(200,200),0,'ghdh' ) ; 

--??????????????????????????????????????
-- how to get the user write something and read it ?????????????????????????
--??????????????????????????????????????

-- to create wxColour i order to set the colour of the labels : virtual void SetBackgroundColour(const wxColour& colour ); 
-- to call the constructor of wxColour

local ma_couleur = wx.wxColour(255,0,0,wx.wxALPHA_OPAQUE) ;                    -- wxColour(unsigned char red, unsigned char green, unsigned char blue, unsigned char alpha=wxALPHA_OPAQUE)
--text : SetBackgroundColour(ma_couleur) ; -- hethi t7otlik el couleur fel cadre mta3 el size ; 
text : SetForegroundColour(ma_couleur) ; 

-- taw lezwmni nchouf el size  ????? 

------------------------------------------------------------------------------
-- to draw a rectangle 
--local my_first_Rectangle = wx.wxDC() ; 
--my_first_Rectangle: DrawRectangle(80,80,150,30) ;  --void DrawRectangle(wxCoord x, wxCoord y, wxCoord width, wxCoord height ); 

--local my_first_Rectangle_2 = wx.wxDC() ; 
--my_first_Rectangle_2 : DrawRectangle(80,150,150,30) ; 
local this = wx.wxControl(mon_frame, wx.wxID_ANY,wx.wxPoint(450,150), wx.wxSize(150,30), wx.wxNO_BORDER)      -- local this = wx.wxControl(parent, id, pos, size, wx.wxNO_BORDER) /////////// i need to know more about the styles ; 
local dc = wx.wxPaintDC(this) ; 
dc : DrawRectangle(80,80,150,30) ;  --void DrawRectangle(wxCoord x, wxCoord y, wxCoord width, wxCoord height ); 
local text_on_rectangle = wx.wxStaticText(mon_frame,wx.wxID_ANY,'text on retangle', wx.wxPoint(460,160),wx.wxSize(100,20),0,'helmi') ; 
text_on_rectangle :SetBackgroundColour(wx.wxColour(255,255,255,wx.wxALPHA_OPAQUE)) ; 
-- next step is to know how to set the labels how to update them 
-- to create a user editable label 
local user_label = wx.wxTextCtrl(mon_frame, wx.wxID_ANY, 'the updateble  POSI', wx.wxPoint(10,60), wx.wxSize(100,80)) ; 
--local user_label = wx.wxTextCtrl(mon_frame, wx.wxID_ANY, 'the presehjklrkljknt frequency', wx.wxPoint(10,60), wx.wxSize(100,80),wx.wxTE_PROCESS_ENTER, wx.wxDefaultValidator, 'editable string') ; 
user_label : Enable(true) ;
user_label:Connect(wx.wxID_ANY, wx.wxEVT_COMMAND_TEXT_ENTER, function (event)   print("move to ")end ) ;              --dialog:Connect(wx.wxID_ANY, wx.wxEVT_COMMAND_TEXT_ENTER,


local chaine = user_label : GetLabel() ; 
print(chaine ) ; 
local str = user_label : GetLineText(0) ; 
print(str) ; 
print(type(str)) ; 
--user_label : Destroy() ; 
--[
local str = 'nombre de fois ' ; 
for i= 0,10 do 
--sleep(2) ; 
print('le nombre de fois ',i) ; 
sleep (0.1) ;
text : SetLabel(str.. tostring(i)) ; 
end 
--]]

-- the next step will be how to set touchbuttons or toggle regions depending on what I want to create ;
 -- i will create like a toggle button 
local mon_bouton = wx.wxToggleButton(mon_frame, wx.wxID_ANY, 'STOP', wx.wxPoint(90,90), wx.wxSize(40,50), 0, wx.wxDefaultValidator, 'stop button') ;  -- SetEvtHandlerEnabled(bool enabled)
mon_bouton : SetValue(true)
mon_bouton : Enable(true);
--mon_bouton:connect(wx.wxEVT_COMMAND_BUTTON_CLICKED, mon_bouton_clicked) ; 
print('etat de mon bouton ',mon_bouton : GetValue()) ; 

--mon_bouton : SetValue(false) ; 
--print(mon_bouton : GetValue()) ; 
if (mon_bouton : GetValue() == true ) 
    then
  print(2) ; 
  mon_bouton :SetForegroundColour(wx.wxRED) ; 
  else   mon_bouton : SetForegroundColour(wx.wxBLUE) ; 
end
mon_bouton : Destroy() ; 

-- the last step will be how to do a conditional screen if time is  pressed show that and that /  if position is pressed do that and that : function needed is : ispressed or a function which ask the modus of the button. 
--- i will try to set a new menu bar 
-- wxMenu(const wxString& title = "", long style = 0)
--local Menu_table ={wx.wxMenu('', 0),wx.wxMenu('', 0),wx.wxMenu('', 0)} ; 
--local Menu = wx.wxMenuBar(3,Menu_table, {'Axis 1','Axis 2','Axis 3'}, 0 );                                            -- wxMenuBar(size_t n, wxMenu* menus[], const wxString titles[], long style = 0)
--local Menu = wx.wxMenu('my first menu ', 0) ; 
wx.wxEVT_COMMAND
--[[
-- create a simple file menu
    local fileMenu = wx.wxMenu()
    fileMenu:Append(wx.wxID_EXIT, "E&xit", "Quit the program")

    -- create a simple help menu
    local helpMenu = wx.wxMenu()
    helpMenu:Append(1, "&About", "About the wxLua Minimal Application")
    --helpMenu:Append(wx.wxID_ABOUT, "&About", "About the wxLua Minimal Application")

    -- create a menu bar and append the file and help menus
    local menuBar = wx.wxMenuBar()
    menuBar:Append(fileMenu, "&File")
    menuBar:Append(helpMenu, "&Help")

    -- attach the menu bar into the frame
    mon_frame:SetMenuBar(menuBar)
 --]] 
local first_axis_menu = wx.wxMenu() ; 
first_axis_menu : Append(1,'&Show 1 ','show the axis 1 screen ') ;
local second_axis_menu = wx.wxMenu() ; 
second_axis_menu : Append(2,'&Show 2 ','show the axis 2 screen ') ;
local third_axis_menu = wx.wxMenu() ; 
third_axis_menu : Append(3,'&Show 3 ','show the axis 3 screen ') ;

local menu_bar = wx.wxMenuBar() ; 

menu_bar : Append(first_axis_menu , 'AXIS 1') ;  
menu_bar : Append(second_axis_menu , 'AXIS 2') ;  
menu_bar : Append(third_axis_menu , 'AXIS 3') ;  

 -- attach the menu bar into the frame
 mon_frame:SetMenuBar(menu_bar) ;
    -- create a simple status bar
    mon_frame:CreateStatusBar(1)
    mon_frame:SetStatusText("Welcome to wxLua.") 

mon_frame: Show(true) ; 
while (true) do 
-- to print a string on the screen 
local i = 10 ; 
local this = wx.wxControl(mon_frame, wx.wxID_ANY,wx.wxPoint(450,150), wx.wxSize(150,30), wx.wxNO_BORDER)      -- local this = wx.wxControl(parent, id, pos, size, wx.wxNO_BORDER) /////////// i need to know more about the styles ; 
local dc = wx.wxPaintDC(this) ; 
dc : DrawRectangle(i,80,10,10) ;  --void DrawRectangle(wxCoord x, wxCoord y, wxCoord width, wxCoord height ); 
i = i +50 ; 
end 
mon_frame: Show(true) ;  
--Menu : Append(wx.wxMenuItem(Menu, wx.wxID_SEPARATOR, 'first item ', '', wx.wxITEM_NORMAL, ))
--wxMenu::Append(wxMenu(self), wxMenuItem) ; -- wxMenuItem(wxMenu* parentMenu = NULL, int id = wxID_SEPARATOR, const wxString& text = "", const wxString& helpString = "", wxItemKind kind = wxITEM_NORMAL, wxMenu* subMenu = NULL) ; 
--Menu : Append(wx.wxMenu('',0), 'Axis 2') ;  --bool Append(wxMenu *menu, const wxString& title)
--Menu : Append(wx.wxMenu('',0), 'Axis 3') ;  --bool Append(wxMenu *menu, const wxString& title)


return 
end 
---





main() 
wx.wxGetApp():MainLoop()