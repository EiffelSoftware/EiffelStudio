note
	description: "Holds information on a performed parsed test."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	PARSE_TEST_RESULT

create
	make

feature {NONE} -- Initialization

	make (a_fn: like file_name; a_ticks: like completion_ticks; a_succ: like successful; a_id: like parser_id)
			-- Initialize test result with tested related information.
		require
			a_fn_attached: a_fn /= Void
			not_a_fn_is_empty: not a_fn.is_empty
			a_id_attached: a_id /= Void
			not_a_id_is_empty: not a_id.is_empty
		do
			file_name := a_fn
			completion_ticks := a_ticks
			successful := a_succ
			parser_id := a_id
		ensure
			file_name_set: file_name = a_fn
			completion_ticks_set: completion_ticks = a_ticks
			successful_set: successful = a_succ
			parser_id_set: parser_id = a_id
		end

feature -- Access

	file_name: STRING
			-- Full path to file test was performed on

	completion_ticks: REAL_64
			-- Time, in ticks test was completed in

	frozen_completion_ticks: REAL_64
			-- Time, in ticks test on a frozen parser was completed in

	successful: BOOLEAN
			-- Indicates if parsing was successful

	parser_id: STRING
			-- A name or id given to a specific parser to indentify it

feature -- Element changed

	set_frozen_completion_ticks (a_ticks: like frozen_completion_ticks)
			-- Set `frozen_completion_ticks' with `a_ticks'
		do
			frozen_completion_ticks := a_ticks
		ensure
			frozen_completion_ticks_set: frozen_completion_ticks = a_ticks
		end

invariant
	file_name_attached: file_name /= Void
	not_file_name_is_empty: not file_name.is_empty
	parser_id_attached: parser_id /= Void
	not_parser_id_is_empty: not parser_id.is_empty

note
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

end -- class {PARSE_TEST_RESULT}
