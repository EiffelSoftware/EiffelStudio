indexing
	description: "Input/output operation for batch command line processing."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision $"

class COMMAND_LINE_IO 

feature -- Properties

	output_window: OUTPUT_WINDOW
			-- Output window

	last_input: STRING
			-- Last input string

	abort: BOOLEAN
			-- Does the user want to abort the command?

feature -- Input/output

	termination_requested: BOOLEAN is
		local
			str: STRING
		do
			io.error.put_string ("%N%
				%Press <Return> to resume compilation or <Q> to quit%N")
			wait_for_return
			str := io.last_string.as_lower
			Result := ((str.count >= 1) and then (str.item (1) = 'q'))
		end

	confirmed (message: STRING): BOOLEAN is
		local
			c: CHARACTER
		do
			io.put_string (message)
			io.put_string (" [y/n]? ")
			io.read_character
			c := io.last_character
			if c /= '%N' then
				io.to_next_line
			end
			Result := ((c = 'Y') or (c = 'y'))
		end

	wait_for_return is
		do
			io.read_line
		end

	get_last_input is
			-- Get the last input entered by the user
		do
			last_input := command_arguments.current_item
		end

	more_arguments: BOOLEAN is
			-- Are there more arguments?
		do
			Result := command_arguments.more_arguments
		end

	get_name is
			-- Get the name of the last entered text
		local
			i, j: INTEGER
			item: CHARACTER
			arg: STRING
			count: INTEGER
		do
			wait_for_return
			count := io.last_string.count
			create arg.make (count)
			command_arguments.wipe_out
			from
				i := 1
				j := 1
			until
				(i > count)
			loop
				item := io.last_string.item (i)
				if (item = ' ') or else (item = '%T') then
					if arg.count /= 0 then
						command_arguments.force (arg, j)
						j := j + 1
						create arg.make (count - i)
					end
				else
					arg.extend (item)
				end
				i := i + 1
			end
			if j = 1 or else arg.count /= 0 then
					-- If we are processing more than one word, we don't
					-- want to keep the trailing white spaces
				command_arguments.force (arg, j)
			end
		end

	get_class_name is
		do
			if not more_arguments then
				io.put_string ("--> Class name: ")
				get_name
			end
			get_last_input
			last_input.to_upper
			if last_input.is_empty then
				abort := True
			end
		end

	get_feature_name is
		do
			if not more_arguments then
				io.put_string ("--> Feature name: ")
				get_name
			end
			get_last_input
			last_input.to_lower
			if last_input.is_empty then
				abort := True
			end
		end

	get_filter_name is
		do
			if not more_arguments then
				io.put_string ("--> Filter name: ")
				get_name
			end
			get_last_input
		end

	get_option_value (an_option: STRING; value: BOOLEAN) is
			-- Get a valid from `an_option' of either
			-- true or false.
			-- Set `last_input' to "False" or "True"
		require
			valid_name: an_option /= Void
		local
			tmp: STRING
		do
			if not more_arguments then
				io.put_string ("--> ")
				io.put_string (an_option)
				io.put_string (" [")
				if value then
					io.put_string ("yes")
				else
					io.put_string ("no")
				end
				io.put_string ("]: ")
				get_name
			end
			get_last_input
			if last_input = Void or else last_input.is_empty then
				last_input := value.out
			else
				tmp := last_input.as_lower
				if tmp.is_equal ("yes") or else tmp.is_equal ("y") then
					last_input := (True).out
				else
					last_input := (False).out
				end
			end
		ensure
			last_input_is_boolean: last_input.is_boolean
		end

	get_prof_file_name is
		do
			if not more_arguments then
				io.put_string ("--> Profile information file name (default: `profinfo'): ")
				get_name
			end
			get_last_input
		end

	get_compile_type is
		do
			if not more_arguments then
				from
					io.put_string ("--> Compile type (default: `workbench'): ")
					get_name
					get_last_input
				until
					last_input.is_empty or else last_input.is_equal ("workbench") or else
					last_input.is_equal ("final")
				loop
					io.put_string ("--> Compile type (default: `workbench'): ")
					get_name
					get_last_input
				end
			else
				get_last_input
			end
		end

	get_profiler is
		do
			if not more_arguments then
				io.put_string ("--> Used profiler (default: `eiffel'): ")
				get_name
			end
			get_last_input
		end

	reset_abort is
		do
			abort := False
		ensure
			not_abort: not abort
		end

	print_too_many_arguments is
		require
			more_arguments: more_arguments
		local
			not_first: BOOLEAN
		do
			io.error.put_string ("%
				%Too many arguments. The following arguments will be ignored:%N")
			from
			until
				not more_arguments
			loop
				if not_first then
					io.error.put_character (' ')
				end
				not_first := True
				io.error.put_string (command_arguments.current_item)
			end
			io.error.put_new_line
			io.error.put_new_line
		end

feature -- Setting

	set_output_window (display: OUTPUT_WINDOW) is
		do
			output_window := display
		end

feature {EWB_CMD} -- Implementation

	command_arguments: EWB_ARGUMENTS is
		once
			create Result.make (1, 2)
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class COMMAND_LINE_IO
