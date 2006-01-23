indexing
	description: "Objects that create extendible controls for EV_CONTAINER"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CONTAINER_EXTENDIBLE_CONTROLS
	
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
		undefine
			copy, is_equal, default_create
		end
	
create
	make_with_combo_control

feature -- Access

	current_type: EV_CONTAINER

feature -- Status report

	help: STRING is "Select %"Extend%", to add a new item to the container, corresponding to the selected type in combo box.%NNote that if the current container is full, no widget will be added.%NSelecting %"Wipe_out%" will clear the container." 
			-- Instructions on how to use the control.

feature -- Status setting

	extend_item is
			-- Add a new item to `current_type'.
		local
			textable: EV_TEXTABLE
			widget: EV_WIDGET
		do
			if not current_type.full then
				textable ?= new_instance_of (dynamic_type_from_string ("EV_" + combo_control.selected_item.text))
				check
					textable_not_void: textable /= Void
				end
				textable.default_create
				textable.set_text (combo_control.selected_item.text)
				widget ?= textable
				check
					widget_not_void: widget /= Void
				end
				current_type.extend (widget)
				object_editor.set_type (object_editor.test_widget)
			end
		end
		
	wipe_out_item is
			-- call `wipe_out' on `Current_type'.
		local
			notebook: EV_NOTEBOOK
		do
			current_type.wipe_out
			object_editor.set_type (object_editor.test_widget)
			
			notebook ?= current_type
			if notebook /= Void then
					-- Need to perform special processing here as the notebook keeps
					-- a list of its pixmap paths associated with the tabs which must
					-- also be reset.
				notebook.pixmap_paths.clear_all
			end
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


end -- class CONTAINER_EXTENDIBLE_CONTROLS
