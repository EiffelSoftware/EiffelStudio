indexing
	description: "Table Selection page."
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
				state_information.table_list.start
			until
				state_information.table_list.after
			loop
				Create it.make_with_text(state_information.table_list.item.table_name)
				it.set_data(state_information.table_list.item)
				selected_items.extend(it)				
				state_information.table_list.forth
			end
		end

	unselect_item(i: INTEGER;it: EV_LIST_ITEM) is
		do
			selected_items.prune(it)
			unselected_items.extend(it)
		end

	select_item(i: INTEGER;it: EV_LIST_ITEM) is
		do
			unselected_items.prune(it)
			selected_items.extend(it)
		end

	proceed_with_current_info is 
			-- Process user entries
		do 
			precursor
			proceed_with_new_state(Create {DB_GENERATION_TYPE}.make(state_information))
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
			state_information.set_table_list(li)
			precursor
		end

feature -- Implementation

	selected_items, unselected_items: EV_LIST

	pixmap_location: STRING is "essai.bmp"
			-- Pixmap location

end -- class DB_TABLE_SELECTION
