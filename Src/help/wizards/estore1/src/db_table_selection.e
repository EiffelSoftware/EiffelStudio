indexing
	description: "Table Selection page."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	DB_TABLE_SELECTION

inherit
	WIZARD_STATE_WINDOW
		redefine
			update_state_information,
			proceed_with_current_info
		end

creation
	make

feature -- basic Operations

	display is 
			-- Display user entries
		do
			build
		end

	build is
			-- Build interface 
		local
			h1: EV_HORIZONTAL_BOX
			v1: EV_VERTICAL_BOX
			lab: EV_LABEL
			txt: WIZARD_SMART_TEXT
		do 
			Create selected_items
			Create unselected_items
			selected_items.select_actions.extend(~unselect_item)
			unselected_items.select_actions.extend(~select_item)

			Create txt.make(main_box)
			txt.add_line(" ")
			txt.add_line("  Please select which columns you wish")
			txt.add_line("  to be able to manipulate within your")
			txt.add_line("  project.")

			Create h1
			Create v1
			h1.extend(v1)
			Create lab.make_with_text("To be generated")
			v1.extend(lab)
			v1.disable_child_expand(lab)
			v1.extend(selected_items)		
			
			Create v1
			h1.extend(v1)
			Create lab.make_with_text("To be ignored")
			v1.extend(lab)
			v1.disable_child_expand(lab)
			v1.extend(unselected_items)
			
			main_box.extend(h1)
			fill_lists
		end

	fill_lists is
			-- Fill the list with table names.
		local
			it: EV_LIST_ITEM
		do
			from
				wizard_information.table_list.start
			until
				wizard_information.table_list.after
			loop
				Create it.make_with_text(wizard_information.table_list.item.table_name)
				it.set_data(wizard_information.table_list.item)
				selected_items.extend(it)				
				wizard_information.table_list.forth
			end
		end

	unselect_item(it: EV_LIST_ITEM) is
		do
			selected_items.prune(it)
			unselected_items.extend(it)
		end

	select_item(it: EV_LIST_ITEM) is
		do
			unselected_items.prune(it)
			selected_items.extend(it)
		end

	proceed_with_current_info is 
			-- Process user entries
		do 
			precursor
			proceed_with_new_state(Create {DB_GENERATION_TYPE}.make(wizard_information))
		end

	update_state_information is
			-- Check user entries
		local
			li: LINKED_LIST[CLASS_NAME]
			cl_name: CLASS_NAME
		do
			from
				Create li.make
				selected_items.start
			until
				selected_items.after
			loop
				cl_name ?= selected_items.item.data
				li.extend(cl_name)
				selected_items.forth
			end
			wizard_information.set_table_list(li)
			precursor
		end

feature -- Implementation

	selected_items, unselected_items: EV_LIST

	pixmap_location: STRING is "essai.bmp";
			-- Pixmap location

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
end -- class DB_TABLE_SELECTION
