indexing
	status: "See notice at end of class"

deferred class
	EV_PND_DEFERRED_ITEM
	
inherit
	EV_ABSTRACT_PICK_AND_DROPABLE
		undefine
			default_pixmaps
		end

feature

	pointer_over_widget (a_gdk_window: POINTER; a_x, a_y: INTEGER): BOOLEAN is
		deferred
		end
		
	parent_widget_is_displayed: BOOLEAN is
		deferred
		end
		
	create_drop_actions: EV_PND_ACTION_SEQUENCE is
		do
			create Result
			interface.init_drop_actions (Result)
		end
		
	interface: EV_PICK_AND_DROPABLE is
		deferred
		end

end

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

