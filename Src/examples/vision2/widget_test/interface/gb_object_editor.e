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
		end
		
feature {NONE} -- Implementation

	widget_combo_box: EV_COMBO_BOX

	build_container_properties (a_container: EV_CONTAINER) is
			--
		local
			list_item: EV_LIST_ITEM
			extend_button: EV_BUTTON
		do
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
			extend (widget_combo_box)
			disable_item_expand (widget_combo_box)
			create extend_button.make_with_text ("Extend")
			extend_button.select_actions.extend (agent extend_widget (a_container))
			extend (extend_button)
			disable_item_expand (extend_button)
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
				widget ?= new_instance_of (dynamic_type_from_string (widget_combo_box.selected_item.text))
				widget.default_create
				
					-- Now assign class of `widget to `text' if `textable'
				textable ?= widget
				if textable /= Void then
					textable.set_text (type_name(widget))
				end
				container.extend (widget)
				set_type (test_widget)
		ensure
			count_increased: container.count = old container.count + 1
		end

end -- class GB_OBJECT_EDITOR
