﻿note

	description: "Drivers for basic data structure demos"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class 
	DEMO_DRIVER 

create
	make

feature -- Creation

	make
			-- Create arrays to store menus. 
		do
			create menu_entry.make_empty
			create menu_help.make_empty
			create menu_tag.make_empty
			create menu_flag.make_filled (False, 1, Max_Number_of_Entries)
			build_line
		end

feature -- Constant attributes

	Max_height_of_menu_column: INTEGER = 10 
	Max_Number_of_Entries: INTEGER = 40 
	Max_Length_of_an_Entry: INTEGER = 75 
	Max_Length_of_a_tag: INTEGER = 2 

feature -- Other attributes

	menu_entry: ARRAY [STRING]
	menu_help: ARRAY [STRING]
	menu_tag: ARRAY [STRING]
	menu_flag: ARRAY [BOOLEAN]
	line: STRING
	comment: STRING
	menu_size: INTEGER 
	last_entry: INTEGER
	menu_height: INTEGER
	choice: INTEGER

feature -- Output

	putstring (s: STRING)
			-- Write `s' at end of default output.
		require
			string_not_void: s /= void
		do
			io.put_string (s)
		end
		
	new_line
			-- Write line feed at end of default output.
		do
			io.new_line
		end
		
	putint (i: INTEGER)
			-- Write `i' at end of default output.
		do
			io.put_integer (i)
		end
		
	putbool (b: BOOLEAN)
			-- Write `b' at end of default output.
		do
			io.put_boolean (b)
		end

feature -- Routines

	exit
			-- Null action in this class.
		do
		end

	new_menu (new_comment: STRING)
			-- Create a new menu with new_comment as banner.
		do
			comment := new_comment
			if comment = Void then
				comment := "No name"
			end
			choice := 1
			menu_size := 0
		end

	add_entry (entry: STRING ; help: STRING)
			-- Add an entry to the menu; assign its index to last_entry.
			-- The first argument is the name of the entry. If it
			-- contains upper case letters, they will be used as
			-- a tag for recognizing the user's input.
			-- For example, Put_Right will be selected if the user
			-- types in 'pr'. The tag may not be more than
			-- Max_length+of_a_tag letters long .
			-- The string given by the second argument should
			-- explain what the entry does .
		require
			not_too_many_entries: menu_size < Max_Number_of_Entries 
			name_not_void: entry /= Void 
			real_help: help /= Void
		do
			menu_size := menu_size + 1 
			entry.keep_head (Max_Length_of_an_Entry)
			menu_entry.force (entry, menu_size) 
			menu_help.force (help, menu_size) 
			menu_tag.force (get_tag (entry), menu_size) 
			last_entry := menu_size
		end

	get_tag (entry: STRING): STRING
			-- Tag of entry, i.e. upper case letters
		local
			length: INTEGER 
			char: CHARACTER 
			i: INTEGER
		do
			from
				length := entry.count
				create Result.make (Max_Length_of_a_Tag)
				i := 1
			until
				i > length or Result.count = Max_Length_of_a_Tag
			loop
				char := entry.item (i)
				if char.is_upper then
					Result.extend (char) 
				end
				i := i + 1
			end
		end

	print_menu
			-- Print menu.
		local
			i: INTEGER 
		do
			io.putstring (line)
			io.new_line
			io.putstring (comment)
			io.new_line
			io.putstring ("Select a command by typing the first two letters")
			io.new_line
			io.putstring ("in upper- or lower-case (? for help)")
			io.new_line
			io.putstring (line)
			io.new_line
			menu_height := menu_size
			from
				i := 1
			until
				i > menu_height
			loop
				print_entry (i)
				io.putchar ('%N')
				i := i + 1
			end
			io.putstring (line)
			io.new_line
		end

	print_entry (n: INTEGER)
			-- Print `n'-th menu item. 
		local
			i, length: INTEGER
			entry: STRING
		do
			entry := menu_entry.item (n)
			length := entry.count
			from
				i := 1
			until
				i > length
			loop
				io.putchar (entry.item (i)) 
				i := i + 1
			end
		end

	complete_menu
			-- Add help command to menu
		do
			menu_size := menu_size + 1 
			menu_entry.force ("?  Help", menu_size) 
			menu_help.force ("Sorry, no further help available", menu_size) 
			menu_tag.force ("?", menu_size) 
		end

	get_choice: INTEGER
			-- Once the menu has been completely defined using
			-- new_menu and add_menu routines, get_choice gets
			-- the user input. The result is the number of
			-- the entry as it has been entered by add_menu 
			-- (first entered returns number 1, ...) .
		do
			io.putstring ("%NCOMMAND: ")
			choice := read_choice 
			if choice = menu_size then
				print_menu
				io.putstring ("%NHELP: ")
				choice := read_choice 
				show_help
				choice := get_choice
			end
			Result := choice
		end

	bell
			-- Ring the bell.
		do
			io.putstring ("%/007/")
		end

	build_line
			-- Make a line with `-' characters.
		local
			i: INTEGER
		do
			from
				create line.make (60)
			until
				i = 60
			loop
				line.extend ('-')
				i := i + 1
			end
		end

	show_help
			-- Display a help message.
		do
			io.putstring (menu_entry.item (choice))
			io.putstring (" ==> %N     ")
			io.putstring (menu_help.item (choice))
			io.new_line
		end

	get_string (what_is_it: STRING): STRING
			-- Get a user string input for stdin. 
			-- 'what_is_it' is the name of the requested value. 
		do
			io.putstring("Please enter parameter %'") 
			io.putstring(what_is_it) 
			io.putstring("%' ") 
			io.readline
			Result := io.laststring
		end

	get_integer (what_is_it: STRING): INTEGER
			-- Same as get_string but reads an integer.
		do
			Result := get_string (what_is_it).to_integer
		end

	signal_error (message: STRING)
			-- Display the error message in the top of the monitoring
			-- screen and ring a bell.
		do
			bell
			if message = Void then
				io.putstring ("This operation is not allowed")
				io.new_line
			else
				io.putstring (message)
			end
		end

	read_choice: INTEGER
			-- Menu item corresponding to user's input
		local
			recognized_entry, number_char_read, i: INTEGER
			tag: STRING
			char: CHARACTER
			bad_char: BOOLEAN
		do
			from
				i := 1
			until
				i > menu_size
			loop
				menu_flag.put (true, i)
				i := i + 1
			end 
			from
				recognized_entry := 0
				number_char_read := 0
			until
				recognized_entry > 0
			loop
				io.readchar
				char := io.lastchar
				number_char_read := number_char_read + 1
				if char.is_lower then
					char := char.upper
				end
				from
					bad_char := true; i := 1
				until
					i > menu_size or recognized_entry > 0
				loop
					if menu_flag.item (i) then
						tag := menu_tag.item (i)
						if tag.item (number_char_read) = char then
							bad_char := false
							if tag.count = number_char_read then
								recognized_entry := i
							end
						else
							menu_flag.put (false, i)
						end
					end
					i := i + 1
				end
				if bad_char then
					io.readline; tag := io.laststring
					number_char_read := 0
					signal_error ("Bad choice. Try again: ")
					from
						i := 1
					until
						i > menu_size
					loop
						menu_flag.put (true, i)
						i := i + 1
					end
				end
			end
			io.readline
			tag := io.laststring
			Result := recognized_entry
		end

	start_result
			-- No default action.
		do
		end 

	end_result
			-- No default action.
		do
		end

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class DEMO_DRIVER
