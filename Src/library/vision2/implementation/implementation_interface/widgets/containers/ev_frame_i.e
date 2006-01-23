indexing
	description: 
		"Eiffel Vision frame. Implementation interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_FRAME_I

