indexing
	description: 
		"Eiffel Vision textable. Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_TEXTABLE_IMP
	
inherit
	EV_TEXTABLE_I
	
feature -- Access

	text: STRING is
			-- Text displayed in `Current'.
		do
			Result := wel_text
		end

feature -- Element change

	set_text (a_text: STRING) is
			-- Assign `a_text' to `text'.
		do
			wel_set_text (a_text)
		end

feature {NONE} -- Implementation

	wel_set_text (a_text: STRING) is
			-- Set `a_text' in WEL object.
		deferred
		end

	wel_text: STRING is
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

end -- class EV_TEXTABLE_IMP

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

