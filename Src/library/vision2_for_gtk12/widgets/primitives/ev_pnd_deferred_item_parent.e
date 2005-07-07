indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_PND_DEFERRED_ITEM_PARENT

feature {EV_ANY_I} -- Implementation

	row_from_y_coord (a_y: INTEGER): EV_PND_DEFERRED_ITEM is
			-- Retrieve the Current row from `a_y' coordinate
		deferred
		end

feature {EV_GTK_DEPENDENT_INTERMEDIARY_ROUTINES} -- Implementation

	start_transport_filter (
			a_type: INTEGER
			a_x, a_y, a_button: INTEGER;
			a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
			a_screen_x, a_screen_y: INTEGER)
		is
			-- Initialize a pick and drop transport.
		deferred
		end

feature {EV_GTK_DEPENDENT_INTERMEDIARY_ROUTINES} -- Event handling

	call_selection_action_sequences is
			-- Call appropriate selection action sequences 
		deferred
		end

end -- class EV_PND_DEFERRED_ITEM_PARENT

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

