note
	description: "Category identifiers for various parts of the EiffelStudio ecosystem."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	ENVIRONMENT_CATEGORIES

feature -- Access

	none: NATURAL_8 = 0
			-- Unknown category.

	internal_event: NATURAL_8 = 1
			-- An internal event.

	compilation: NATURAL_8 = 2
			-- A compilation/build.

	debugger: NATURAL_8 = 3
			-- Eiffel debugger.

	editor: NATURAL_8 = 4
			-- Text editor.

	refactoring: NATURAL_8 = 5
			-- Refactoring engine.

	testing: NATURAL_8 = 6
			-- Testing related.

	static_analysis: NATURAL_8 = 7
			-- Static analyzer.

	tools: NATURAL_8 = 8
			-- tools related.

	cloud: NATURAL_8 = 9
			-- Cloud related.

feature -- Query

	is_valid_category (a_cat: NATURAL_8): BOOLEAN
			-- Determines if `a_cat' is a valid environment category
			--
			-- `a_cat': A category identifier to validate
			-- `Result': True to indicate the category is valid; False otherwise.
		do
			inspect a_cat
			when
				none,
				internal_event,
				compilation,
				debugger,
				editor,
				refactoring,
				testing,
				static_analysis,
				tools,
				cloud
			then
				Result := True
			else
					-- False here.
			end
		end

;note
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
