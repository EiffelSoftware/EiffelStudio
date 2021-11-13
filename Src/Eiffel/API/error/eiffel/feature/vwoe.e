note

	description:
		"Error when a prefix/infix operator doesn't %
		%exist in a class."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class VWOE

inherit

	FEATURE_ERROR
		redefine
			build_explain, is_defined
		end

feature -- Properties

	other_class: CLASS_C;
			-- Class for which there is no infix/prefix feature

	other_type_set: TYPE_SET_A;
			-- Class for which there is no infix/prefix feature

	code: STRING = "VWOE";
			-- Error code

feature {INTERNAL_COMPILER_STRING_EXPORTER} -- Properties

	op_name: STRING;
			-- Internal name of the infix/prefix feature

feature -- Access

	is_defined: BOOLEAN
			-- Is the error fully defined?
		do
			Result := is_class_defined and then
				op_name /= Void and then
				(other_class /= Void or other_type_set /= Void)
		end;

feature -- Output

	build_explain (a_text_formatter: TEXT_FORMATTER)
			-- Build specific explanation image for current error
			-- in `a_text_formatter'.
		do
			check
						class_or_type_set: other_class /= Void or other_type_set /= Void
			end
			a_text_formatter.add_indent;
			a_text_formatter.add ("There is no feature ")
			a_text_formatter.add ({UTF_CONVERTER}.utf_8_string_8_to_string_32 (op_name))
			if other_class /= Void  then
				a_text_formatter.add (" in class ");
				other_class.append_name (a_text_formatter);
			elseif other_type_set /= Void then
				a_text_formatter.add (" in type set ");
				other_type_set.ext_append_to (a_text_formatter, class_c);
			else
				check false end
			end
			a_text_formatter.add_new_line;
		end

feature {COMPILER_EXPORTER} -- Setting

	set_other_class (o: CLASS_C)
			-- Assign `o' to `other_class'.
		do
			other_class := o
		end

	set_other_type_set (a_other_type_set: like other_type_set)
			-- Assign `a_other_type_set' to `other_type_set'.
		do
			other_type_set := a_other_type_set
		end

feature {INTERNAL_COMPILER_STRING_EXPORTER} -- Setting

	set_op_name (s: STRING)
			-- Assign `s' to `op_name'.
		do
			op_name := s;
		end;

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

end
