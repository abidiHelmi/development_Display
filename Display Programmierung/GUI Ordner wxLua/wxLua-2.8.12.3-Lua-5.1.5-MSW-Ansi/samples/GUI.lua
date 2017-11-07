-- TEST GUI FOR MOTION CONTROLLER 
-- AUTHOR : Abidi Helmi 
-- Supervisor : M.Sc Daniel Schiessl 
------------------------------------------------------------------------------------------
package.cpath = package.cpath..";./?.dll;./?.so;../lib/?.so;../lib/vc_dll/?.dll;../lib/bcc_dll/?.dll;../lib/mingw_dll/?.dll;"
require("wx")
local ECC = require ('ECC') ; 
local LUA_functions = require('LUA_functions') ; 
local axisNumber = 0; 
--------------------------------------
-- the program will contain a main function and two other subfunctions (or for I do not know actually ) each of the two subfunctions will show the information of each Mode : Time or position 
 

--\\\\ function end of travel \\\\\ 
-- implementation without sensors using time constants 
function ECC.EndofTravelWithoutSensors(axisNumber,time_in_label,time_out_label , START_button, STOP_button,EXIT_button) 
  local time_in_A=  tonumber( time_in_label : GetLineText(0) ) ;                      -- time constants  representing the Period which take one axis to end its forward travel
  local time_out_A = tonumber(time_out_label : GeltLineText(0) ) ;                   -- time constants  representing the Period which take one axis to end its backward travel
  -- clock definition for the axis : 
  local clock_A = os.clock() ; 
  -- to get the directions  
 local Fwd_A= ECC.GetForward(axisNumber)   ;                                          -- if it is true the positioner is in the forward direction. if it is false it is in the backward direction 
 
while (true )  do  -- MAIN Loop 
-- if stop is pressed then stop the movement (depending to the direction ) 

if (STOP_button : GetValue() == true )
then
--according to the direction you ned to stop the movement 
             if (Fwd_A) 
                    then ECC.SetControlContinousFwd(0, false) ; 
                    else ECC.SetControlContinousBkwd(0, false ) ;   
            end
time_in_label : Enable(true ) ; 
time_out_label : Enable (true) ; 
STOP_button : Enable(false ) ;  
START_button : Enable(true) ; 
end
-- if start is pressed then starts once again 
if ( START_button : GetValue() == true )  
    then 
        START_button : Enable(false) ; 
        STOP_button :Enable(true) ; 
        time_in_label : Enable(false) ; 
        time_out_label : Enable(false) ;
        clock_A = os.clock() ; 
         Fwd_A= ECC.GetForward(axisNumber); 
 end

 -- test for the first axis only when Start is pressed 
 if (START_button : GetValue() == true ) 
then 

                if (Fwd_A ) 
                        then  
                            if ( (os.clock()- clock_A) > time_in_A)
                            then 
                            ECC.SetControlContinousBkwd(0, true )   -- to start the backward movement 
                            Fwd_A = false ; 
                            clock_A = os.clock() ; 
                            end
                else 
                            if ((os.clock()- clock_A) > time_out_A) 
                            then 
                            ECC.SetControlContinousFwd(0, true) ; 
                            Fwd_A = true ; 
                            clock_A = os.clock() ; 
                            end 
    
                end 
end 

-- you exit the function only when exit is pressed 
if (EXIT_button : GetValue() == true ) 
then 
            --according to the direction you ned to stop the movement 
             if (Fwd_A) 
                    then ECC.SetControlContinousFwd(0, false) ; 
                    else ECC.SetControlContinousBkwd(0, false ) ;   
            end

break ; 
end 

end     -- End of MAIN LOOP 

return 
end
-----
-- implementation pf end of travel with sensors  
function ECC.EndofTraveltest(axisNumber,START_button, STOP_button, EXIT_button,updated_position_label ) 
  --when the new position is the same as the old position then we need to change the direction 
  -- get the axis number and then test for every axis whether its travel is ended or not 
 -- to set the old positions 
 local old_Position_A  = ECC.GetPosition(axisNumber ) ;   
 LUA_functions.sleep(0.001);       -- sleep function 1ms
 -- to define the directions 
 local Fwd_A = ECC.GetForward(axisNumber) ;
 -- to set the new positions
 local new_Position_A = ECC.GetPosition(axisNumber) ; 

---------------------------------------------------


 while (true ) do  -- the MAIN LOOP 
