indexing
	description: "Simple calculator for date"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"
	access: date, time

class
	CALCULATOR

create
	make

feature -- Initialization

	make is
		local
			j: INTEGER
			test, key, c: CHARACTER
			date2: DATE
			command: COMMAND_DATE
		do
			print (" CALCULATOR FOR DATES ") print ("%N")
			create date2.make_now
			from
				test := 'y'
				initialize_command
				print ("%NCurrent date is: ")
				print (date2)
			until
				test = 'n'
			loop
				print ("%NCommand> ")
				io.readchar
				key:= io.lastchar

				inspect
					key
				when 'q' then
					test := 'n'
					io.next_line
				when 'h' then
					from
						j := 1
					until
						j > command_table.count
					loop
						c := command_table.current_keys @ j
						j := j + 1
						print (c) print (": ")
						print (command_table.item (c).display_help)
						print ("%N")
					end
 						io.next_line
				when 'y', 'm', 'w', 'd', 's' then
					command := command_table.item (key)
					date2 := command.execute (date2) 
					print ("Current date is now: ")
					print (date2)
				when '%N' then
				else
					print ("Help available with 'h'")
					io.next_line
				end
			end
			print ("bye !")
		end

	initialize_command is
		do
			create command_table.make (0)
			create add_day
			command_table.put (add_day, 'd')
			create add_month
			command_table.put (add_month, 'm')
			create add_year
			command_table.put (add_year, 'y')
			create add_week
			command_table.put (add_week, 'w')
			create set_date
			command_table.put (set_date, 's')
		end
			

feature -- Access

	command_table: HASH_TABLE [COMMAND_DATE, CHARACTER]
	add_day: ADD_DAY
	add_month: ADD_MONTH
	add_year: ADD_YEAR
	add_week: ADD_WEEK
	set_date: SET_DATE;

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


end -- class CALCULATOR 

