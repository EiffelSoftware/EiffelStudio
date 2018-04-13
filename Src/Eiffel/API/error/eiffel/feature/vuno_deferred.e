note
	description: "Error when a non-object call has a target type with a deferred base class."

class VUNO_DEFERRED

inherit
	VUNO
		rename
			make as make_vuno
		end

create
	make

feature {NONE} -- Creation

	make (t: CLASS_C; f: FEATURE_I; c: CLASS_C; w: detachable CLASS_C; l: LOCATION_AS)
			-- Create an error for a non-object call on a deferred type with the base class `t` in feature `f` of class `c` in the code from class `w` at location `l`.
		require
			t_attached: attached t
			t_deferred: t.is_deferred
			f_attached: attached f
			c_attached: attached c
			l_attached: attached l
		do
			make_vuno (f, c, w, l)
			target_class := t
		ensure
			target_class_set: target_class = t
			class_c_set: class_c = c
			written_class_set: attached written_class and (attached w implies written_class = w)
			feature_set: attached e_feature
			line_set: line = l.line
			column_set: column = l.column
		end

feature {NONE} -- Access

	target_class: CLASS_C
			-- A deferred target class.

feature {NONE} -- Output

	print_short_help (t: TEXT_FORMATTER)
			-- <Precursor>
		do
			t.add_new_line
			format_elements (t, locale.translation_in_context ("[
						The non-object call uses a target type with a deferred base class {1}.
						
						What to do: Make sure the target type of the non-object call is an effective class type.
					]", "compiler.error"),
				<<agent target_class.append_name>>)
			t.add_new_line
			t.add_new_line
		end

	trace_single_line (t: TEXT_FORMATTER)
			-- <Precursor>
		do
			format_elements (t, locale.translation_in_context
				("Non-object call on a type with a deferred base class {1}.", "compiler.error"),
				<<agent target_class.append_name>>)
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
