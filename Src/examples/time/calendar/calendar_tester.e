indexing
	description: "time value in a day"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"
	access: date, time

class
	CALENDAR_TESTER

create

	make

feature

	make is
		do
			create english_l.make;
			create cal.make (english_l, 3)
			create date1.make_now

			from
				test := 'y';
			until
				test = 'n'
			loop
                print ("%Nyear: ");
                io.readint;
                year:= io.lastint;
                print ("month: ");
                io.readint;
                month:= io.lastint;
                date1.make (year, month, 1);

				print (cal.formatted_month (date1))

				cal.set_column_width (6);
				cal.set_week_days_size (<<1,1,2,1,2,1,1>>)
				cal.set_week_header_width (5);
				cal.month_format.right_justify
				print (cal.formatted_month (date1))

				cal.set_localizer (english_l);
				cal.hide_week_number;
                cal.set_column_width (3);
                print (cal.formatted_month (date1))

                print ("%N%NAnother date ? (y/n): ")
                io.readchar;
                test := io.lastchar
			end -- loop

            print ("%Nbye !%N")
		end

feature

	english_l: ENGLISH_TIME_LOCALIZER;
	cal : CALENDAR
	i, j, year, month, day: INTEGER
	str: STRING
	test: CHARACTER

	itime1,itime2,itime3, itime4 : INTERVAL[TIME]	
	idate1, idate2, idate3, idate4 : INTERVAL[DATE]
	idt1, idt2, idt3, idt4, idt5, idt6, idt7 : INTERVAL[DATE_TIME]

	tv : TIME_VALUE
	time1, time2, time3, time4 : TIME 
	td1, td2, td3, td4, td5 : TIME_DURATION
	
	dv : DATE_VALUE
	date1, date2, date3, date4, date5, date6, date7 : DATE	 
	dd1, dd2, dd3, dd4 : DATE_DURATION

	dtv : DATE_TIME_VALUE
	dt1, dt2, dt3, dt4, dt5 : DATE_TIME 
	dtd1, dtd2, dtd3, dtd4, dtd5, dtd6, dtd7: DATE_TIME_DURATION
	
	ab : ABSOLUTE
	ge : GROUP_ELEMENT


	fd : FORMAT_DATE

end 

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

