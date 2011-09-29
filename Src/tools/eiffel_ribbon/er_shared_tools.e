note
	description: "[
					Shared singletons in EiffelRibbon tool
				]"
	date: "$Date$"
	revision: "$Revision$"

class
	ER_SHARED_TOOLS

feature -- Query

	object_editor_cell: CELL [detachable ER_OBJECT_EDITOR]
			-- Object editor singleton
		once
			create Result.put (void)
		end

	layout_constructor_list: ARRAYED_LIST [ER_LAYOUT_CONSTRUCTOR]
			-- Layout constructor list
		once
			create Result.make (10)
		end

	project_info_cell: CELL [detachable ER_PROJECT_INFO]
			-- Project info singleton
		once
			create Result.put (void)
		end

	tool_info_cell: CELL [detachable ER_TOOL_INFO]
			-- Tool info singleton
		once
			create Result.put (void)
		end

	size_definition_cell: CELL [detachable ER_SIZE_DEFINITION_EDITOR]
			-- Size definition editor tool singleton
		once
			create Result.put (void)
		end

	main_window_cell: CELL [detachable ER_MAIN_WINDOW]
			-- Main window singleton cell
		once ("PROCESS")
			create Result.put (void)
		end

	xml_tree_manager: CELL [ER_XML_TREE_MANAGER]
			-- XML tree manager singleton cell
		local
			l_manger: ER_XML_TREE_MANAGER
		once
			create l_manger
			create Result.put (l_manger)
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
