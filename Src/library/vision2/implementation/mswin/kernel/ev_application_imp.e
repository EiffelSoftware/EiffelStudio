indexing

	description: 
		"EiffelVision application, mswindows implementation."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_APPLICATION_IMP
	
inherit
 	WEL_APPLICATION
 		rename
 			make as wel_make
		redefine
			init_application
 		end

	EV_APPLICATION_I

creation
	make

feature {NONE} -- Implemenation dlls

	common_control_dll: WEL_COMMON_CONTROLS_DLL
			-- Needed for the tab controls

feature {NONE} -- Implementation

	make (interf: EV_APPLICATION) is
		do
			interface := interf
			wel_make
		end

	init_application is
			-- Load the dll needed sometimes
		do
			!! common_control_dll.make
		end

	iterate is
            -- Loop the application.
        do
        end

	exit is
			-- Exit
		do
			check
				not_yet_implemented: False
			end
		end

	interface: EV_APPLICATION

feature -- Implementation
	
	main_window: WEL_FRAME_WINDOW is
		local
			window_imp: EV_WINDOW_IMP
		once
			window_imp ?= interface.main_window.implementation
			check
				window_imp /= Void
			end
			Result := window_imp
		end

end -- class EV_APPLICATION_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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
