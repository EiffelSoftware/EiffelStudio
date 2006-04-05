indexing
	description: "Generate a warning for an obsolete syntax."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SYNTAX_WARNING

inherit
	WARNING
		redefine
			trace, file_name
		end

	SYNTAX_MESSAGE

	SHARED_WORKBENCH
		export
			{NONE} all
		end

	SHARED_TEXT_ITEMS
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (s, e: INTEGER; f: like file_name; m: STRING) is
			-- Create a new SYNTAX_WARNING instance.
		require
			f_not_void: f /= Void
			m_not_void: m /= Void
		do
			set_position (s, e)
			warning_message := m
			file_name := f
			associated_class := System.current_class
		ensure
			line_set: line = s
			column_set: column = e
			warning_message_set: warning_message = m
			file_name_set: file_name = f
		end

feature -- Properties

	warning_message: STRING
			-- Specify syntax issue message.

	file_name: STRING
			-- Path to file where syntax issue happened

	code: STRING is "Syntax warning"
			-- Error code

	associated_class: CLASS_C
			-- Class in which syntax warning occurred.

feature -- Output

	build_explain (a_text_formatter: TEXT_FORMATTER) is
		do
		end

	trace (a_text_formatter: TEXT_FORMATTER) is
			-- Debug purpose
		do
			initialize_output

			a_text_formatter.add_error (Current, "Obsolete")
			a_text_formatter.add (" syntax used at line ")
			a_text_formatter.add_int (line)
				-- Error happened in a class
			a_text_formatter.add (" in class ")
			a_text_formatter.add_class_syntax (Current, associated_class, associated_class.class_signature)
			if warning_message /= Void then
				a_text_formatter.add_new_line
				a_text_formatter.add (warning_message)
				a_text_formatter.add_new_line
			end
			a_text_formatter.add_new_line
			build_explain (a_text_formatter)
			display_line (a_text_formatter, previous_line)
			display_syntax_line (a_text_formatter, current_line)
			display_line (a_text_formatter, next_line)
		end

invariant
	associated_class_not_void: associated_class /= Void

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

end -- class SYNTAX_WARNING
