indexing
	description: "SystemMetric (SM) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_SM_CONSTANTS

feature -- Access

	Sm_cxscreen: INTEGER is 0

	Sm_cyscreen: INTEGER is 1

	Sm_cxvscroll: INTEGER is 2

	Sm_cyhscroll: INTEGER is 3

	Sm_cycaption: INTEGER is 4

	Sm_cxborder: INTEGER is 5

	Sm_cyborder: INTEGER is 6

	Sm_cxdlgframe: INTEGER is 7

	Sm_cydlgframe: INTEGER is 8

	Sm_cyvthumb: INTEGER is 9

	Sm_cxhthumb: INTEGER is 10

	Sm_cxicon: INTEGER is 11

	Sm_cyicon: INTEGER is 12

	Sm_cxcursor: INTEGER is 13

	Sm_cycursor: INTEGER is 14

	Sm_cymenu: INTEGER is 15

	Sm_cxfullscreen: INTEGER is 16

	Sm_cyfullscreen: INTEGER is 17

	Sm_cxmaximized: INTEGER is 61

	Sm_cymaximized: INTEGER is 62

	Sm_cykanjiwindow: INTEGER is 18

	Sm_mousepresent: INTEGER is 19

	Sm_cyvscroll: INTEGER is 20

	Sm_cxhscroll: INTEGER is 21

	Sm_debug: INTEGER is 22

	Sm_swapbutton: INTEGER is 23

	Sm_reserved1: INTEGER is 24

	Sm_reserved2: INTEGER is 25

	Sm_reserved3: INTEGER is 26

	Sm_reserved4: INTEGER is 27

	Sm_cxmin: INTEGER is 28

	Sm_cymin: INTEGER is 29

	Sm_cxsize: INTEGER is 30

	Sm_cysize: INTEGER is 31

	Sm_cxframe: INTEGER is 32

	Sm_cyframe: INTEGER is 33

	Sm_cxmintrack: INTEGER is 34

	Sm_cymintrack: INTEGER is 35

	Sm_cxdoubleclk: INTEGER is 36

	Sm_cydoubleclk: INTEGER is 37

	Sm_cxiconspacing: INTEGER is 38

	Sm_cyiconspacing: INTEGER is 39

	Sm_menudropalignment: INTEGER is 40

	Sm_penwindows: INTEGER is 41

	Sm_dbcsenabled: INTEGER is 42

	Sm_cmetrics: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"SM_CMETRICS"
		end

end -- class WEL_SM_CONSTANTS

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

