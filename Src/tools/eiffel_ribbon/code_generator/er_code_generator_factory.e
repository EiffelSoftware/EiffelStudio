note
	description: "[
					Code generater and tree manager factory for different generating modes:
					Application Modes or DLL
						]"
	date: "$Date$"
	revision: "$Revision$"

class
	ER_CODE_GENERATOR_FACTORY

feature -- factory method

	code_generator: ER_COMMON_CODE_GENERATOR
			-- Code generator factory method
		local
			l_misc: ER_MISC_CONSTANTS
		do
			create l_misc
			if l_misc.is_using_application_mode.item then
				create {ER_CODE_GENERATOR_AM} Result.make
			else
				create {ER_CODE_GENERATOR} Result.make
			end
		end

	tree_manager: ER_LAYOUT_CONSTRUCTOR_TREE_MANAGER
			-- Tree manager factory method
		local
			l_misc: ER_MISC_CONSTANTS
		do
			create l_misc
			if l_misc.is_using_application_mode.item then
				create {ER_LAYOUT_CONSTRUCTOR_TREE_MANAGER_AM} Result.make
			else
				create {ER_LAYOUT_CONSTRUCTOR_TREE_MANAGER_DLL} Result.make
			end
		end

note
	copyright: "Copyright (c) 1984-2011, Eiffel Software"
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
