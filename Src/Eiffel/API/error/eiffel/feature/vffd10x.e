note

	description: "Error for a declaration of an instance-free object-relative once."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class VFFD10X

inherit

	FEATURE_ERROR
		redefine
			print_short_help,
			trace_single_line
		end

	INTERNAL_COMPILER_STRING_EXPORTER
	SHARED_NAMES_HEAP

create
	make

feature {NONE} -- Creation

	make (f: FEATURE_I; c: CLASS_C; l: LOCATION_AS)
			-- Create an error for a feature `f` in class `c`.
		require
			f_attached: attached f
			c_attached: attached c
			l_attached: attached l
		do
			class_c := c
			set_feature (f)
			set_location (l)
		ensure
			class_c_set: class_c = c
			e_feature_set: attached e_feature
			line_set: line = l.line
			column_set: column = l.column
		end

feature -- Properties

	code: STRING = "VFFD10x"
			-- Error code

feature {NONE} -- Output

	print_short_help (t: TEXT_FORMATTER)
			-- <Precursor>
		do
			t.add_new_line
			t.add (locale.translation_in_context ("[
				Error: An object-relative once feature cannot be declared as instance-free.
				What to do: Remove the value "instance_free" from the note tag "option" or remove the key "OBJECT" from the list of once keys.
			]", "compiler.error"))
			t.add_new_line
		end

	trace_single_line (t: TEXT_FORMATTER)
			-- <Precursor>
		do
			format_elements (t, locale.translation_in_context ("The object-relative once feature {1} is declared as instance-free.", "compiler.error"),
				<<agent e_feature.append_name>>)
		end

note
	copyright:	"Copyright (c) 1984-2017, Eiffel Software"
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