updated_position_label : SetLabel(tostring(new_Position_A)) ; 
-- if stop is pressed then stop the movement according to the direction 
if (STOP_button : GetValue()  == true ) 
then 
-- i need only to stop the movement according to the direction 
        if (Fwd_A) 
            then 
                   ECC.SetControlContinousFwd(axisNumber, false) ; 
            else   ECC.SetControlContinousBkwd(axisNumber, false )  
            end 
START_button : SetValue (false) ; 
START_button : Enable (true) ; 
STOP_button : SetValue (false) ; 
STOP_button : Enable (false) ; 
end 
-- if start is pressed then enable the stop button 

if (START_button: GetValue() ) 
    then 
    STOP_button : SetValue(false) ; 
    STOP_button : Enable(true) ; 
end 


-- test for the axis when start is pressed 
if (START_button : GetValue() ) 
then 

        if (new_Position_A == old_Position_A) 
        then 
                        if (Fwd_A)
                        then 
                        ECC.SetControlContinousBkwd(axisNumber, true )   -- to start the backward movement 
                        Fwd_A = false ;
                        else 
                        ECC.SetControlContinousFwd(axisNumber, true) ; 
                        Fwd_A = true ; 
                        end 
        end 

end 

old_Position_A = new_Position_A ; 
LUA_functions.sleep(0.001);       -- sleep function 1ms
new_Position_A= ECC.GetPosition(axisNumber) ;
-- if exit is pressed then break the loop 
if (EXIT_button : GetValue() ) 
    then 
    break ; 
end 

end  -- end of the MAIN LOOP 

return  
end 




-------------------------------------------------------------------------
function Position_Show(GUI_frame, axisNumber, Time_button ) 
-- to show the labels , to create the buttons same story in the loop
local position = wx.wxStaticText(GUI_frame, wx.wxID_ANY, 'position of Axis '.. tostring(axisNumber)..'in nm ', wx.wxPoint(50,200), wx.wxSize(100,25), 0, 'position  ')  ; 
local updated_position_label = wx.wxTextCtrl(GUI_frame, wx.wxID_ANY,ECC.getPosition(axisNumber) , wx.wxPoint(80,200), wx.wxSize(100,30) , wx.wxTE_PROCESS_ENTER, wx.wxDefaultValidator, 'updated position'  ) ; 
-- to create the start stop and exit button 
local START_button = wx.wxToggleButton(GUI_frame, wx.wxID_ANY, 'START', wx.wxPoint(80,300), wx.wxSize(40,50),0, wx.wxDefaultValidator, 'Start Button ' ) ;  
local STOP_button  = wx.wxToggleButton(GUI_frame, wx.wxID_ANY, 'STOP', wx.wxPoint(150,300), wx.wxSize(40,50),0, wx.wxDefaultValidator, 'stop button') ; 
STOP_button : Enable(false) ; 
local EXIT_button = wx.wxToggleButton(GUI_frame, wx.wxID_ANY, 'EXIT', wx.wxPoint(200,300) , wx.wxSize(40,50),0, wx.wxDefaultValidator, 'exit Button') ; 

-- MAIN LOOP 
while (true) do 
if ( START_button : GetValue() == true )  
    then 
        START_button :Enable(false) ; 
        STOP_button : SetValue(false) ; 
        STOP_button : Enable(true) ; 
        ECC.EndofTraveltest() ;                -- in der funktion muss als bruchbedingung stop gedruckt sein oder Exit und in den parmetern axisnumber , time in /out labels  
         updated_position_label: Enable(false) ;  
end 
----
if (EXIT_button :GetValue() == true )
        then
         START_button : Destroy() ;       -- delete all the information  : to freeze all the buttons and the labels or to draw a rectangle i will see what i am going to do i don't if it is possible to clear a part of the screen 
         STOP_button : Destroy() ;
         EXIT_button : Destroy() ;
         position : Destroy() ; 
         updated_position_label: Destroy() ; 
        break ; -- to break the loop an exit mode ; 
end 
end -- END OF MAIN LOOP 
Time_button : SetValue(false) ; 
Time_button : Enable(true) ; 
return 
end 
------

function Time_Show(GUI_frame, axisNumber, position_button, amplitude_label, frequency_label, current_amplitude, current_frequency, last_frequency, last_amplitude)
-- to create the labels for time constants : 
local time_in , time_out = wx.wxStaticText(GUI_frame, wx.wxID_ANY, 'time in Axis '.. tostring(axisNumber)..' in seconds', wx.wxPoint(50,200), wx.wxSize(100,25), 0, 'time in constant ') , wx.wxStaticText(GUI_frame, wx.wxID_ANY, 'time out Axis '.. tostring(axisNumber)..' in seconds',wx.wxPoint(50,230), wx.wxSize(100,25),0,'time out constant' ) ; 
-- to create the user editable labels 
local time_in _label = wx.wxTextCtrl(GUI_frame, wx.wxID_ANY, '', wx.wxPoint(80,200), wx.wxSize(100,30) , wx.wxTE_PROCESS_ENTER, wx.wxDefaultValidator, 'time in label'  )
local time_out_label = wx.wxTextCtrl(GUI_frame, wx.wxID_ANY, '', wx.wxPoint(80,240), wx.wxSize(100,30) , wx.wxTE_PROCESS_ENTER, wx.wxDefaultValidator, 'time out label'  )
 -------- 

