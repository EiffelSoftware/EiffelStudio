indexing
	description: 
		"Eiffel Vision frame. Implementation interface."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_FRAME_I

inherit
	EV_CELL_I
		redefine
			interface
		end
	
	EV_TEXT_ALIGNABLE_I
		redefine
			interface,
			default_alignment
		end
	
	EV_FONTABLE_I
		redefine
			interface
		end

	EV_FRAME_CONSTANTS

feature -- Access

	style: INTEGER is
			-- Visual appearance. See: EV_FRAME_CONSTANTS.
		deferred
		end

feature -- Element change

	set_style (a_style: INTEGER) is
			-- Assign `a_style' to `style'.
		require
			a_style_valid: valid_frame_border (a_style)
		deferred
		ensure
			style_assigned: style = a_style
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_FRAME
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'
			
feature {NONE} -- Implementation
			
	default_alignment: INTEGER is
			-- Default alignment used during
			-- creation of real implementation
		do
			Result := {EV_TEXT_ALIGNMENT_CONSTANTS}.Ev_text_alignment_left
		end

end -- class EV_FRAME_I

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

