note

	description: "[
			Error when a class with an instance-free feature is not compiled
			with full class checking option.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class VD02

inherit

	FEATURE_ERROR
		redefine
			print_short_help,
			trace_single_line
		end

create
	make

feature {NONE} -- Creation

	make (f: FEATURE_I; c, w: CLASS_C; l: LOCATION_AS)
			-- Create an error for feature `f` from class `c` called in class `w` at location `l`.
		do
			class_c := c
			written_class := w
			set_feature (f)
			set_location (l)
		ensure
			class_c_set: class_c = c
			written_class_set: written_class = w
			feature_set: attached e_feature
			line_set: line = l.line
			column_set: column = l.column
		end

feature -- Properties

	code: STRING = "VD02"
			-- <Precursor>

feature {NONE} -- Output

	print_short_help (t: TEXT_FORMATTER)
			-- <Precursor>
		do
			t.add_new_line
			t.add (locale.translation_in_context ("[
				Error: A class with a feature used in a non-object call should be compiled with an option "Full class checking".
				What to do: Enable the option "Full class checking" in the project settings or remove the non-object call to the feature.
			]", "compiler.error"))
			t.add_new_line
		end

	trace_single_line (t: TEXT_FORMATTER)
			-- <Precursor>
		do
			format_elements (t, locale.translation_in_context
				("Full class checking is required for class {1} with feature {2} used in a non-object call.", "compiler.error"),
				<<agent class_c.append_name, agent e_feature.append_name>>)
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
