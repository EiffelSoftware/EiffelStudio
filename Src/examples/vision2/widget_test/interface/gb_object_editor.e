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
			tree: EV_TREE
			combo_box: EV_COMBO_BOX
			tool_bar: EV_TOOL_BAR
			multi_column_list: EV_MULTI_COLUMN_LIST
			list_extendible_controls: LIST_EXTENDIBLE_CONTROLS
			tree_extendible_controls: TREE_EXTENDIBLE_CONTROLS
			multi_column_list_extendible_controls: MULTI_COLUMN_LIST_EXTENDIBLE_CONTROLS
			combo_box_extendible_controls: COMBO_BOX_EXTENDIBLE_CONTROLS
			tool_bar_extendible_controls: TOOL_BAR_EXTENDIBLE_CONTROLS
			container_extendible_controls: CONTAINER_EXTENDIBLE_CONTROLS
			current_parent: EV_CONTAINER
		do
			current_parent := parent
			current_parent.prune (Current)
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
			if is_instance_of (widget, dynamic_type_from_string ("EV_LIST")) then
				list ?= widget
				check
					widget_is_list: list /= Void
				end
				create list_extendible_controls.make_with_text_control (list)
				extend (list_extendible_controls)
			end
			if is_instance_of (widget, dynamic_type_from_string ("EV_COMBO_BOX")) then
				combo_box ?= widget
				check
					widget_is_combo_box: combo_box /= Void
				end
				create combo_box_extendible_controls.make_with_text_control (combo_box)
				extend (combo_box_extendible_controls)
			end
			if is_instance_of (widget, dynamic_type_from_string ("EV_TREE")) then
				tree ?= widget
				check
					widget_is_tree: tree /= Void
				end
				create tree_extendible_controls.make_with_text_control (tree)
				extend (tree_extendible_controls)
			end
			if is_instance_of (widget, dynamic_type_from_string ("EV_MULTI_COLUMN_LIST")) then
				multi_column_list ?= widget
				check
					widget_is_multi_column_list: multi_column_list /= Void
				end
				create multi_column_list_extendible_controls.make_with_text_control (multi_column_list)
				extend (multi_column_list_extendible_controls)
			end
			if is_instance_of (widget, dynamic_type_from_string ("EV_TOOL_BAR")) then
				tool_bar ?= widget
				check
					widget_is_tool_bar: tool_bar /= Void
				end
				create tool_bar_extendible_controls.make_with_combo_control (tool_bar,
					<<"BUTTON", "TOGGLE_BUTTON", "RADIO_BUTTON",
					"SEPARATOR">>)
				extend (tool_bar_extendible_controls)
			end
			if is_instance_of (widget, dynamic_type_from_string ("EV_CONTAINER")) then
				container ?= widget
				check
					widget_is_container: container /= Void
				end
				create container_extendible_controls.make_with_combo_control (container,
					<<"BUTTON", "FRAME", "TEXT">>)
				extend (container_extendible_controls)
			end
			current_parent.extend (Current)
		end		

end -- class GB_OBJECT_EDITOR
