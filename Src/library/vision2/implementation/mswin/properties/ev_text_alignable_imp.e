indexing
	description: "Eiffel Vision2 text alignable. Ms Windows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_TEXT_ALIGNABLE_IMP
	
inherit
	
	EV_INTERNALLY_PROCESSED_TEXTABLE_IMP

feature

	alignment: INTEGER is
			-- Alignment of `text' on `Current'.
		do
			Result := text_alignment
		end

	text_alignment: INTEGER
			-- Current text alignment. Possible value are
			--	* Text_alignment_left
			--	* Text_alignment_right
			--	* Text_alignment_center
			
	align_text_center is
			-- Display `text' centered.
		do
			text_alignment := {EV_TEXT_ALIGNMENT_CONSTANTS}.Ev_text_alignment_center
		end

	align_text_right is
			-- Display `text' right aligned.
		do
			text_alignment := {EV_TEXT_ALIGNMENT_CONSTANTS}.Ev_text_alignment_right
		end
        
	align_text_left is
			-- Display `text' left aligned.
		do
			text_alignment := {EV_TEXT_ALIGNMENT_CONSTANTS}.Ev_text_alignment_left
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




end -- class EV_TEXT_ALIGNABLE_IMP

