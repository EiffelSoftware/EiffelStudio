indexing
	description: "Eiffel Vision2 text alignable.%
		%Implementation interface."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_TEXT_ALIGNABLE_I

inherit
	EV_TEXTABLE_I
	
feature -- Access

	text_alignment: INTEGER is
			-- Current text positioning.
		deferred
		end

feature -- Status setting

	align_text_center is
			-- Display `text' centered.
		deferred
		end

	align_text_left is
			-- Display `text' left aligned.
		deferred
		end

	align_text_right is
			-- Display `text' right aligned.
		deferred
		end
		
feature {NONE} -- Implementation

	default_alignment: INTEGER is
			-- Default alignment used during
			-- creation of real implementation
			-- Center alignment by default as this is the most
			-- common. Descendents need to redefine this if their
			-- default alignment is different.
		do
			Result := feature {EV_TEXT_ALIGNMENT_CONSTANTS}.Ev_text_alignment_center 
		end
		
end -- class EV_TEXT_ALIGNABLE_I
