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
 		end

	EV_APPLICATION_I

creation
	make

feature {NONE} -- Implementation


	make (interf: EV_APPLICATION) is

		do
			interface := interf
			wel_make
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
			Result := window_imp.wel_window
		end

 end -- class EV_APPLICATION_IMP