-- i need also labels for the time to take in that direction 

-- to create the start stop and exit button 
local START_button = wx.wxToggleButton(GUI_frame, wx.wxID_ANY, 'START', wx.wxPoint(80,300), wx.wxSize(40,50),0, wx.wxDefaultValidator, 'Start Button ' ) ;  
local STOP_button  = wx.wxToggleButton(GUI_frame, wx.wxID_ANY, 'STOP', wx.wxPoint(150,300), wx.wxSize(40,50),0, wx.wxDefaultValidator, 'stop button') ; 
STOP_button : SetValue(false) ; 
STOP_button : Enable(false) ; 
local EXIT_button = wx.wxToggleButton(GUI_frame, wx.wxID_ANY, 'EXIT', wx.wxPoint(200,300) , wx.wxSize(40,50),0, wx.wxDefaultValidator, 'exit Button') ; 

-- MAIN LOOP 
while (true) do 
-- if stop is pressed then you can edit the amplitude and frequency values 
if (START_button : GetValue() == false) 
then 
    -- to read the current frequency and amplitude values when they are different from the last ones ; 
                if (current_frequency ~= last_frequency ) -- i need here to test whether the types are equal or not  
                then 
                ECC.SetControlFrequency(axisNumber, current_frequency) ; 
                last_frequency = current_frequency ; 
                end 

                if (current_amplitude ~= last_amplitude ) 
                then 
                ECC.SetControlAmplitude(axisNumber, current_amplitude) 
                last_amplitude = current_amplitude ; 
                end 
current_amplitude, current_frequency = amplitude_label : GetLineText(0) , frequency_label : GetLineText(0) ; 
end 

if ( START_button : GetValue() == true )  
    then 
        START_button : Enable(false) ; 
        STOP_button : SetValue(false) ; 
        STOP_button :Enable(true) ; 
        time_in_label : Enable(false) ; 
        time_out_label : Enable(false) ;
        ECC.EndofTravelWithoutSensors()  -- in der funktion muss als bruchbedingung stop gedruckt sein oder Exit und in den parmetern axisnumber , time in /out labels 
 end 
-----
-- exit means you want to go back to the 'main screen ' ; 
if (EXIT_button :GETValue() == true )
        then
       -- i have three buttons and two static texts and two editable labels              
         START_button : Destroy() ;
         STOP_button : Destroy() ;
         EXIT_button : Destroy() ;
         time_in_label : Destroy() ; 
         time_out_label : Destroy() ; 
         time_in : Destroy() ; 
         time_out : Destroy() ; 
        break ; -- to break the loop an exit mode ; 
end 

-----
end     -- END MAIN LOOP
Position_button : Enable (true ) ; 
return 
end 
-----



function main_axis(GUI_frame ,axisNumber)  
-- to create the static texts for amplitude and frequency with the rectangles etc i can also do that in separate function actually we will check that later
-- to create the toggle buttons for each button 
-- and then if one of the is pressed the other should be disabled if it is posiible and then show the information 
-- if that button is no llonger touched then yoiu need to clear the shown information and wait for the users choice 


------------------------------
-- to create the title texts 
local text_amplitude, text_frequency,text_mode = wx.wxStaticText(GUI_frame, wx.wxID_ANY, 'AMPLITUDE', wx.wxPoint(50,50), wx.wxSize(100,25),0,'amplitude') , wx.wxStaticText(GUI_frame, wx.wxID_ANY, 'Frequency', wx.wxPoint(50,80), wx.wxSize(100,25),0,'frequency'), wx.wxStaticText(GUI_frame,wx.wxID_ANY, 'MODE', wx.wxPoint(50,110), wx.wxSize(100,25),0,'mode')
-- to create the user editable labels 
local amplitude_label = wx.wxTextCtrl(GUI_frame, wx.wxID_ANY, ECC.GetControlAmplitude(axisNumber)..' mV', wx.wxPoint(80,50), wx.wxSize(100,80),wx.wxTE_PROCESS_ENTER, wx.wxDefaultValidator, 'amplitude label ') ; 
local frequency_label = wx.wxTextCtrl(GUI_frame, wx.wxID_ANY, ECC.GetControlFrequency(axisNumber)..' Hz', wx.wxPoint(80,80),wx.wxSize(100,80),wx.wxTE_PROCESS_ENTER, wx.wxDefaultValidator, 'frequency label') ; 

