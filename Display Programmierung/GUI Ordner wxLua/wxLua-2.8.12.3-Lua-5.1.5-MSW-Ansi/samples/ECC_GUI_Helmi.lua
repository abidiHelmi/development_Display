-- to create the new GUI which does the following : 
-- the are t2 rectangles one to set the amplitude and the other to set the frequency. Near each rectangle there is such a button , when it is touched , the information will be sent to the ECC. 
--then there are two buttons : one t start continous movement and the second for the step movement, and one of them is touched like a stop button will show up. 






function send_frequency(event)
-- to get the value of the Label and do the following tests : 
-- to see whether its really a frequency, means to test whether the user entred number and then Hz/Khz... if not show an error message and return 
--  to compare it with the recent frequency (i think it is not necessary )
local frequency = tonumber(dynamic_frequency) ; 
if (frequency == nil)
then 
 wx.wxMessageBox('You need a number string ', "Wrong Frequency", wx.wxOK , wx.NULL,  -1,  -1 ); 
end 
local label = dynamic_frequency:GetValue() ; 
print(label , "I am the ouptut of the send function ") ; 
return
end 
--


function send_amplitude(event)
-- to get the value of the Label and do the following tests : 
-- to see whether its really a frequency, means to test whether the user entred number and then Hz/Khz... if not show an error message and return 
--  to compare it with the recent frequency (i think it is not necessary )
-- to test if amplitude is a number string 
local amplitude= tonumber(dynamic_amplitude ) ; 
if (amplitude== nil )
then 
 wx.wxMessageBox('You need a number string ', "Wrong Amplitude", wx.wxOK , wx.NULL,  -1,  -1 ); 

end 
----
local label = dynamic_amplitude:GetValue() ; 
print(label , "I am the ouptut of the send function ") ; 
return
end 
----

function start_continous_Movement(event) 
-- to send the appropriate command to the ECC to starrt the movement. 

-- to show all the useful parameters on the screen and enable its changement 
-- to show the options bkwd or fwd ??? 
--
--
return
end 
----
function start_step_Movement(event)
-- to send the appropriate command to the ECC to starrt the movement. 

-- to show all the useful parameters on the screen and enable its changement 
-- to show the options bkwd or fwd ??? 
return
end 
---
function move_to(event)

print("move to ") ; 
return
end 
----
function update_position(event)
print('i am updating the position')  ; 
return 
end 
-----
function update_information(event)
-- to update the position label; (to read it from the ECC )
print ('I am updating information right now !!!') ; 
return 
end 
----

function main()

local mon_frame= wx.wxFrame(wx.NULL ,wx.wxID_ANY,'ECC GUI',wx.wxPoint(25,25),wx.wxSize(1000,1000),wx.wxDEFAULT_FRAME_STYLE) ;  

--to create the Menubar of the GUI

local first_axis_menu = wx.wxMenu() ; 
first_axis_menu : Append(1,'&Show Screen ','show the axis 1 screen ') ;
local second_axis_menu = wx.wxMenu() ; 
second_axis_menu : Append(2,'&Show second Screen ','show the axis 2 screen ') ;
local third_axis_menu = wx.wxMenu() ; 
third_axis_menu : Append(3,'&Show third Screen ','show the axis 3 screen ') ;

local menu_bar = wx.wxMenuBar() ; 
menu_bar : Append(first_axis_menu , 'AXIS 1') ;  
menu_bar : Append(second_axis_menu , 'AXIS 2') ;  
menu_bar : Append(third_axis_menu , 'AXIS 3') ;  
 -- attach the menu bar into the frame
 mon_frame:SetMenuBar(menu_bar) ;
 -- create a simple status bar
mon_frame:CreateStatusBar(1)
mon_frame:SetStatusText("Welcome to wxLua.") 
-----------------------------------------------------------

--Now I need to generate for each axis like an appropriate screen 
--frame:Connect(ID_CLEAR_LOG, wx.wxEVT_COMMAND_MENU_SELECTED,
                 -- function (event) textCtrl:Clear() end )
