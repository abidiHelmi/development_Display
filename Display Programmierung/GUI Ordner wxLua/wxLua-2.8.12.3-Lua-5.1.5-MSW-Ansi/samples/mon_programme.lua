- Goal of the programm : to show  the string
package.cpath = package.cpath..";./?.dll;./?.so;../lib/?.so;../lib/vc_dll/?.dll;../lib/bcc_dll/?.dll;../lib/mingw_dll/?.dll;"
require("wx")
main() 
wx.wxGetApp: MainLoop() ;







function main()
-- to create a wxwindow 
-- need to create its size 
--local taille_window , position_window = wx.wxSize(150,150) , wx.wxPoint(20,20) ; 
--local parent_window = wx.wxWindow(wx.NULL,wx.wxID_ANY,'helmi_first_window',position_window,taille_window,wx.wxBORDER_SIMPLE) ; 
-- to create the frame  
local mon_frame= wx.wxFrame(wx.NULL ,wx.wxID_ANY,'my first frame',wx.wxPoint(25,25),wx.wxSize(125,125),wx.wxDEFAULT_FRAME_STYLE) ;  
-- i will create first of all a wxsize and a wxpoint object : 
-- to create the wxsize 
local taille = wx.wxSize(50,35) ; 
-- to create the position object 
local position = wx.wxPoint(50,50) ; 
-- to create the static text object 
local text = wx.wxStaticText(mon_frame,wx.wxID_ANY,'Frequency',position,taille,0,'static') ; 
------------------------------------------------------------------------------


mon_frame: Show(true) ; 
return 
end 