indexing
	description: "Formatter for dates"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	FORMAT_DATE

inherit
	FORMAT [DATE]

creation 
	make

feature -- Initialization 

	make (l: LOCALIZER; w: INTEGER) is
			-- Set `localizer to `l' and `width' to `w'.
		require
			local_exist: l /= Void;
			w_large_enough: w >= 0
		do
			blank_fill;
			width := w;
			left_justify;
			localizer := l
		ensure
			blank_fill: fill_character = ' ';
			width_set: width = w;
			localizer = l
		end;

feature -- Access

	localizer: LOCALIZER;
			-- Provider of boolean, string and integer values needed to format a date 

feature -- Status report

	day_of_the_month_shown: BOOLEAN is
			-- Is the day of the month shown? (1, 2,.. 31)
		do
			Result := localizer.boolean_value ("day_of_the_month_shown", True)
		end;

	day_of_the_week_shown: BOOLEAN is
			-- Is the day of the week shown? (sunday, monday...)
		do
			Result := localizer.boolean_value ("day_of_the_week_shown", False)
		end;

	current_month_shown: BOOLEAN is
			-- Is the current month shown?
		do
			Result := localizer.boolean_value ("current_month_shown", True)
		end;

	current_year_shown: BOOLEAN is
			-- Is the current year shown?
		do
			Result := localizer.boolean_value ("current_year_shown", True)
		end;

	is_day_before_month: BOOLEAN is
			-- Is day before the month?
		do
			Result := localizer.boolean_value ("is_day_before_month", False)
		end;

	is_year_first: BOOLEAN is
			-- Is year before day and month?
		do
			Result := localizer.boolean_value ("is_year_first", False)
		end;

	is_year_truncated: BOOLEAN is
			-- Are the two first digits of the year removed?
		do
			Result := localizer.boolean_value ("is_year_truncated", False)
		end;

	is_month_as_digit: BOOLEAN is
			-- Are month writen as digit? or else as a string?
		do
			Result := localizer.boolean_value ("is_month_as_digit", True)
		end;

	is_day_completed: BOOLEAN is
			-- If day are below 10, fill with '0' before?
		do
			Result := localizer.boolean_value ("is_day_completed", True)
		end;

	is_month_completed: BOOLEAN is
			-- If month are below 10, fill with '0' before?
		do
			Result := localizer.boolean_value ("is_month_completed", True)
		end;

	separator_year: STRING is
			-- Separator before year if in last position, after it if in first position
		do
			Result := localizer.string_value ("separator_year", " ")
		end;

	separator_month_day: STRING is
			-- Separator between day and month
		do
			Result := localizer.string_value ("separator_month_day", " ")
		end;

	separator_day: STRING is
			-- Separator after day of the week string, if displayed 
		do
			Result := localizer.string_value ("separator_day", " ")
		end;

	months: ARRAY [STRING] is
			-- Month names
		do
			Result := localizer.string_array_value ("months", <<"","","","","","","","","","","","">>)
		end;

	week_days: ARRAY [STRING] is
			-- Week day names
		do
			Result := localizer.string_array_value ("week_days", <<"","","","","","","">>)
		end;

feature -- Element change

	set_localizer (l: LOCALIZER) is
		require
			l_exists: l /= Void
		do
			localizer := l
		ensure
			localizer_set: localizer = l
		end; 

feature -- Conversion

	formatted (date: DATE): STRING is
			-- Format `date' 
		local
			formatted_day: STRING;
			formatted_month: STRING;
			formatted_year: STRING
		do
			Result := "";
			if current_month_shown then
				if is_month_as_digit then
					formatted_month := date.month.out;
					if (is_month_completed and then date.month < 10) then
						formatted_month.prepend ("0")
					end
				else
					formatted_month := months @ date.month
				end;
				if day_of_the_month_shown then
					formatted_day := date.day.out;
					if (is_day_completed and then date.day < 10) then
						formatted_day.prepend ("0")
					end;
					Result := clone (separator_month_day);
					if is_day_before_month then
						Result.append (formatted_month);
						Result.prepend (formatted_day)
					else
						Result.append (formatted_day);
						Result.prepend (formatted_month)
					end;
					if day_of_the_week_shown then
						Result.prepend (separator_day);
						Result.prepend (week_days @ date.day_of_the_week)
					end
				else
					Result.append (formatted_month)
				end;
			end;
			if current_year_shown then
				formatted_year := date.year.out;
				if (date.year.out.count = 4) and then is_year_truncated then
					formatted_year.remove (1);
					formatted_year.remove (1)
				end;
				if not is_year_first then
					Result.append (separator_year);
					Result.append (formatted_year)
				else
					Result.prepend (separator_year);
					Result.prepend (formatted_year)
				end
			end
		end;


invariant
	wide_enough: width >= 1;
	no_justification <= justification and justification <= right_justification;

end -- class FORMAT_DATE


--|---------------------------------------------------------------- 
--| EiffelTime: library of reusable components for ISE Eiffel 3. 
--| Copyright (C) 1995, Interactive Software Engineering Inc. 
--| All rights reserved. Duplication and distribution prohibited. 
--| 
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA 
--| Telephone 805-685-1006 
--| Fax 805-685-6869 
--| Electronic mail <info@eiffel.com> 
--| Customer support e-mail <support@eiffel.com> 
--|---------------------------------------------------------------- 

