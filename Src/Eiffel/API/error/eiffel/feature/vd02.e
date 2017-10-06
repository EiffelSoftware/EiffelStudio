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

	make (f: FEATURE_I; c: CLASS_C)
			-- Create an error for feature `f` in class `c`.
		do
			class_c := c
			written_class := f.written_class
			set_feature (f)
		ensure
			class_c_set: class_c = c
			written_class_set: attached written_class
			feature_set: attached e_feature
		end

feature -- Properties

	code: STRING = "VD02"
			-- Error code

feature {NONE} -- Output

	print_short_help (t: TEXT_FORMATTER)
			-- <Precursor>
		do
			t.add_new_line
			t.add (locale.translation_in_context ("[
				Error: A class with an instance-free feature should should be compiled with an option "full class checking".
				What to do: Enable the option "full class checking" in the project settings or make sure there are no instance-free features in the class.
			]", "compiler.error"))
		end

	trace_single_line (t: TEXT_FORMATTER)
			-- <Precursor>
		do
			format_elements (t, locale.translation_in_context ("The class with the instance-free feature {1} should be compiled with full class checking.", "compiler.error"), <<agent e_feature.append_name>>)
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
