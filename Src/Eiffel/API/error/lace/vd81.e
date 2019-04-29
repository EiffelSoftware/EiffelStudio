note
	description: "A warning about using an option that disables total order on reals."

class
	VD81

inherit
	LACE_WARNING
		redefine
			code,
			help_uuid,
			print_short_help,
			trace_single_line
		end

create
	make

feature {NONE} -- Creation

	make (t: CONF_TARGET)
			-- Initialize the warning for the target `t`.
		do
			target := t
		ensure
			target = t
		end

feature -- Access

	code: like {WARNING}.code = "VD81"
			-- <Precursor>

	target: CONF_TARGET
			-- Associated target.

feature -- Help

	help_uuid: READABLE_STRING_32
			-- <Precursor>
		do
			Result := "996CC0DA-B3E9-4555-A121-BAB15C9BEC81"
		end

feature -- Output

	build_explain (t: TEXT_FORMATTER)
			-- <Precursor>
		do
		end

	print_short_help (t: TEXT_FORMATTER)
			-- <Precursor>
		do
			t.add_new_line
			format_elements (t,
				locale.translation_in_context ("[
					Non-total order on real numbers specified for the target '{1}' is now obsolete.
					Consider changing the setting to "True" and use features with the names starting from "ieee" of the classes REAL_32 and REAL_64 if needed.
					
					How to change the setting?
						1. Open the project settings dialog: Project | Project Settings...
						2. For every affected target navigate to Target | Advanced.
						3. In the section "Language" in the pane on the right, set the value of the setting "Total Order on REALs" to "True".
				]", "compiler.warning"),
				<<agent {TEXT_FORMATTER}.process_target_name_text (target.name, target)>>)
			t.add_new_line
		end

	trace_single_line (t: TEXT_FORMATTER)
			-- <Precursor>
		do
			t.add (locale.translation_in_context ("Non-total order on reals is obsolete.", "compiler.warning"))
		end

note
	date: "$Date$"
	revision: "$Revision$"
	author: "Alexander Kogtenkov"
	copyright:	"Copyright (c) 1984-2019, Eiffel Software"
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
