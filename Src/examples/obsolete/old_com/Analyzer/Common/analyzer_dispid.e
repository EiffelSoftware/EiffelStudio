indexing
	description: "Analyzer dipatch identifiers"
	legal: "See notice at end of class.";
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
	
	Dispid_hide: INTEGER is 8;
	
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


end -- class ANALYZER_DISPID

