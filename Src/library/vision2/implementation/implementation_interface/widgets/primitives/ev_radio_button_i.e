indexing
	description: "Eiffel Vision radio button. Implementation interface."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_RADIO_BUTTON_I

inherit
	EV_BUTTON_I
		redefine
			interface,
			default_alignment
		end

	EV_RADIO_PEER_I
		redefine
			interface
		end

	EV_SELECTABLE_I
		redefine
			interface
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_RADIO_BUTTON
	
feature {NONE} -- Implementation

	default_alignment: INTEGER is
			-- Default alignment used during
			-- creation of real implementation
		do
			Result := {EV_TEXT_ALIGNMENT_CONSTANTS}.Ev_text_alignment_left
		end

end -- class EV_RADIO_BUTTON_I

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

