indexing
	description: "Table Selection page."
	author: "David S"
	date: "$Date$"
	revision: "$Revision$"

class
	DB_TABLE_SELECTION

inherit
	INTERMEDIARY_STATE_WINDOW
		redefine
			update_state_information,
			proceed_with_current_info,
			build
		end

create
	make

feature -- basic Operations

	build is
			-- Build interface 
		local
			h1: EV_HORIZONTAL_BOX
			v1: EV_VERTICAL_BOX
			lab: EV_LABEL
			txt: WIZARD_SMART_TEXT
		do 
			create selected_items
			create unselected_items
			
			create h1

			create v1
			create lab.make_with_text("To be ignored")
			v1.extend(lab)
			v1.disable_item_expand(lab)
			v1.extend(unselected_items)
			h1.extend(v1)

		
			create v1

			create add_all_b.make_with_text ("Add all ->")
			add_all_b.select_actions.extend (~add_all_items)
			v1.extend (add_all_b)
			add_all_b.set_minimum_width (25)
			add_all_b.set_minimum_height (23)
			add_all_b.align_text_center
			v1.disable_item_expand (add_all_b)
			v1.extend (create {EV_CELL})

			v1.extend (create {EV_CELL})
			create add_b.make_with_text ("Add->")
			add_b.select_actions.extend (~add_items)
			v1.extend (add_b)
			add_b.set_minimum_width (15)
			add_b.set_minimum_height (23)
			add_b.align_text_center
			v1.disable_item_expand (add_b)

			create remove_b.make_with_text ("<-Remove")
			remove_b.select_actions.extend (~remove_items)
			v1.extend (remove_b)
			remove_b.set_minimum_width (15)
			remove_b.set_minimum_height (23)
			remove_b.align_text_center
			v1.disable_item_expand (remove_b)
			v1.extend (create {EV_CELL})

			v1.extend (create {EV_CELL})
			create remove_all_b.make_with_text ("<- Remove all")
			remove_all_b.select_actions.extend (~remove_all_items)
			v1.extend (remove_all_b)
			remove_all_b.set_minimum_width (25)
			remove_all_b.set_minimum_height (23)
			remove_all_b.align_text_center
			v1.disable_item_expand (remove_all_b)

			v1.set_padding (10)
			v1.set_border_width (10)
			h1.extend(v1)


			create v1
			create lab.make_with_text("To be generated")
			v1.extend(lab)
			v1.disable_item_expand(lab)
			v1.extend(selected_items)		
			h1.extend(v1)

			unselected_items.enable_multiple_selection
			selected_items.enable_multiple_selection
			unselected_items.select_actions.extend (~enable_add_b)
			unselected_items.deselect_actions.extend (~enable_add_b)
			selected_items.select_actions.extend (~enable_remove_b)
			selected_items.deselect_actions.extend (~enable_remove_b)

			add_b.disable_sensitive
			remove_b.disable_sensitive

			choice_box.extend(h1)

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
				create it.make_with_text(wizard_information.table_list.item.table_name)
				it.set_data(wizard_information.table_list.item)
				selected_items.extend(it)				
				wizard_information.table_list.forth
			end
			from 
				wizard_information.unselected_table_list.start
			until
				wizard_information.unselected_table_list.after
			loop
				create it.make_with_text (wizard_information.unselected_table_list.item.table_name)
				it.set_data (wizard_information.unselected_table_list.item)
				unselected_items.extend (it)
				wizard_information.unselected_table_list.forth
			end
		end

	add_all_items is
			-- Add all the item from unselected_items to selected_items
		local
			it: EV_LIST_ITEM
		do
			from 
				unselected_items.start
			until
				unselected_items.after
			loop
				it := unselected_items.item
				unselected_items.prune (it)
				selected_items.extend (it)
			end
			add_b.disable_sensitive
		ensure
			unselected_items.empty
		end

	add_items is
		local
			currently_selected_items: DYNAMIC_LIST [EV_LIST_ITEM]
			it: EV_LIST_ITEM
		do
			currently_selected_items := unselected_items.selected_items
			from 
				currently_selected_items.start
			until
				currently_selected_items.after
			loop
				it := currently_selected_items.item
				unselected_items.prune (it)
				selected_items.extend (it)
				currently_selected_items.forth
			end
			add_b.disable_sensitive
		end

	remove_all_items is
			-- Remove all the item from selected_items to unselected_items
		local
			it: EV_LIST_ITEM
		do
			from 
				selected_items.start
			until
				selected_items.after
			loop
				it:= selected_items.item
				selected_items.prune (it)
				unselected_items.extend (it)
			end
			remove_b.disable_sensitive
		ensure
			selected_items.empty
		end

	remove_items is
		local
			currently_selected_items: DYNAMIC_LIST [EV_LIST_ITEM]
			it: EV_LIST_ITEM
		do
			currently_selected_items := selected_items.selected_items
			from 
				currently_selected_items.start
			until
				currently_selected_items.after
			loop
				it := currently_selected_items.item
				selected_items.prune (it)
				unselected_items.extend (it)
				currently_selected_items.forth
			end
			remove_b.disable_sensitive
		end

	enable_add_b (it: EV_LIST_ITEM) is
		do
			if unselected_items.selected_item = Void then
				add_b.disable_sensitive
			else
				add_b.enable_sensitive
			end
		end

	enable_remove_b (it: EV_LIST_ITEM) is
		do
			if selected_items.selected_item = Void then
				remove_b.disable_sensitive
			else
				remove_b.enable_sensitive
			end
		end

	proceed_with_current_info is 
			-- Process user entries
		local
			warning: EV_WARNING_DIALOG
		do 
			precursor
			proceed_with_new_state (create {DB_GENERATION_TYPE}.make(wizard_information))
		end

	update_state_information is
			-- Check user entries
		local
			li: LINKED_LIST[CLASS_NAME]
			cl_name: CLASS_NAME
		do
			from
				create li.make
				selected_items.start
			until
				selected_items.after
			loop
				cl_name ?= selected_items.item.data
				li.extend(cl_name)
				selected_items.forth
			end
			wizard_information.set_table_list(li)
			from
				create li.make
				unselected_items.start
			until
				unselected_items.after
			loop
				cl_name ?= unselected_items.item.data
				li.extend (cl_name)
				unselected_items.forth
			end
			wizard_information.set_unselected_table_list (li)
			precursor
		end

	display_state_text is
		do
			title.set_text ("STEP 2 BIS: TABLE SELECTION")
			message.set_text (" Please select which tables you wish to be%
								% able to manipulate within your project. (At least one !!)")
		end

feature -- Implementation

	selected_items, unselected_items: EV_LIST

	remove_b, add_b, remove_all_b, add_all_b: EV_BUTTON

end -- class DB_TABLE_SELECTION
