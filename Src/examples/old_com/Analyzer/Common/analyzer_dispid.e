indexing
	description: "Analyzer dipatch identifiers";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	ANALYZER_DISPID

feature -- Access

	Dispid_text: INTEGER is 1

	Dispid_word_count: INTEGER is 2
	
	Dispid_line_count: INTEGER is 3
		
	Dispid_sentence_count: INTEGER is 4
	
	Dispid_occurrences: INTEGER is 5
		
	Dispid_terminate: INTEGER is 6
	
	Dispid_show: INTEGER is 7
	
	Dispid_hide: INTEGER is 8
	
end -- class ANALYZER_DISPID

--|-------------------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license.
--| Contact ISE for any other use.
--| Based on WINE library, copyright (C) Object Tools, 1996-1997.
--| Modifications and extensions: copyright (C) ISE, 1997. 
--|
--| Interactive Software Engineering Inc.
--| 270 Storke Road, ISE Building, second floor, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------

