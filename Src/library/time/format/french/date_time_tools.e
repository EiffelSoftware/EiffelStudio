indexing
	description: "French settings";
	date: "$Date$";
	revision: "$Revision$"

class 
	DATE_TIME_TOOLS	

inherit
	DATE_TIME_LANGUAGE_CONSTANTS
feature 

	name: STRING is "French"

	days_text: ARRAY [STRING] is
		once
			Result := <<
				"DIM",
				"LUN",
				"MAR",
				"MER",
				"JEU",
				"VEN",
				"SAM"
				
			>>;
			Result.compare_objects
		end

	months_text: ARRAY [STRING] is
		once
			Result := <<
				"JAN",
				"FEV",
				"MAR",
				"AVR",
				"MAI",
				"JUN",
				"JUL",
				"AOU",
				"SEP",
				"OCT",
				"NOV",
				"DEC"
			>>;
			Result.compare_objects
		end

	long_days_text: ARRAY [STRING] is
		once
			Result := <<
				"DIMANCHE",
				"LUNDI",
				"MARDI",
				"MERCREDI",
				"JEUDI",
				"VENDREDI",
				"SAMEDI"
				>>;
			Result.compare_objects
		end

	long_months_text: ARRAY [STRING] is
		once
			Result := <<
				"JANVIER",
				"FEVRIER",
				"MARS",
				"AVRIL",
				"MAI",
				"JUIN",
				"JUILLET",
				"AOUT",
				"SEPTEMBRE",
				"OCTOBRE",
				"NOVEMBRE",
				"DECEMBRE"
			>>;
			Result.compare_objects
		end
	
	default_format_string: STRING is "[0]dd/[0]mm/yyyy [0]hh:[0]mi:[0]ss.ff3"

	date_default_format_string: STRING is "[0]dd/[0]mm/yyyy"

	time_default_format_string: STRING is "[0]hh:[0]mi:[0]ss.ff3"

end -- class DATE_TIME_TOOLS 


--|----------------------------------------------------------------
--| EiffelTime: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

