indexing	
	description: "EiffelVision base item, mswindows implementation"
	status: "See notice at end of class"
	id: "$$"
	date: "$Date$"
	revision: "$Revision$"

deferred class 
	EV_ITEM_IMP

inherit
	EV_ITEM_I

	EV_EVENT_HANDLER_IMP
		export
			{EV_ITEM_HOLDER_IMP} execute_command
		end

	EV_ITEM_EVENTS_CONSTANTS_IMP

feature -- Access

	parent_imp: EV_ITEM_HOLDER_IMP is
			-- The parent of the Current widget
			-- Can be void.
		deferred
		end

	parent_widget: EV_WIDGET is
			-- Parent widget of the current item
		do
			Result := parent_imp.current_widget
		end

	wel_window: WEL_WINDOW is
			-- Window used to create the related pixmap. It has
			-- to be a wel_control.
			-- It correspond to the implementation of the
			-- parent_widget.
		do
			Result ?= parent_widget.implementation
		end

end -- class EV_ITEM_IMP

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