mon_frame:Connect(1,wx.wxEVT_COMMAND_MENU_SELECTED, function (event)   print("Show 1 selected ")     end ); 
-- create the static texts amplitude and frequency 

local frequency = wx.wxStaticText(mon_frame,wx.wxID_ANY,'Frequency',wx.wxPoint(50,50),wx.wxSize(200,200),0,'static') ; 
local amplitude = wx.wxStaticText(mon_frame,wx.wxID_ANY,'Amplitude',wx.wxPoint(50,100), wx.wxSize(200,200),0,'ghdh' ) ; 

---------------
--create the dynamic labels

 dynamic_frequency = wx.wxTextCtrl(mon_frame, wx.wxID_ANY, 'here will be written the current frequency', wx.wxPoint(100,50), wx.wxSize(250,20),wx.wxTE_PROCESS_ENTER, wx.wxDefaultValidator, 'editable string') ; 
dynamic_amplitude = wx.wxTextCtrl(mon_frame, wx.wxID_ANY, 'here will be written the current amplitude', wx.wxPoint(100,100), wx.wxSize(250,20),wx.wxTE_PROCESS_ENTER, wx.wxDefaultValidator, 'editable string') ; 

--------------------------
-- to create the buttons near the editable strings ; 
send_button_frequency = wx.wxButton(mon_frame, wx.wxID_ANY, "send to ECC",wx.wxPoint(400,50), wx.wxSize(100,20)  ) ;
 send_button_amplitude = wx.wxButton(mon_frame, wx.wxID_ANY, "send to ECC",wx.wxPoint(400,100), wx.wxSize(100,20)  ) ;
-- to connect the buttons with a function getting the value of the current labels and then executing the appropriate function for the ECC 

send_button_frequency:Connect(wx.wxEVT_COMMAND_BUTTON_CLICKED, send_frequency )         
send_button_amplitude:Connect(wx.wxEVT_COMMAND_BUTTON_CLICKED, send_amplitude )         

 -------------------------------------
-- to define position static text 
position=  wx.wxStaticText(mon_frame,wx.wxID_ANY,'Position',wx.wxPoint(50,150),wx.wxSize(200,200),0,'static') ; 
-- to define position updatable text 
 dynamic_position = wx.wxTextCtrl(mon_frame, wx.wxID_ANY, 'here will be written the current position', wx.wxPoint(100,150), wx.wxSize(250,20),wx.wxTE_PROCESS_ENTER, wx.wxDefaultValidator, 'editable string') ; 
dynamic_position:Connect(wx.wxID_ANY, wx.wxEVT_COMMAND_TEXT_ENTER, function (event)   print("move to ")     end ) ; 
-- to create an update button it needs to be clicked in order to update all the changes.
ID_Update = 10 ;  
update_button= wx.wxButton(mon_frame,ID_Update, 'UPDATE',wx.wxPoint(540,68), wx.wxSize(75,50)) ; 
update_button:Connect(wx.wxEVT_COMMAND_BUTTON_CLICKED, update_information)
-------------------------------------
-- to create the buttons for starting the movement 
continous_button= wx.wxButton(mon_frame, wx.wxID_ANY, "START Continous Movement", wx.wxPoint(250,200),wx.wxSize(250,50)) ; 
step_button= wx.wxButton(mon_frame, wx.wxID_ANY, "START Step Movement", wx.wxPoint(550,200),wx.wxSize(250,50)) ; 
-- to connect these buttons with functions doing the appropriate thing 
continous_button:Connect(wx.wxEVT_COMMAND_BUTTON_CLICKED, start_continous_Movement) ; 
step_button:Connect(wx.wxEVT_COMMAND_BUTTON_CLICKED, start_step_Movement) ;
-----------------------------------------
mon_frame: Show(true) ; 
return 
end 
-------------------------------------------------------
-------------------------------------------------------

main() 
wx.wxGetApp():MainLoop()