indexing
	description: "VFAV error detected at parsing time."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class VFAV_SYNTAX

inherit
	FEATURE_NAME_ERROR
		undefine
			subcode
		redefine
			trace
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		end

	SYNTAX_MESSAGE

feature {NONE} -- Creation

	make (f: FEATURE_NAME) is
			-- Create error object.
		require
			feature_name_not_void: f /= Void
			alias_name_not_void: f.alias_name /= Void
		do
			set_class (system.current_class)
			set_feature_name (f.visual_name)
			set_location (f.alias_name)
		ensure
			class_c_set: class_c /= Void
			feature_name_set: feature_name = f.visual_name
			location_set: line = f.alias_name.start_location.line and column = f.alias_name.start_location.column
		end
	
feature -- Access

	code: STRING is "VFAV"
			-- Error code

feature -- Output

	trace (a_text_formatter: TEXT_FORMATTER) is
			-- Debug purpose
		do
			initialize_output
			print_error_message (a_text_formatter)
			a_text_formatter.add ("Class: ")
			class_c.append_signature (a_text_formatter, False)
			a_text_formatter.add_new_line
			a_text_formatter.add ("Feature name: ")
			a_text_formatter.add_class_syntax (Current, class_c, feature_name)
			a_text_formatter.add_new_line
			build_explain (a_text_formatter)
			a_text_formatter.add ("File: ")
			a_text_formatter.add (file_name)
			a_text_formatter.add_new_line
			a_text_formatter.add ("Line: ")
			a_text_formatter.add_int (line)
			a_text_formatter.add_new_line
			a_text_formatter.add ("Column: ")
			a_text_formatter.add_int (column)
			display_line (a_text_formatter, previous_line)
			display_syntax_line (a_text_formatter, current_line)
			display_line (a_text_formatter, next_line)
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

end
