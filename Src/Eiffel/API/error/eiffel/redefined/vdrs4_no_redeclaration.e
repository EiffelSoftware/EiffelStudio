note
	description: "An error for redefinition without redeclaration."
	author: "Alexander Kogtenkov"

class
	VDRS4_NO_REDECLARATION

inherit
	VDRS4

create
	make

feature {COMPILER_ERROR_VISITOR} -- Visitor

	process_issue (v: COMPILER_ERROR_VISITOR)
			-- <Precursor>
		do
			v.process_redefinition_without_redeclaration (Current)
		end

feature {NONE} -- Output

	print_single_line_error_message (t: TEXT_FORMATTER)
			-- <Precursor>
		do
			format_elements
				(t,
				locale.translation_in_context ({STRING_32} "Redefine subclause lists feature {1}, but the class does not declare it.", once "compiler.error"),
				<<agent {TEXT_FORMATTER}.add_feature_name (feature_name, class_c)>>)
		end

note
	date: "$Date$"
	revision: "$Revision$"
	author: "Alexander Kogtenkov"
	copyright: "Copyright (c) 1984-2018, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
