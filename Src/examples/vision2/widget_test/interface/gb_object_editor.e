indexing
	description: "Widget test version of GB_OBJECT_EDITOR%
		%necessary for compilation and building purposes."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_OBJECT_EDITOR

inherit
	
	WIDGET_TEST_SHARED
		undefine
			copy, is_equal, default_create
		end
	
	SUPPORTED_TYPES
		undefine
			copy, is_equal, default_create
		end

	EV_VERTICAL_BOX
		export
			{NONE} all
			{ANY} destroy, parent, is_destroyed
		redefine
			initialize
		end
		
feature {NONE} -- Initialization

	initialize is
			-- Initialize `Current'.
		do
			Precursor {EV_VERTICAL_BOX}
			register_type_change_agent (agent set_type (?))
		end

feature -- Status Setting
		
	set_type (widget: EV_WIDGET) is
			-- Set up editor for widget of type `widget'.
		local
			current_type: STRING
			common_editor: GB_COMMON_EDITOR
			container: EV_CONTAINER
			list: EV_LIST
		do
			wipe_out
			from
				supported_types.start
			until
				supported_types.off
			loop
				current_type := supported_types.item
				current_type.to_upper
				if is_instance_of (widget, dynamic_type_from_string (current_type.substring (4, current_type.count))) then
					common_editor ?= new_instance_of (dynamic_type_from_string (current_type))
					common_editor.default_create
					common_editor.set_object (widget)
					common_editor.set_parent_editor (Current)
					extend (common_editor.attribute_editor)
				end
				supported_types.forth
			end
			if is_instance_of (widget, dynamic_type_from_string ("EV_CONTAINER")) then
				container ?= widget
				check
					widget_is_container: container /= Void
				end
				build_container_properties (container)
			end
			if is_instance_of (widget, dynamic_type_from_string ("EV_LIST")) then
				list ?= widget
				check
					widget_is_list: list /= Void
				end
				build_list_properties (list)
			end
		end
		
feature {NONE} -- Implementation

	list_item_text: EV_TEXT_FIELD

	build_list_properties (a_list: EV_LIST) is
			-- Build properties specific to EV_LIST.
		require
			list_not_void: a_list /= Void
		do
			create frame.make_with_text (frame_text)
			extend (frame)
			disable_item_expand (frame)
			create vertical_box
			frame.extend (vertical_box)
			vertical_box.set_padding_width (padding_value)
			vertical_box.set_border_width (padding_value)
			create list_item_text.make_with_text ("Item")
			list_item_text.change_actions.extend (agent update_list_extend_button)
			vertical_box.extend (list_item_text)
			create extend_button.make_with_text ("Extend")
			extend_button.select_actions.extend (agent extend_list_item (a_list))
			vertical_box.extend (extend_button)
			create wipe_out_button.make_with_text ("Wipe_out")
			wipe_out_button.select_actions.extend (agent a_list.wipe_out)
			vertical_box.extend (wipe_out_button)
		end
	
	extend_button: EV_BUTTON
	frame: EV_FRAME
	vertical_box: EV_VERTICAL_BOX
	wipe_out_button: EV_BUTTON
	
	update_list_extend_button is
			-- Udpate `extend_button'.
		do
			if list_item_text.text.is_empty then
				extend_button.disable_sensitive
			elseif not extend_button.is_sensitive then
				extend_button.enable_sensitive
			end	
		end
		
		
	extend_list_item (list: EV_LIST) is
			-- Add a new list item to `list' with `text'
			-- corresponding to `text' of `list_item_text'.
		require
			list_not_void: list /= Void
		local
			list_item: EV_LIST_ITEM
		do
			create list_item.make_with_text (list_item_text.text)
			list.extend (list_item)
		ensure
			count_increased: list.count = old list.count + 1
		end

	widget_combo_box: EV_COMBO_BOX

	build_container_properties (a_container: EV_CONTAINER) is
			-- Build properties specific to EV_CONTAINER.
		require
			container_not_void: a_container /= Void
		local
			list_item: EV_LIST_ITEM
		do
			create frame.make_with_text (frame_text)
			extend (frame)
			create vertical_box
			vertical_box.set_padding_width (padding_value)
			vertical_box.set_border_width (padding_value)
			frame.extend (vertical_box)
			disable_item_expand (frame)
			create widget_combo_box
			from
				extendible_types.start
			until
				extendible_types.off
			loop
				create list_item.make_with_text (extendible_types.item)
				widget_combo_box.extend (list_item)
				extendible_types.forth
			end
			vertical_box.extend (widget_combo_box)
			create extend_button.make_with_text ("Extend")
			extend_button.select_actions.extend (agent extend_widget (a_container))
			vertical_box.extend (extend_button)
			create wipe_out_button.make_with_text ("Wipe_out")
			wipe_out_button.select_actions.extend (agent a_container.wipe_out)
			vertical_box.extend (wipe_out_button)
		end
		
	extend_widget (container: EV_CONTAINER) is
			-- Add new widget corresponding to `text' of `selected_item' in
			-- `widget_combo_box' to `container'.
		require
			container_not_void: container /= Void
		local
			widget: EV_WIDGET
			textable: EV_TEXTABLE
		do
			if not container.full then
				widget ?= new_instance_of (dynamic_type_from_string (widget_combo_box.selected_item.text))
				widget.default_create
				
					-- Now assign class of `widget to `text' if `textable'
				textable ?= widget
				if textable /= Void then
					textable.set_text (type_name(widget))
				end
				container.extend (widget)
				set_type (test_widget)
			end
		ensure
			count_increased: container.count = old container.count + 1
		end
		
	frame_text: STRING is "Insertion/Removal"
	
	padding_value: INTEGER is 5

end -- class GB_OBJECT_EDITOR
