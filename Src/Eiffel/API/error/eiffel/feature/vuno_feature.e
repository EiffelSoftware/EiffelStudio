note
	description: "Error when a non-object call uses a feature that does not satisfy the requirements of the validity rule."

class VUNO_FEATURE

inherit
	VUNO
		rename
			make as make_vuno
		end

create
	make

feature {NONE} -- Creation

	make (t: FEATURE_I; f: FEATURE_I; c: CLASS_C; w: detachable CLASS_C; l: LOCATION_AS)
			-- Create an error for a non-object call to a feature `t` in feature `f` of class `c` in the code from class `w` at location `l`.
		require
			t_attached: attached t
			f_attached: attached f
			c_attached: attached c
			l_attached: attached l
		do
			make_vuno (f, c, w, l)
			callee := t.e_feature
		ensure
			callee_set: attached callee
			class_c_set: class_c = c
			written_class_set: attached written_class and (attached w implies written_class = w)
			feature_set: attached e_feature
			line_set: line = l.line
			column_set: column = l.column
		end

feature {NONE} -- Access

	callee: E_FEATURE
			-- A feature of the call.

feature {NONE} -- Output

	print_short_help (t: TEXT_FORMATTER)
			-- <Precursor>
		do
			t.add_new_line
			format_elements (t, locale.translation_in_context ("[
						{1} used in the non-object call is not a class feature.
						
						What to do: Make sure the non-object call uses a class feature or replace it with an object call.
					]", "compiler.error"),
				<<agent callee.append_name>>)
			t.add_new_line
			t.add_new_line
		end

	trace_single_line (t: TEXT_FORMATTER)
			-- <Precursor>
		do
			format_elements (t, locale.translation_in_context
				("Feature {1} cannot be used in a non-object call.", "compiler.error"),
				<<agent callee.append_name>>)
		end

note
	ca_ignore: "CA011", "CA011 – too many arguments"
	date: "$Date$"
	revision: "$Revision$"
	copyright:	"Copyright (c) 1984-2018, Eiffel Software"
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
