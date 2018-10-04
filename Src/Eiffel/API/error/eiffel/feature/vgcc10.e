note
	description: "Object representing an error, generic classes can't have once creation procedures"
	date: "$Date$"
	revision: "$Revision$"

class
	VGCC10
inherit

	VGCC
		redefine
			subcode,
			print_short_help,
			trace_single_line,
			build_explain
		end

create
	make_invalid_context

feature {NONE} -- Implementation

	make_invalid_context (a_feature: FEATURE_I; a_context_class, a_written_class: CLASS_C)
			-- New instance of VRVA(2) error.
		require
			a_feature_attached: a_feature /= Void
			a_context_class_attached: a_context_class /= Void
			a_written_class_attached: a_written_class /= Void
		do
			set_class (a_context_class)
			set_written_class (a_written_class)
			set_feature (a_feature)
		end


feature -- Properties

	subcode: INTEGER = 10

feature -- Output

	build_explain (a_text_formatter: TEXT_FORMATTER)
			-- Construct `a_text_formatter' with error.
		do
		end

feature {NONE} -- Output

	print_short_help (t: TEXT_FORMATTER)
			-- <Precursor>
		do
			t.add_new_line
			format_elements (t, locale.translation_in_context ("[
						Generic class cannot have a once procedure {1}.
						What to do: either make the class non-generic, or do not use once creation procedures..
					]", "compiler.error"),
				<<agent e_feature.append_name>>)
			t.add_new_line
			t.add_new_line
		end

	trace_single_line (t: TEXT_FORMATTER)
			-- <Precursor>
		do
			format_elements (t, locale.translation_in_context
				("Generic class cannot have a once procedure {1}.", "compiler.error"),
				<<agent e_feature.append_name>>)
		end



note
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
