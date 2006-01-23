indexing
	description: "Objects that create extendible controls for EV_COMBO_BOX"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	COMBO_BOX_EXTENDIBLE_CONTROLS
	
inherit
	EXTENDIBLE_CONTROLS
		redefine
			current_type
		end
	
create
	make_with_text_control

feature -- Access

	current_type: EV_COMBO_BOX

feature -- Status report

	help: STRING is "Select %"Extend%", to add a new item to the combo box, with `text' matching that of the text field.%NSelecting %"Wipe_out%" will clear the combo box." 
			-- Instructions on how to use the control.

feature -- Status setting

	extend_item is
			-- Add a new item to `current_type'.
		local
			list_item: EV_LIST_ITEM
		do
			create list_item.make_with_text (text_control.text)
			current_type.extend (list_item)
		end
		
	wipe_out_item is
			-- call `wipe_out' on `Current_type'.
		do
			current_type.wipe_out
			object_editor.set_type (object_editor.test_widget)
		end

feature {NONE} -- Implementation

	initial_text: STRING is "List item";
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


end -- class COMBO_BOX_EXTENDIBLE_CONTROLS
