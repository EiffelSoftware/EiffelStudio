indexing
	description: "Parse command line arguments%
					%The format for arguments should be the following:%
					%utility -switch:switch_value non_switch_value%
					%where '-' and '/' are the possible switch symbols%
					%(characters that precede a switch)."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ARGUMENT_PARSER

inherit
	ARGUMENT_PARSER_ERRORS

	EXECUTION_ENVIRONMENT
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	make (some_switches: like switches) is
			-- Set `switches' with `some_switches'.
		require
			non_void_switches: some_switches /= Void
		do
			switches := some_switches
			switches.compare_objects
		ensure
			switches_set: switches = some_switches
		end
		
feature -- Access

	switches: ARRAY [STRING]
			-- Legal command line switches

	switches_symbols: ARRAY [CHARACTER] is
			-- Switch symbols
		once
			Result := <<'-', '/'>>
		end

feature -- Processing

	process_switch (switch, switch_value: STRING) is
			-- Process switch `switch' associated with value `switch_value'.
		require
			non_void_switch: switch /= Void
			valid_switch: switches.has (switch)
		deferred			
		end
	
	process_non_switch (non_switch_value: STRING) is
			-- Process non-switch command line argument `non_switch_value'.
		require
			non_void_valie: non_switch_value /= Void
			valid_value: not non_switch_value.is_empty
		deferred			
		end
	
	post_process is
			-- Post argument parsing processing.
		deferred
		end

feature -- Basic operations

	parse is
			-- Parse command line arguments and set `parse_successful' accordingly.
			-- `last_error' and `last_error_context' provide additional information in
			-- case of failure.
		local
			i, j: INTEGER
			argument, switch: STRING
			found: BOOLEAN
			upper_bound: INTEGER
		do
			from
				i := 1
			until
				i = command_line.argument_array.count or not successful
			loop
				argument := command_line.argument (i)
				upper_bound := argument.index_of (':', 1) - 1
				if upper_bound = -1 then
					upper_bound := argument.count
				end
				found := False
				if switches_symbols.has (argument @ 1) then
					from
						j := 1
						switch := Void
					until
						j > switches.count or found
					loop
						switch := argument.substring (2, upper_bound)
						found := switch.is_equal (switches.item (j))
						j := j + 1
					end
					if found then
						if argument.count > switch.count + 2 then
							process_switch (switch, argument.substring (upper_bound + 2, argument.count))
						else
							process_switch (switch, Void)
						end
					else
						set_error (Invalid_switch, argument)
					end
				else
					process_non_switch (argument)
				end
				i := i + 1
			end
			if successful then
				post_process
			end
		end

feature {NONE} -- Implementation

	display_error is
			-- Display error and usage
		require
			error_occured: not successful
		local
			message: STRING
		do
			create message.make (4096)
			message.append ("%NError: ")
			message.append (error_message)
			message.append ("%N%NType ")
			message.append (System_name)
			message.append (" /? for additional information.%N%N")
			io.put_string (message)
		end
	
	System_name: STRING is
			-- Name of executable
		deferred
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


end -- class ARGUMENT_PARSER












