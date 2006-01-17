indexing

	description:
		"All resouorces for the application."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class TTY_RESOURCES

inherit
	SHARED_CONFIGURE_RESOURCES
	SHARED_EIFFEL_PROJECT
	TTY_CONSTANTS
	EIFFEL_ENV

create 
	initialize

feature {NONE} -- Initialization

	initialize is
			-- Initialize resource table
		do
			internal_initialize
		end

	internal_initialize is
			-- Initialize the resource table.
			-- (By default, resources will be looked the `eifinit'
			-- directory in $ISE_EIFFEL, $HOME, and $ISE_DEFAULTS looking
			-- for file general and for platform specific files).
		local
			resource_parser: RESOURCE_PARSER
			test_file: RAW_FILE
			retried: BOOLEAN
			error_msg: STRING
		once
			if retried then
				error_msg := warning_messages.w_cannot_read_file (compiler_configuration)
			else
				create test_file.make (compiler_configuration)
				if test_file.exists and test_file.is_readable then
					create resource_parser
					resource_parser.parse_file (compiler_configuration, configure_resources)
				else
					error_msg := compiler_configuration.twin
					error_msg.append (Warning_messages.w_file_does_not_exist_execution_impossible)
				end
			end
			if error_msg /= Void then
				io.error.put_string (error_msg)
				error_occurred := True
			else
				error_occurred := False
			end
		rescue
			retried := True
			retry
		end

feature -- Status report

	error_occurred: BOOLEAN;
			-- Did an error occur while reading the default preferences file ?
			
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

end -- class TTY_RESOURCES
