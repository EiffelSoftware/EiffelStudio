indexing
	description: "[
		Command line application root class.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

class
	APPLICATION

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	make is
			-- Entry point.
		local
			l_parser: ARGUMENT_PARSER
		do
			create l_parser.make
			l_parser.execute (agent start (l_parser))
			if not l_parser.is_successful then
				{ENVIRONMENT}.exit (-1)
			end
		end

	start (a_options: I_OPTIONS) is
			-- Start application executionoptions `a_options'
		require
			a_options_attached: a_options /= Void
			can_read_a_options: a_options.can_read_options
		local
			l_stream: TEXT_WRITER
			l_gen: I_WIX_FRAGMENT_GENERATOR
		do
			l_gen := create_wix_generator (a_options)

			create {STRING_WRITER}l_stream.make ({CULTURE_INFO}.invariant_culture)
			l_gen.generate (a_options, l_stream)
			l_stream.close

				-- Send output to console
			{SYSTEM_CONSOLE}.write_line (l_stream.to_string)
		end

feature {NONE} -- Factory functions

	create_wix_generator (a_options: I_OPTIONS): I_WIX_FRAGMENT_GENERATOR is
			-- Creates a new generator for WiX documents
		require
			a_options_attached: a_options /= Void
			can_read_a_options: a_options.can_read_options
		do
			create {WIX_FRAGMENT_GENERATOR}Result
		ensure
			result_attached: Result /= Void
		end


;indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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

end
