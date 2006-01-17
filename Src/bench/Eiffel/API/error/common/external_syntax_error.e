indexing

	description: "Syntax error for invalid external declaration."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class EXTERNAL_SYNTAX_ERROR

inherit

	SYNTAX_ERROR
		rename
			syntax_message as external_error_message
		redefine
			external_error_message
		end

create {EXTERNAL_LANG_AS, EXTERNAL_EXTENSION_AS}

	init

feature -- Property

	external_error_message: STRING
			-- Specific syntax message

feature {EXTERNAL_LANG_AS, EXTERNAL_EXTENSION_AS} -- Setting

	set_external_error_message (message: STRING) is
			-- Assign `external_error_message' with `message'.
		require
			message_not_void: message /= Void
		do
			external_error_message := message.twin
		end

	set_file_name (new_filename: FILE_NAME) is
			-- Assign `new_filename' to `file_name'.
		do
			file_name := new_filename
		end

	set_line (i: INTEGER) is
			-- Assign `i' to `line'.
		do
			line := i
		ensure
			line_set: line = i
		end

	set_column (i: INTEGER) is
			-- Assign `i' to `column'.
		do
			column := i
		ensure
			column_set: column = i
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

end -- class EXTERNAL_SYNTAX_ERROR
