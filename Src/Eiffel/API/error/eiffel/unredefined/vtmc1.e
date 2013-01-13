note
	description: "Error for calls to a problematic feature of a multi constraing formal generic type. The feature was not found."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	VTMC1

inherit
	VTMC
		redefine
			build_explain,
			subcode
		end

create
	default_create

feature -- Properties

	subcode: INTEGER_32 = 1
		-- Error subcode

	type_set: TYPE_SET_A
			-- Type set which does not contain `feature_name'

feature {INTERNAL_COMPILER_STRING_EXPORTER} -- Properties

	feature_call_name: STRING
		-- Feature name.
		-- This is the name of the feature whch occured multiple times.

feature -- Output

	build_explain (a_text_formatter: TEXT_FORMATTER)
			-- Build specific explanation explain for current error
			-- in `a_text_formatter'.
		local
			l_output: STRING_32
		do
			create l_output.make_from_string_general ("The feature with name `")
			l_output.append (encoding_converter.utf8_to_utf32 (feature_call_name))
			l_output.append_string_general ("' does not occur in the following type set:%N   ")
			a_text_formatter.add (l_output)
			type_set.ext_append_to (a_text_formatter, class_c)
			a_text_formatter.add_new_line
		end

feature {COMPILER_EXPORTER} -- Setting

	set_feature_call_name (a_feature_call_name: STRING_8)
			-- Set feature_name to `a_feature_name'
		do
			feature_call_name := a_feature_call_name
		ensure
			set: feature_call_name = a_feature_call_name
		end

	set_type_set (a_type_set: TYPE_SET_A)
			-- Set classes_with_same_feature to `a_list'
		require
			a_type_set_not_void: a_type_set /= Void
		do
			type_set := a_type_set
		ensure
			is_set: type_set = a_type_set
		end

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software"
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

end -- class VTMC1

