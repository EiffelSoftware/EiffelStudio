indexing
	description: "[
		Application command line entry point.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class
	APPLICATION

inherit
	SHARED_STATUS_MESSAGES
		export
			{NONE} all
		end

create
	make

feature -- Initialization

	make is
			-- Creation procedure.
		local
			l_layout: EIFFEL_LAYOUT
			l_parser: ARGUMENT_PARSER
		do
				-- Initialize environment
			create l_layout
			if not l_layout.is_eiffel_layout_defined then
				l_layout.set_eiffel_layout (create {EC_EIFFEL_LAYOUT})
			end

				-- Parse arguments and execute application
			create l_parser.make
			l_parser.execute (agent start (l_parser))
		end

	start (a_parser: ARGUMENT_PARSER) is
			-- Start exection of application
		require
			a_parser_attached: a_parser /= Void
			a_parser_is_successful: a_parser.is_successful
		local
			l_options: APPLICATION_OPTIONS
			l_printer: TEXT_PRINTER
			l_generator: FILE_GENERATOR_ENGINE
		do
				-- Create configuration objects
			create {BASIC_TEXT_PRINTER}l_printer.make (io.default_output)
			l_printer.put_string (status_messages.scanning_files_message)
			create l_options.make (a_parser)

			if not l_options.files.is_empty then
				l_printer.put_string (status_messages.done_message)
				l_printer.new_line

					-- Generate classes
				l_printer.put_string (status_messages.generating_visitor_class_message)
				create l_generator
				l_generator.generate_files (l_options)
				l_printer.put_string (status_messages.done_message)
			else
				l_printer.put_string (status_messages.nothing_to_generate_message)
			end
			l_printer.new_line
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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

end -- class APPLICATION
