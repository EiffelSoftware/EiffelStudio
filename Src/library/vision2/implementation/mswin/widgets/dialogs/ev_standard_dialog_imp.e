indexing
	description: "EiffelVision standard dialog, Mswindows implementation."
	note: "Equivalent of the WEL_STANDARD_DIALOG class."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_STANDARD_DIALOG_IMP

inherit
	EV_STANDARD_DIALOG_I

	EV_EVENT_HANDLER_IMP

	EV_DIALOG_EVENTS_CONSTANTS_IMP

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create a window with a parent.
		do
			parent_imp ?= par.implementation
			wel_make
		ensure then
			valid_parent: parent_imp /= Void and then parent_imp.exists
		end

feature -- Status report

	destroyed: BOOLEAN is
			-- Is Current object destroyed?  
		do
			Result := not exists
		end

feature -- Status setting

	destroy is
			-- Destroy actual object.
		do
			dispose
		end

	show is
			-- Show the window.
			-- As the window is modal, nothing can be done
			-- until the user closed the window.
		local
			win: WEL_COMPOSITE_WINDOW
		do
			win ?= parent_imp
			activate (win)
			dispatch_events
		end

feature -- Element change

	set_parent (par: EV_CONTAINER) is
			-- Make `par' the new parent of the dialog.
		do
			parent_imp ?= par.implementation
		end

feature {NONE} -- Implementation

	parent_imp: EV_CONTAINER_IMP
		-- Implementation of the current parent of the dialog.

feature {NONE} -- Deferred features

	wel_make is
		deferred
		end

	exists: BOOLEAN is
		deferred
		end

	dispose is
		deferred
		end

	activate (a_parent: WEL_COMPOSITE_WINDOW) is
		deferred
		end

	selected: BOOLEAN is
		deferred
		end

	dispatch_events is
		deferred
		end

end -- class EV_STANDARD_DIALOG_IMP

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
