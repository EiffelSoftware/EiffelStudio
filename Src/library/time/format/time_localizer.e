indexing
	description: "";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	TIME_LOCALIZER

inherit
	LOCALIZER

creation

invariant

		-- Booleans for DATE
	has_day_of_the_month_shown: has_boolean_entry ("day_of_the_month_shown");
	has_day_of_the_week_shown: has_boolean_entry ("day_of_the_week_shown");
	has_current_month_shown: has_boolean_entry ("current_month_shown");
	has_current_year_shown: has_boolean_entry ("current_year_shown");
	has_is_day_before_month: has_boolean_entry ("is_day_before_month");
	has_is_year_first: has_boolean_entry ("is_year_first");
	has_is_year_truncated: has_boolean_entry ("is_year_truncated");
	has_is_month_as_digit: has_boolean_entry ("is_month_as_digit");
	has_is_month_completed: has_boolean_entry ("is_month_completed");
	has_is_day_completed: has_boolean_entry ("is_day_completed");

		-- Strings for DATE	
	has_separator_month_day: has_string_entry ("separator_month_day");
	has_separator_year: has_string_entry ("separator_year");
	has_separator_day: has_string_entry ("separator_day");

		-- Arrays of strings for DATE
	has_months: has_string_array_entry ("months");
	has_week_days: has_string_array_entry ("week_days")

		-- Booleans for TIME
	has_is_hour_shown: has_boolean_entry ("is_hour_shown");
	has_is_minute_shown: has_boolean_entry ("is_minute_shown");
	has_is_second_shown: has_boolean_entry ("is_second_shown");
	has_is_12_hour_time: has_boolean_entry ("is_12_hour_time");
	has_is_hour_completed: has_boolean_entry ("is_hour_completed");
	has_is_minute_completed: has_boolean_entry ("is_minute_completed");
	has_is_second_completed: has_boolean_entry ("is_second_completed");

		-- Strings for TIME
	has_string_after_hour: has_string_entry ("string_after_hour");
	has_separator_hour_minute: has_string_entry ("separator_hour_minute");
	has_string_after_minute: has_string_entry ("string_after_minute");
	has_separator_minute_second: has_string_entry ("separator_minute_second");
	has_string_after_second: has_string_entry ("string_after_second");
	has_am_string: has_string_entry ("am_string");
	has_pm_string: has_string_entry ("pm_string");

		-- Integers for TIME
	has_fraction_of_second: has_integer_entry ("fraction_of_second")	
	
	
end -- class DATE_LOCALIZER


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