-- to create  local variables  for last amplitude and last frequency . I read always the line and when it diffferrenciates from the last value then I send the appropiate command to the Motion controller 

local last_amplitude, last_frequency = ECC.GetControlAmplitude(axisNumber) , ECC.GetControlFrequency(axisNumber) ; 
-------------------------
local current_amplitude, current_frequency = amplitude_label : GetLineText(0) , frequency_label : GetLineText(0) ; 



-- to create the toggle buttons for the mode 
local Time_button = wx.wxToggleButton(GUI_frame, wx.wxID_ANY, 'TIME', wx.wxPoint(100,110), wx.wxSize(40,20), 0, wx.wxDefaultValidator, 'Time button') ;
local Position_button = wx.wxToggleButton(GUI_frame, wx.wxID_ANY, 'POSITION', wx.wxPoint(150,110), wx.wxSize(40,20),0,wx.wxDefaultValidator, 'Position button') ; 

-- BEGIN MAIN LOOP 
while (true ) do 
--  read the present function if different from last frequency then send the commmand set frequency /// the same for amplitude  : to do that only when stop is pressed in the current mode

if (current_frequency ~= last_frequency ) -- i need here to test whether the types are equal or not  
    then 
        ECC.SetControlFrequency(axisNumber, current_frequency) ; 
        last_frequency = current_frequency ; 
end 

if (current_amplitude ~= last_amplitude ) 
    then 
        ECC.SetControlAmplitude(axisNumber, current_amplitude) 
        last_amplitude = current_amplitude ; 
end 
current_amplitude, current_frequency = amplitude_label : GetLineText(0) , frequency_label : GetLineText(0) ; 
 ------------------------------------------------------------------
-- if one is pressed then disable the other and call the appropriate function 

if (Tiime_button : GetValue() == true ) 
    then 
          Position_button: Enable(false) ;      -- disable position button 
          Time_Show()                                 -- call the Time show function 
end
--------------------------------------------------------------------------------

if (Position_button: GetValue() == true  ) 
    then 
            Position_button : Enable(false) ; -- disable time button 
             Position_Show() ;                     -- call the appropriate function 
end 
-----

end         -- END MAIN LOOP 

GUI_frame: Show(true) ;
return 
end 
------
function main() 
-- to create the frame here , the menu bar the menu objects and to connect the events 

-- to create the frame 
-- let's create the frame : 
local GUI_frame= wx.wxFrame(wx.NULL ,wx.wxID_ANY,'MOTION CONTROLLER GUI',wx.wxPoint(0,0),wx.wxSize(900,900),wx.wxDEFAULT_FRAME_STYLE) ;

-- to create the menu bar : Axis 1 , Axis 2 , Axis 3 
local first_axis_menu = wx.wxMenu() ; -- to create the menu objetct 
first_axis_menu : Append(1,'&Show 1', 'show the first screen') ; 
local second_axis_menu = wx.wxMenu() ; 
second_axis_menu : Append(2,'&Show 2', 'show the second screen') ; 
local third_axis_menu = wx.wxMenu() ; 
third_axis_menu : Append(3,'&Show 3', 'show the third screen') ; 

local menu_bar = wx.wxMenuBar() ; 

menu_bar : Append(first_axis_menu , 'AXIS 1') ;  
menu_bar : Append(second_axis_menu , 'AXIS 2') ;  
menu_bar : Append(third_axis_menu , 'AXIS 3') ;  
 -- attach the menu bar into the frame
 GUI_frame:SetMenuBar(menu_bar) ;
------- 
-- to connect the events 
while (true)  do -- MAIN LOOP 
GUI_frame:Connect(1, wx.wxEVT_COMMAND_MENU_SELECTED, function (event) main_axis(GUI_frame ,0)  end ) ; -- do i need to erase the information of each screen ???????????????????????
GUI_frame:Connect(2, wx.wxEVT_COMMAND_MENU_SELECTED, function (event) main_axis(GUI_frame ,1)  end ) ; 
GUI_frame:Connect(3, wx.wxEVT_COMMAND_MENU_SELECTED, function (event) main_axis(GUI_frame ,2)  end ) ; 

end -- END MAIN LOOP 
return 
end 
-----------















main() 
wx.wxGetApp():MainLoop()
 