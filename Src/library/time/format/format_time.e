indexing
	description: "Formatter for time"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	FORMAT_TIME

inherit
	FORMAT [TIME]

creation 
	make

feature -- Initialization

	make (l: LOCALIZER; w: INTEGER) is
			-- Set default values to parameters.
		require
			localizer_exists: l /= Void;
			w_large_enough: w >= 1
		do
			blank_fill;
			width := w;
			right_justify;
			localizer := l
		ensure
			blank_fill: fill_character = ' ';
			width_set: width = w
			localizer_set: localizer = l;
		end;

feature -- Access

	localizer: LOCALIZER;
			-- Provider of values needed to format time

feature -- Status report 

	is_hour_shown: BOOLEAN is
			-- Does time is formatted with hour?
		do
			Result := localizer.boolean_value ("is_hour_shown", True)
		end;

	is_minute_shown: BOOLEAN is
			-- Does time is formatted with minute?
		do
			Result := localizer.boolean_value ("is_minute_shown", True)
		end;

	is_second_shown: BOOLEAN is
			-- Does time is formatted with second?
		do
			Result := localizer.boolean_value ("is_second_shown", True)
		end;

	is_12_hour_time: BOOLEAN is
			-- Does time work modulo 12?
		do
			Result := localizer.boolean_value ("is_12_hour_time", True)
		end;

	is_hour_completed: BOOLEAN is
			-- If hour are below 10, fill with '0' before?
		do
			Result := localizer.boolean_value ("is_hour_completed", True)
		end;

	is_minute_completed: BOOLEAN is
			-- If minute are below 10, fill with '0' before?
		do
			Result := localizer.boolean_value ("is_minute_completed", True)
		end;

	is_second_completed: BOOLEAN is
			-- If second are below 10, fill with '0' before?
		do
			Result := localizer.boolean_value ("is_second_completed", True);
		end;

	string_after_hour: STRING is
			-- String after hour, if displayed
		do
			Result := localizer.string_value ("string_after_hour", "")
		end;

	separator_hour_minute: STRING is
			-- Separator between hour and minute 
		do
			Result := localizer.string_value ("separator_hour_minute", ":")
		ensure
			result_not_void: Result /= Void
		end;

	string_after_minute: STRING is
			-- String after minute, if displayed
		do
			Result := localizer.string_value ("string_after_minute", "")
		ensure
			result_not_void: Result /= Void
		end;

	separator_minute_second: STRING is
			-- Separator between minute and second 
		do
			Result := localizer.string_value ("separator_minute_second", ":")
		ensure
			result_not_void: Result /= Void
		end;

	string_after_second: STRING is
			-- String after second, if displayed
		do
			Result := localizer.string_value ("string_after_second", "")
		ensure
			result_not_void: Result /= Void
		end;

	am_string: STRING is
			-- String standing for "am" 
		do
			Result := localizer.string_value ("am_string", " am")
		ensure
			result_not_void: Result /= Void
		end;

	pm_string: STRING is
			-- String standing for "pm" 
		do
			Result := localizer.string_value ("pm_string", " pm ")
		ensure
			result_not_void: Result /= Void
		end;

	fraction_of_second: INTEGER is
			-- Number of decimals displayed after second
		do
			Result := localizer.integer_value ("fraction_of_second", 0)
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

	formatted (t: TIME): STRING is
			-- Format `t'
		local
			 format: FORMAT_DOUBLE 
		do
			Result := "";
			if is_hour_shown then
				if (is_12_hour_time and then t.hour > 12) then
					Result := (t.hour \\ 12).out;
					if (t.hour \\ 12 < 10 and then is_hour_completed) then
						Result.prepend ("0")
					end
				else
					Result := clone (t.hour.out);
					if (t.hour < 10 and then is_hour_completed) then
						Result.prepend ("0")
					end
				end;
				Result.append (string_after_hour)
			end;
			if is_minute_shown then
				if is_hour_shown then
					Result.append (separator_hour_minute);
				end;
				if (t.minute < 10) and then (is_minute_completed) then
					Result.extend ('0')
				end;
				Result.append (t.minute.out);
				Result.append (string_after_minute);
				if is_second_shown then
					Result.append (separator_minute_second);
					if (t.second < 10 and then is_second_completed) then
						Result.extend ('0')
					end;
					if fraction_of_second <= 0 then
						Result.append (t.second.out);
					else
						!! format.make (fraction_of_second + 1, fraction_of_second);
						Result.append (format.formatted (t.fine_second))
					end;
					Result.append (string_after_second)
				end
			end;
			if is_hour_shown and then is_12_hour_time then
				if t.hour // 13 = 0 then
					Result.append (am_string)
				else
					Result.append (pm_string)
				end
			end
		end;

invariant
	wide_enough: width >= 1;
	justification_set: no_justification <= justification and justification <= right_justification;

end -- class FORMAT_TIME


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

