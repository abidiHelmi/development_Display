- Goal of the programm : to show  the string
main() 
wx.wxGetApp: MainLoop() ;







function main()
-- to create a wxwindow 
-- need to create its size 
local taille_window , position_window = wx.wxSize(150,150) , wx.wxPoint(20,20) ; 
local parent_window = wx.wxWindow(nil,1,position_window,taille_window,0,'helmi_first_window') ; 
-- to create the frame  
local mon_frame= wx.wxFrame(parent_window,1,wx.wxPoint(25,25),wx.wxSize(125,125),0,'my first frame') ;  
-- i will create first of all a wxsize and a wxpoint object : 
-- to create the wxsize 
local taille = wx.wxSize(50,35) ; 
-- to create the position object 
local position = wx.wxPoint(50,50) ; 
-- to create the static text object 
local text = wx.wxStaticText(parent_window,1,'Frequency',position,taille,0,'static') ; 


mon_frame: Show(true) ; 
return 
end 