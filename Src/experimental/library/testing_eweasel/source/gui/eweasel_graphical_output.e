note
	description: "Controller of all graphical output."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EWEASEL_GRAPHICAL_OUTPUT

inherit
	EWEASEL_OUTPUT_CONTROL		
		redefine
			make,
			interface,
			append,
			append_error,
			append_new_line,
			clear,
			flush
		end

create
	make

feature -- Creation

	make (a_interface: EV_RICH_TEXT)
			-- Create
		do			
			interface := a_interface	
			append ("Eweasel output...", False)
		end		
		
feature -- Commands

	clear
			-- Clear the current output
		do
			interface.set_text (empty_string)
		end
		
	flush
			-- Flush
		do	
			(create {EV_ENVIRONMENT}).application.process_events			
		end		

	append (output: STRING; on_new_line: BOOLEAN)
			-- Append `output' to current output
		do
			output.prune_all ('%R')
			if on_new_line then
				interface.append_text (new_line)
			end
			interface.append_text (output)
		end
		
	append_error (output: STRING; on_new_line: BOOLEAN)
			-- Append `output' to current output, formatted to indicate error
		local
			l_format: like error_format
		do
			output.prune_all ('%R')
			l_format := interface.character_format (interface.caret_position)
			interface.enable_edit
			interface.set_caret_position (interface.text_length + 1)
			interface.set_current_format (error_format)
			interface.append_text (output)
			if on_new_line then
				interface.append_text (new_line)
			end			
			interface.set_current_format (l_format)
			interface.disable_edit
		end

	append_new_line
			-- Append new line
		do
			interface.append_text (new_line)
		end

feature {NONE} -- Implementation
	
	interface: EV_RICH_TEXT
			-- Graphical widget
			
	error_format: EV_CHARACTER_FORMAT
			-- Error format
		once
			create Result
			Result.set_color (create {EV_COLOR}.make_with_rgb (1.0, 0.0, 0.0))
		end		

invariant
	has_interface: interface /= Void

note
	copyright: "[
			Copyright (c) 1984-2007, University of Southern California and contributors.
			All rights reserved.
			]"
	license:   "Your use of this work is governed under the terms of the GNU General Public License version 2"
	copying: "[
			This file is part of the EiffelWeasel Eiffel Regression Tester.

			The EiffelWeasel Eiffel Regression Tester is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License version 2 as published
			by the Free Software Foundation.

			The EiffelWeasel Eiffel Regression Tester is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License version 2 for more details.

			You should have received a copy of the GNU General Public
			License version 2 along with the EiffelWeasel Eiffel Regression Tester
			if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA
		]"


end -- class EWEASEL_GRAPHICAL_OUTPUT
