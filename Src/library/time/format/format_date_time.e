indexing
	description: "Formatter for date and time"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	access: date, time

class
	FORMAT_DATE_TIME

inherit
	FORMAT [DATE_TIME]

creation 
	make

feature -- Initialization

	make (d: FORMAT_DATE; t: FORMAT_TIME; w: INTEGER) is
			-- Set `format_date' to `d',
			-- `format_time' to `t' and
			-- `width' to `w'.
		require
			d_exists: d /= Void;
			t_exists: t /= Void;
			width_large_enough: w > d.width + t.width
		do
			format_date := d;
			format_time := t;
			width := w;
			blank_fill;
			center_justify;
			set_date_first;
			justify_date;
			justify_time;
			set_separator_date_time (" ")
		ensure
			format_date_set: format_date = d;
			format_time_set: format_time = t;
			width_set: width = w
		end;

feature -- Access

	format_date: FORMAT_DATE;
			-- Formatter for the date

	format_time: FORMAT_TIME;
			-- Formatter for the time

	separator_date_time: STRING;
			-- Separator between date and time

feature -- Status report

	is_date_before_time: BOOLEAN;
			-- is date first?

	is_date_justified: BOOLEAN;
			-- is date justified before formatted

	is_time_justified: BOOLEAN;
			-- is time justified before formatted

feature -- Status setting

	set_date_first is
			-- Set `is_date_before_time' to `True'
		do
			is_date_before_time := True
		ensure
			is_date_before_time_set: is_date_before_time
		end;

	set_time_first is
			-- Set `is_date_before_time' to `False'
		do
			is_date_before_time := False
		ensure
			is_date_before_time_set: not is_date_before_time
		end;

	justify_date is
			-- Set `is_date_justified' to `True'
		do
			is_date_justified := True
		ensure
			is_date_justified_set: is_date_justified
		end;

	not_justify_date is
			-- Set `is_date_justified' to `False'
		do
			is_date_justified := False
		ensure
			is_date_justified_set: not is_date_justified
		end;

	justify_time is
			-- Set `is_time_justified' to `True'
		do
			is_time_justified := True
		ensure
			is_time_justified_set: is_time_justified
		end;

	not_justify_time is
			-- Set `is_time_justified' to `False'
		do
			is_time_justified := False
		ensure
			is_time_justified_set: not is_time_justified
		end;

feature -- Element change

	set_format_date (fd: FORMAT_DATE) is
			-- Set `format_date' to `fd'
		require
			d_exists: fd /= Void;
			width_large_enough: fd.width < width - format_time.width
		do
			format_date := fd
		ensure
			format_date_set: format_date = fd
		end;

	set_format_time (ft: FORMAT_TIME) is
			-- Set `format_time' to `ft'
		require
			t_exists: ft /= Void;
			width_large_enough: ft.width < width - format_date.width
		do
			format_time := ft
		ensure
			format_time_set: format_time = ft
		end;

	set_separator_date_time (s: STRING) is
			-- Set `separator_date_time' to `s'
		require
			width_large_enough: s.count <= width - format_time.width - format_date.width
			string_not_void: s /= Void
		do
			separator_date_time := s
		ensure
			separator_date_time_set: separator_date_time = s
		end;

feature -- Conversion

	formatted (dt: DATE_TIME): STRING is
			-- Format `dt'
		do
			if separator_date_time = Void then set_separator_date_time("") end;
			Result := format_date.formatted (dt.date);
			if is_date_justified then
				Result := format_date.justify (Result)
			end;
			if is_date_before_time then
				Result.append (separator_date_time);
				if is_time_justified then
					Result.append (format_time.justify (format_time.formatted (dt.time)))
				else
					Result.append (format_time.formatted (dt.time))
				end
			else
				Result.prepend (separator_date_time);
				if is_time_justified then
					Result.prepend (format_time.justify (format_time.formatted (dt.time)))
				else
					Result.prepend (format_time.formatted (dt.time))
				end
			end
		end;

invariant
	width_large_enough: width >= separator_date_time.count + format_time.width + format_date.width;

end -- class FORMAT_DATE_TIME


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

