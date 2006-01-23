indexing
	description: "Objects that create extendible controls for EV_TOOL_BAR"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TOOL_BAR_EXTENDIBLE_CONTROLS
	
inherit
	EXTENDIBLE_CONTROLS
		redefine
			current_type
		end
		
	INTERNAL
		undefine
			copy, is_equal, default_create
		end
		
	EV_ANY_HANDLER
		export
			{NONE} all
		undefine
			copy, is_equal, default_create
		end
	
create
	make_with_combo_control

feature -- Access

	current_type: EV_TOOL_BAR

feature -- Status report

	help: STRING is "Select %"Extend%", to add a new item to the tool bar, correspnding to selected type in combo box.%NSelecting %"Wipe_out%" will clear the tool bar." 
			-- Instructions on how to use the control.

feature -- Status setting

	extend_item is
			-- Add a new item to `current_type'.
		local
			tool_bar_item: EV_TOOL_BAR_ITEM
			tool_bar_button: EV_TOOL_BAR_BUTTON
		do
			tool_bar_item ?= new_instance_of (dynamic_type_from_string ("EV_TOOL_BAR_" + combo_control.selected_item.text))
			check
				tool_bar_item_not_void: tool_bar_item /= Void
			end
			tool_bar_item.default_create
			tool_bar_button ?= tool_bar_item
			if tool_bar_button /= Void then
				tool_bar_button.set_text ("B")
			end
			current_type.extend (tool_bar_item)
		end
	
	wipe_out_item is
			-- call `wipe_out' on `Current_type'.
		do
			current_type.wipe_out
			object_editor.set_type (object_editor.test_widget)
		end

feature {NONE} -- Implementation

	initial_text: STRING is "";
			-- Initial text for new items.

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class TOOL_BAR_EXTENDIBLE_CONTROLS
