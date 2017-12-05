note

	description: "Features with different instance-free status cannot be joined."

class VDJR4_NEW

inherit
	VDJR_NEW
		redefine
			print_error_message,
			print_single_line_error_message
		end

create {COMPILER_EXPORTER}

	make

feature -- Access

	subcode: INTEGER = 4
			-- <Precursor>

feature {NONE} -- Output

	print_error_message (t: TEXT_FORMATTER)
			-- <Precursor>
		do
			print_error_code (t)
			t.add_new_line
			format_elements (t, locale.translation_in_context
					({STRING_32} "[
						Joined features {1} and {2} have different instance-free status.
						
						What to do:
							• make sure both features have the same instance-free status or
							• avoid joining them.
					]",
					"eiffel.error"),
				<<agent feature_1.append_name, agent feature_2.append_name>>
			)
				-- Make sure any other information about the error comes at a new line.
			t.add_new_line
			t.add_new_line
		end

	print_single_line_error_message (t: TEXT_FORMATTER)
			-- <Precursor>
		do
			format_elements (t, locale.translation_in_context
					("Joined features {1} and {2} are not both instance-free.",
					"eiffel.error"),
				<<agent feature_1.append_name, agent feature_2.append_name>>)
		end

note
	date: "$Date$";
	revision: "$Revision$"
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
