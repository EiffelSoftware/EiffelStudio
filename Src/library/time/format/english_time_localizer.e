indexing
	description: "";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class

	ENGLISH_TIME_LOCALIZER

inherit

	TIME_LOCALIZER
		rename
			make as localizer_make
		end

creation

	make

feature -- Initialization

	make is
		do
			localizer_make;

				-- Booleans for DATE
			record_boolean_value (True, "day_of_the_month_shown");
			record_boolean_value (True, "day_of_the_week_shown");
			record_boolean_value (True, "current_month_shown");
			record_boolean_value (True, "current_year_shown");
			record_boolean_value (False, "is_day_before_month");
			record_boolean_value (False, "is_year_first");
			record_boolean_value (False, "is_year_truncated");
			record_boolean_value (False, "is_month_as_digit");
			record_boolean_value (True, "is_month_completed");
			record_boolean_value (True, "is_day_completed");

				-- Strings for DATE			
			record_string_value (" ", "separator_month_day");
			record_string_value (" ", "separator_year");
			record_string_value (", ", "separator_day");

				-- Arrays of strings for DATE
			record_string_array_value (<<"January", "February",
				"March", "April", "May", "June",
				"July", "August", "September",
				"October", "November", "December">>,
				"months");
			record_string_array_value (<<"Sunday", "Monday",
				"Tuesday", "Wednesday", "Thursday",
				"Friday", "Saturday">>,
				"week_days");

				-- Booleans for TIME
			record_boolean_value (True, "is_hour_shown");
			record_boolean_value (True, "is_minute_shown");
			record_boolean_value (True, "is_second_shown");
			record_boolean_value (True, "is_12_hour_time");
			record_boolean_value (False, "is_hour_completed");
			record_boolean_value (True, "is_minute_completed");
			record_boolean_value (True, "is_second_completed");

				-- Strings for TIME
			record_string_value ("", "string_after_hour");
			record_string_value (":", "separator_hour_minute");
			record_string_value ("", "string_after_minute");
			record_string_value (":", "separator_minute_second");
			record_string_value ("", "string_after_second");
			record_string_value (" am", "am_string");
			record_string_value (" pm", "pm_string");

				-- Integers for TIME
			record_integer_value (0, "fraction_of_second");

		end;

end -- class ENGLISH_DATE_LOCALIZER


--|----------------------------------------------------------------
--| EiffelTime: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------


