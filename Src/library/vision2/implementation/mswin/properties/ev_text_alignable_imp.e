indexing
	description: "Eiffel Vision2 text alignable. Ms Windows implementation."
	author: ""
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
			text_alignment := feature {EV_TEXT_ALIGNABLE_CONSTANTS}.Ev_text_alignment_center
		end

	align_text_right is
			-- Display `text' right aligned.
		do
			text_alignment := feature {EV_TEXT_ALIGNABLE_CONSTANTS}.Ev_text_alignment_right
		end
        
	align_text_left is
			-- Display `text' left aligned.
		do
			text_alignment := feature {EV_TEXT_ALIGNABLE_CONSTANTS}.Ev_text_alignment_left
		end

end -- class EV_TEXT_ALIGNABLE_IMP
