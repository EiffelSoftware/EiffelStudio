note

	description:
		"Error when bad conformance on first argument of an infix function."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class VWOE1

inherit

	VWOE
		redefine
			build_explain, is_defined
		end

feature -- Properties

	operator_feature: E_FEATURE
			-- Feature of the operatgor.

	formal_type: TYPE_A
			-- Formal argument type.

	actual_type: TYPE_A
			-- Actual type of the argument in the call.

feature -- Access

	is_defined: BOOLEAN
			-- Is the error fully defined?
		do
			Result :=
				is_class_defined and then
				attached op_name and then
				attached operator_feature and then
				attached formal_type and then
				attached actual_type
		ensure then
			attached op_name
			attached operator_feature
			attached formal_type
			attached actual_type
		end

feature -- Output

	build_explain (a_text_formatter: TEXT_FORMATTER)
			-- Build specific explanation explain for current error
			-- in `a_text_formatter'.
		do
			a_text_formatter.add ("Operator: ")
			a_text_formatter.add ({UTF_CONVERTER}.utf_8_string_8_to_string_32 (op_name))
			a_text_formatter.add_new_line
			a_text_formatter.add ("Operator feature: ")
			operator_feature.append_name (a_text_formatter)
			a_text_formatter.add_new_line
			a_text_formatter.add ("Formal type: ")
			formal_type.append_to (a_text_formatter)
			a_text_formatter.add_new_line
			a_text_formatter.add ("Actual type: ")
			actual_type.append_to (a_text_formatter)
			a_text_formatter.add_new_line
		end

feature {COMPILER_EXPORTER}

	set_operator_feature (f: FEATURE_I)
			-- Initialize `operator_feature` from `f`.
		do
			operator_feature := f.e_feature
		ensure
			operator_feature ~ f.e_feature
		end

	set_formal_type (t: TYPE_A)
			-- Assign `t' to `formal_type'.
		require
			valid_t: t /= Void
		do
			formal_type := t
		end

	set_actual_type (t: TYPE_A)
			-- Assign `t' to `actual_type'
		require
			valid_t: t /= Void
		do
			actual_type := t
		end

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software"
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

end -- class VWOE1
