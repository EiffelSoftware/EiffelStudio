indexing
	description: "Builds an attribute editor for modification of objects of type EV_BOX."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_EV_BOX_EDITOR_CONSTRUCTOR

inherit
	GB_EV_EDITOR_CONSTRUCTOR
		undefine
			default_create
		end
	
	INTERNAL
		undefine
			default_create
		end
		
feature -- Access

	ev_type: EV_BOX
		-- Vision2 type represented by `Current'.
		
	type: STRING is "EV_BOX"
		-- String representation of object_type modifyable by `Current'.
		
	attribute_editor: GB_OBJECT_EDITOR_ITEM is
			-- A vision2 component to enable modification
			-- of items held in `objects'.
		local
			label: EV_LABEL
			second: like ev_type
			check_button: EV_CHECK_BUTTON
		do
			create check_buttons.make (0)
			create Result
			initialize_attribute_editor (result)
				-- We need the child of the display objects here,
				-- not the actual object itself.
			second := objects @ (2).item
			
			create is_homogeneous_check.make_with_text ("Is_homogeneous?")
			Result.extend (is_homogeneous_check)
			is_homogeneous_check.select_actions.extend (agent update_homogeneous)
			is_homogeneous_check.select_actions.extend (agent update_editors)
			
			create padding_entry.make (Current, Result, gb_ev_box_padding_width, gb_ev_box_padding_width_tooltip,
				agent set_padding (?), agent valid_input (?))
			create border_entry.make (Current, Result, gb_ev_box_border_width, gb_ev_box_border_width_tooltip,
				agent set_border (?), agent valid_input (?))

				-- We only add the is_expandable label if there are children
			if not first.is_empty then
				create label.make_with_text ("Is_item_expanded?")
				Result.extend (label)			
			end		
			from
				first.start
				second.start
			until
				first.off or second.off
			loop
				create check_button.make_with_text (class_name (first.item))
				check_button.set_pebble_function (agent retrieve_pebble (parent_editor.object.layout_item, first.index))
				check_buttons.force (check_button)
				check_button.select_actions.extend (agent update_widget_expanded (check_button, first.item))
				check_button.select_actions.extend (agent update_widget_expanded (check_button, second.item))
				check_button.select_actions.extend (agent update_editors)
				Result.extend (check_button)
				first.forth
				second.forth
			end
			
			update_attribute_editor

			disable_all_items (Result)
			align_labels_left (Result)
		end
		
	retrieve_pebble (a_layout_item: GB_LAYOUT_CONSTRUCTOR_ITEM; child_index: INTEGER): ANY is
			-- Retrieve pebble for transport.
			-- A convenient was of setting up the drop
			-- actions for GB_OBJECT.
		local
			object: GB_OBJECT
			layout_item: GB_LAYOUT_CONSTRUCTOR_ITEM
			shared_tools: GB_SHARED_TOOLS
		do
			layout_item ?= a_layout_item.i_th (child_index)
			check
				layout_item_not_void: layout_item /= Void
			end
			object := layout_item.object
			
			--| FIXME This is currently identical to version in 
			--| GB_OBJECT
				-- If the ctrl key is pressed, then we must
				-- start a new object editor for `Current', instead
				-- of beginning the pick and drop.
			if application.ctrl_pressed then
				new_object_editor (object)
			else
				create shared_tools
				shared_tools.type_selector.update_drop_actions_for_all_children (object)
				Result := object
			end
		end
		
	update_attribute_editor is
			-- Update status of `attribute_editor' to reflect information
			-- from `objects.first'.
		do
			check
				counts_match: first.count = check_buttons.count
			end
			is_homogeneous_check.select_actions.block

			if first.is_homogeneous then
				is_homogeneous_check.enable_select
			else
				is_homogeneous_check.disable_select
			end
			border_entry.set_text (first.border_width.out)
			padding_entry.set_text (first.padding_width.out)
			
			from
				check_buttons.start
			until
				check_buttons.off
			loop
				check_buttons.item.select_actions.block
				if first.is_item_expanded (first @ check_buttons.index) then
					check_buttons.item.enable_select
				else
					check_buttons.item.disable_select
				end
				check_buttons.item.select_actions.resume
				check_buttons.forth
			end			
			is_homogeneous_check.select_actions.resume
		end

	update_widget_expanded (check_button: EV_CHECK_BUTTON; w: EV_WIDGET) is
			-- Change the expanded status of `w'.
		local
			box_parent: EV_BOX
		do
			box_parent ?= w.parent
			check
				parent_is_box: box_parent /= Void
			end
			if check_button.is_selected then
				box_parent.enable_item_expand (w)
			else
				box_parent.disable_item_expand (w)
			end
			enable_project_modified
		end
		
feature {NONE} -- Implementation

	update_homogeneous is
			-- Update homogeneous state of items in `objects' depending on
			-- state of `is_homogeneous_check'.
		do
			if is_homogeneous_check.is_selected then
				for_all_objects (agent {EV_BOX}.enable_homogeneous)
			else
				for_all_objects (agent {EV_BOX}.disable_homogeneous)
			end
		end

	set_padding (value: INTEGER) is
			-- Update property `padding' on all items in `objects'.
		require
			first_not_void: first /= Void
		do
			for_all_objects (agent {EV_BOX}.set_padding_width (value))
		end
		
	valid_input (value: INTEGER): BOOLEAN is
			-- Is `value' a valid padding?
		do
			Result := value >= 0
		end
		
	set_border (value: INTEGER) is
			-- Update property `border' on all items in `objects'.
		require
			first_not_void: first /= Void
		do
			for_all_objects (agent {EV_BOX}.set_border_width (value))
		end
		
	is_homogeneous_check: EV_CHECK_BUTTON

	border_entry, padding_entry: GB_INTEGER_INPUT_FIELD
	
	Is_homogeneous_string: STRING is "Is_homogeneous"
	Padding_string: STRING is "Padding"
	Border_string: STRING is "Border"
	Is_item_expanded_string: STRING is "Is_item_expanded"
	
	check_buttons: ARRAYED_LIST [EV_CHECK_BUTTON]
		-- All check buttons created to handle `disable_item_expand'.
		
end -- class GB_EV_BOX_EDITOR_CONSTRUCTOR
