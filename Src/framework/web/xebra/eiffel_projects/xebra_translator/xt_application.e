note
	description: "[
		Runns the argument parser which then runns the translator.
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XT_APPLICATION

inherit
	ERROR_SHARED_MULTI_ERROR_MANAGER
	KL_SHARED_ARGUMENTS
	XU_SHARED_OUTPUTTER

create
	make

feature {NONE} -- Initialization

	make
			-- Make the application.
		local
			l_arg_parser: XT_ARGUMENT_PARSER
		do
			create l_arg_parser.make
			l_arg_parser.execute (agent run (l_arg_parser))
		end

feature -- Operation

	run (a_arg_parser: XT_ARGUMENT_PARSER)
			-- Runs the translator
		require
			a_arg_parser_attached: attached a_arg_parser
		local
			l_printer: ERROR_CUI_PRINTER
			l_translator: XP_TRANSLATOR
			l_dir: DIRECTORY
		do
			o.set_name ("XEBTRANS")
			o.set_debug_level (a_arg_parser.debug_level)
			create l_translator.make (a_arg_parser.project_name)
			create l_dir.make (a_arg_parser.input_path)

			l_translator.set_output_path (a_arg_parser.output_path)

			l_translator.process_with_files (l_dir.linear_representation, create {FILE_NAME}.make_from_string (a_arg_parser.tag_lib_path))

			create l_printer.default_create
			if error_manager.has_warnings then
				error_manager.trace_warnings (l_printer)
			end

			if not error_manager.is_successful then
				error_manager.trace_errors (l_printer)
			else
				o.iprint ("Output generated to '" + l_translator.output_path + "'")
				o.iprint ("System translated.")
			end
		end

;note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end



