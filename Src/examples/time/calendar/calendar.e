class

	CALENDAR

create

	make

feature -- Initialization

	make (l: LOCALIZER; w: INTEGER) is
			-- Fill calendar structures and set default values to attributes
		require
			width_large_enough: w > 2;
			localizer_exists: l /= Void
		do
        	localizer := l;
			set_column_width (w);

			set_week_header_width (3);
			show_week_number;
			set_week_days_size (<<2,1,2,1,2,1,2>>);
			create month_format.make (l, line_size);
		
			localizer.force_boolean (False, "day_of_the_month_shown");
			localizer.force_boolean (False, "day_of_the_week_shown");
			localizer.force_boolean (True, "current_month_shown");
			localizer.force_boolean (True, "current_year_shown");
			localizer.force_boolean (False, "is_month_as_digit");

			month_format.center_justify;
		
			create l1.make(0);
			create l2.make(0);
			create l3.make(0);
			create l4.make(0);
			create l5.make(0);
			create l6.make(0);
			create tab_li.make(1,6);
			tab_li.put (l1,1);
			tab_li.put (l2,2);
			tab_li.put (l3,3);
			tab_li.put (l4,4);
			tab_li.put (l5,5);
			tab_li.put (l6,6)
		end;

feature -- Access

    column_width: INTEGER;
			-- Width of each column of the calendar
	
	week_header_width: INTEGER;
			-- Width of the first column
			-- which contains the number of the week

	week_days_size: ARRAY [INTEGER];
			-- The sizes of displayed week days

	localizer: LOCALIZER;
			-- Provider of data to format calendar

	month_format: FORMAT_DATE;
			-- Format of the first line of the calendar

feature -- Status report

	line_size: INTEGER is
			-- Width of the calendar
		do
			Result := week_header_width + 7 * column_width
		end;

    week_days: ARRAY [STRING] is
            -- Days of the week
		do
			Result := localizer.string_array_value ("week_days",
				<< "Sunday", "Monday", "Tuesday", "Wednesday",
				"Thursday", "Friday", "Saturday" >>)
		ensure
			result_exists: Result /= Void
		end;

feature -- Element change

	set_column_width (w: INTEGER) is
		do
			column_width := w
		end;

	set_week_header_width (w: INTEGER) is
		do
			week_header_width := w
		end;

	set_week_days_size (a: ARRAY [INTEGER]) is
		require
			correct_size: a.count = 7;
            correct_lenghts: a @ 1 < column_width and then a @ 1 > 0 and then 
                a @ 2 < column_width and then a @ 2 > 0 and then
                a @ 3 < column_width and then a @ 3 > 0 and then
                a @ 4 < column_width and then a @ 4 > 0 and then
                a @ 5 < column_width and then a @ 5 > 0 and then
                a @ 6 < column_width and then a @ 6 > 0 and then
                a @ 7  < column_width and then a @ 7 > 0 
		do
			week_days_size := a;
		end;

	set_month_format (f: FORMAT_DATE) is
		require
			f_exists: f /= Void
		do
			month_format := f
		ensure
			month_format_set: month_format = f
		end;

	set_localizer (l: LOCALIZER) is
		require
			l_exists: l /= Void
		do
			localizer := l
		ensure
			localizer_set: localizer = l
		end;

feature -- Status report

	is_week_number_shown: BOOLEAN;
		-- Does the week number shown at the beginning of each line?

feature -- Status setting

	show_week_number is
		do
			is_week_number_shown := True
		end;
	
	hide_week_number is
		do
			is_week_number_shown := False
		end;

feature -- Conversion

	formatted_month (d: DATE): STRING is
			-- Format of the month as in a calendar
		do
			l1.wipe_out; l1.resize (line_size); l1.fill_blank;
			l2.wipe_out; l2.resize (line_size); l2.fill_blank;
			l3.wipe_out; l3.resize (line_size); l3.fill_blank;
			l4.wipe_out; l4.resize (line_size); l4.fill_blank;
			l5.wipe_out; l5.resize (line_size); l5.fill_blank;
			l6.wipe_out; l6.resize (line_size); l6.fill_blank;		
			fill_lines (d);
			month_format.set_localizer (localizer);
			month_format.set_width (line_size);
			create Result.make (0);
			Result.append (month_format.justify (month_format.formatted (d)));
			Result.append("%N");
			Result.append (days_header); Result.append("%N");
            Result.append (l1); Result.append("%N");
			Result.append (l2); Result.append("%N");
			Result.append (l3); Result.append("%N");
			Result.append (l4); Result.append("%N");
			Result.append (l5); Result.append("%N");
			Result.append (l6); Result.append("%N")
		end;

feature {NONE} -- Implementation

    short_week_days: ARRAY [STRING] is
            -- Array with short names of week days
		local
			i: INTEGER;
			short: STRING
        do
            create Result.make (1, 7);
			from
				i := 1
			until
				i > 7
			loop
				short := (week_days @ i)
				Result.put (short.substring (1, (week_days_size @ i).min (short.count - 1)), i);
				i := i + 1
			end;
        end;

    days_header: STRING is
			-- Second line of the calendar containing
            -- days of the week name of calendar
		local
			i: INTEGER
        do
            create Result.make (line_size);
			Result.fill_blank;
			from
				i := 1
			until
				i > 7
			loop
				Result.replace_substring (short_week_days @ i,
					week_header_width + 1 + i * column_width - (short_week_days @ i).count,
					week_header_width + i * column_width);
				i := i + 1
			end -- loop
        end;

	fill_lines (d: DATE) is
			-- Fill lines with days of the current month of `d'
		local
			day_of_the_month, week_number, day_of_the_week: INTEGER;
			offset, adjust, width: INTEGER;
			first_day: DATE;
			current_line: STRING
		do
			create first_day.make (d.year, d.month, 1);
			from
				day_of_the_month := 1;
				offset := first_day.day_of_the_week - 2;
				width := 2;
            	week_number := first_day.week_of_year
			until
				day_of_the_month > d.days_in_month
        	loop
				current_line := tab_li @ (((day_of_the_month + offset)// 7) + 1);
				if is_week_number_shown then
					current_line.replace_substring (week_number.out, 1, week_number.out.count)
				end;
				from
					day_of_the_week := (day_of_the_month + offset)\\ 7 + 1
				until
					day_of_the_week > 7 or else day_of_the_month > d.days_in_month
				loop
					if day_of_the_month < 10 then
						adjust := 0
					else
						adjust := 1
					end;
					current_line.replace_substring (day_of_the_month.out,
						week_header_width + day_of_the_week * column_width - adjust,
						week_header_width + day_of_the_week * column_width);
					day_of_the_month := day_of_the_month + 1;
					day_of_the_week := day_of_the_week + 1
				end; -- loop
				week_number := week_number + 1
        	end -- loop
		end;

	l1, l2, l3, l4, l5, l6 : STRING;

	tab_li : ARRAY [STRING];

end -- class CALENDAR

--|----------------------------------------------------------------
--| EiffelTime: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| 270 Storke Road, ISE Building, second floor, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com> 
--|----------------------------------------------------------------

