note
	description: "Eiffel Vision2 text alignable.%
		%Implementation interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_TEXT_ALIGNABLE_I

inherit
	EV_TEXTABLE_I
	
feature -- Access

	text_alignment: INTEGER
			-- Current text positioning.
		deferred
		end

feature -- Status setting

	align_text_center
			-- Display `text' centered.
		deferred
		end

	align_text_left
			-- Display `text' left aligned.
		deferred
		end

	align_text_right
			-- Display `text' right aligned.
		deferred
		end
		
feature {NONE} -- Implementation

	default_alignment: INTEGER
			-- Default alignment used during
			-- creation of real implementation
			-- Center alignment by default as this is the most
			-- common. Descendents need to redefine this if their
			-- default alignment is different.
		do
			Result := {EV_TEXT_ALIGNMENT_CONSTANTS}.Ev_text_alignment_center 
		end
		
note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_TEXT_ALIGNABLE_I

