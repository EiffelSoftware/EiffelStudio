indexing
	description: "Simple calculator for date"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"
	access: date, time

class

	CALCULATOR

creation

	make

feature -- Initialization
	make is
		local
			i, j: INTEGER;
			test, key, c: CHARACTER;
			date2: DATE;
			command: COMMAND_DATE
		do
			print (" CALCULATOR FOR DATES ") print ("%N")
			!! date2.make_now;
			from
				test := 'y';
				initialize_command
				print ("%NCurrent date is: ");
				print (date2);
			until
				test = 'n'
			loop
				print ("%NCommand> ");
				io.readchar;
				key:= io.lastchar;

				inspect
					key
				when 'q' then
					test := 'n';
					io.next_line
				when 'h' then
					from
						j := 1
					until
						j > command_table.count
					loop
						c := command_table.current_keys @ j;
						j := j + 1
						print (c) print (": ");
						print (command_table.item (c).display_help);
						print ("%N")
					end
 						io.next_line;
				when 'y', 'm', 'w', 'd', 's' then
					command := command_table.item (key);
					date2 := command.execute (date2) 
					print ("Current date is now: ");
					print (date2);
				when '%N' then
				else
					print ("Help available with 'h'")
					io.next_line
				end;
			end
			print ("bye !")
		end;

	initialize_command is
		do
			!! command_table.make (0);
			!! add_day;
			command_table.put (add_day, 'd');
			!! add_month;
			command_table.put (add_month, 'm');
			!! add_year;
			command_table.put (add_year, 'y');
			!! add_week;
			command_table.put (add_week, 'w');
			!! set_date;
			command_table.put (set_date, 's')
		end;
			

feature -- Access

	command_table: HASH_TABLE [COMMAND_DATE, CHARACTER];
	add_day: ADD_DAY;
	add_month: ADD_MONTH;
	add_year: ADD_YEAR;
	add_week: ADD_WEEK;
	set_date: SET_DATE;

end -- class CALCULATOR 
