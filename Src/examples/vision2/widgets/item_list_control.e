indexing
	description: "Controls used to modify objects of type EV_ITEM_LIST[EV_ITEM]"
	date: "$Date$"
	revision: "$Revision$"

class
	ITEM_LIST_CONTROL
	
inherit
	EV_FRAME

create
	make

feature {NONE} -- Initialization

	make (box: EV_BOX; an_item_list: EV_ITEM_LIST [EV_ITEM]; output: EV_TEXT) is
			-- Create controls to manipulate `an_item_list', parented in `box' and
			-- displaying output in `output'.
		do
			default_create
			set_text ("EV_ITEM_LIST")
			item_list := an_item_list
			create vertical_box
			extend (vertical_box)
			create extend_button.make_with_text ("Extend")
			extend_button.select_actions.extend (agent extend_container)
			vertical_box.extend (extend_button)
			create button.make_with_text ("Wipe_out")
			button.select_actions.extend (agent item_list.wipe_out)
			button.select_actions.extend (agent update_information)
			vertical_box.extend (button)

			create full_label
			vertical_box.extend (full_label)
			create is_empty_label
			vertical_box.extend (is_empty_label)
			create extendible_label
			vertical_box.extend (extendible_label)
			create count_label
			vertical_box.extend (count_label)
			
			update_information
			box.extend (Current)
		end
		
feature {NONE} -- Implementation
		
	new_multi_column_list_row: EV_MULTI_COLUMN_LIST_ROW is
			-- A new instance of a multi column list row.
		do
			create Result
			Result.extend ("Row " + item_list.count.out + " Column 1")
			Result.extend ("Column 2")
			Result.extend ("Column 3")
		end
		
	new_tool_bar_item: EV_TOOL_BAR_BUTTON is
			-- A new instance of a tool bar button.
		do
			create Result.make_with_text ("Button " + item_list.count.out)
		end
		
	new_tree_item: EV_TREE_ITEM is
			-- A new instance of a tree item.
		local
			tree_item: EV_TREE_ITEM
			counter : INTEGER
		do
			create Result.make_with_text ("Item " + item_list.count.out)
			from counter := 0
			until
				counter = 8
			loop
				create tree_item.make_with_text ("Tree sub item " + counter.out)
				Result.extend (tree_item)
				counter := counter + 1
			end
		end

	multi_column_list: EV_MULTI_COLUMN_LIST is
			-- An `item_list' if an EV_MULTI_COLUMN_LIST.
			-- Void otherwise
		do
			Result ?= item_list
		end
		
	new_list_item: EV_LIST_ITEM is
			-- A new instance of an EV_LIST_ITEM.
		do
			create Result.make_with_text ("List item " + item_list.count.out)
		end
	
	list: EV_LIST is
			-- An `item_list' if an EV_LIST.
		do
			Result ?= item_list
		end
		
	combo_box: EV_COMBO_BOX is
			-- An `item_list' if an EV_COMBO_BOX.
		do
			Result ?= item_list
		end
		
	tool_bar: EV_TOOL_BAR is
			-- An `item_list' if an EV_TOOL_BAR.
		do
			Result ?= item_list
		end
		
	tree: EV_TREE is
			-- An `item_list' if an EV_TREE.
		do
			Result ?= item_list
		end

	extend_container is
			-- extend `new_child' into `container'.
		do
			if multi_column_list /= Void then
				multi_column_list.extend (new_multi_column_list_row)
			end
			if list /= void then
				list.extend (new_list_item)
			end
			if combo_box /= Void then
				combo_box.extend (new_list_item)
			end
			if tool_bar /= Void then
				tool_bar.extend (new_tool_bar_item)
			end
			if tree /= Void then
				tree.extend (new_tree_item)
			end
			update_information
		end
		
	update_information is
			-- Update queries about item lists.
		do
			if item_list.is_empty then
				is_empty_label.set_text ("is_empty: True")
			else
				is_empty_label.set_text ("is_empty: False")
			end
			if item_list.full then
				full_label.set_text ("full: True")
			else
				full_label.set_text ("full: False")
			end
			if item_list.extendible then
				extendible_label.set_text ("extendible: True")
				extend_button.enable_sensitive
			else
				extendible_label.set_text ("extendible: False")
				extend_button.disable_sensitive
			end
			count_label.set_text ("count : " + item_list.count.out)
		end


		-- Widgets used to create controls.
	vertical_box: EV_VERTICAL_BOX
	extend_button, button: EV_BUTTON
	new_child: EV_BUTTON
	item_list: EV_ITEM_LIST [EV_ITEM]
	horizontal_box: EV_HORIZONTAL_BOX
	full_label: EV_LABEL
	is_empty_label: EV_LABEL
	extendible_label: EV_LABEL
	count_label: EV_LABEL
	
end -- class GAUGE_CONTROL
