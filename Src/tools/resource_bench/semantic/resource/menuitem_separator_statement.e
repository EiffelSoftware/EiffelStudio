indexing
	description: "xxx"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"
-- Menuitem_separator_statement -> "SEPARATOR"

class MENUITEM_SEPARATOR_STATEMENT

inherit
	S_MENUITEM_SEPARATOR_STATEMENT
		redefine 
			pre_action
		end

	TABLE_OF_SYMBOLS
		undefine
			is_equal, copy
		end

creation
	make

feature 

	pre_action is
		local
			the_item: TDS_MENU_ITEM
			menu: TDS_MENU

		do
			menu ?= tds.current_resource
			menu := menu.current_menu.item

			!! the_item.make
			the_item.set_separator
                				
			menu.insert_item (the_item)
			menu.set_current_item (the_item)
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end -- class MENUITEM_SEPARATOR_STATEMENT

