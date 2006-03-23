indexing
	description:
		"Eiffel Vision textable. Mswindows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_TEXTABLE_IMP

inherit
	EV_TEXTABLE_I

feature -- Access

	text: STRING_32 is
			-- Text displayed in `Current'.
		do
			Result := wel_text
		end

feature -- Element change

	set_text (a_text: STRING_GENERAL) is
			-- Assign `a_text' to `text'.
		do
			wel_set_text (a_text)
		end

feature {NONE} -- Implementation

	wel_set_text (a_text: STRING_GENERAL) is
			-- Set `a_text' in WEL object.
		deferred
		end

	wel_text: STRING_32 is
			-- Text from WEL object.
		deferred
		ensure
			not_void: Result /= Void
		end

	text_length: INTEGER is
			-- Length of text
		deferred
		ensure
			positive_length: Result >= 0
		end

	line_count: INTEGER is
			-- Number of lines required by `text'.
		do
			Result := text.occurrences ('%N') + 1
		ensure
			non_negative: Result >= 0
		end

feature -- Obsolete

	set_default_minimum_size is
			-- Set to the size of the text.
		obsolete
			"Implement using {EV_FONT_IMP}.text_metrics."
		do
			check
				inapplicable: False
			end
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




end -- class EV_TEXTABLE_IMP

