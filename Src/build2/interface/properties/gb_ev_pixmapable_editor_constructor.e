indexing
	description: "Builds an attribute editor for modification of objects of type EV_PIXMAPABLE."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_EV_PIXMAPABLE_EDITOR_CONSTRUCTOR
	
inherit
	GB_EV_COMMON_PIXMAP_EDITOR_CONSTRUCTOR
		undefine
			default_create
		end
		
feature -- Access

	ev_type: EV_PIXMAPABLE
		-- Vision2 type represented by `Current'.
		
	type: STRING is "EV_PIXMAPABLE"
		-- String representation of object_type modifyable by `Current'.
		
	update_attribute_editor is
			-- Update status of `attribute_editor' to reflect information
			-- from `objects.first'.
		do
			if object.constants.item (type + Pixmap_path_string) /= Void then
				constants_button.enable_select
				switch_constants_mode	
			else			
				if first.pixmap /= Void then
					add_pixmap_to_pixmap_container (first.pixmap)
					modify_button.set_text (Remove_string)
					modify_button.set_tooltip (Remove_tooltip)
				else
					pixmap_container.wipe_out
					modify_button.set_text (Select_button_text)
					modify_button.set_tooltip (Select_tooltip)
						-- Remove tooltip from `filler_label',
						-- no need to remove it from the pixmap
						-- as the pixmap will no be no longer visible.
					filler_label.remove_tooltip
					if first.pixmap_path /= Void then
						create error_label.make_with_text ("Error - named pixmap missing.")
						error_label.set_tooltip (first.pixmap_path)
						pixmap_container.extend (error_label)
						modify_button.set_text (Remove_string)
						modify_button.set_tooltip (Remove_tooltip)
					end
				end
			end
		end
		
feature {NONE} -- Implementation

	modify_pixmap is
			-- Display a dialog allowing user input for
			-- selected pixmap.
		local
			dialog: EV_FILE_OPEN_DIALOG
			new_pixmap: EV_PIXMAP
			shown_once, opened_file: BOOLEAN
			error_dialog: EV_WARNING_DIALOG
		do
			if first.pixmap = Void and first.pixmap_path = Void then
				from
					create dialog
				until
					(dialog.file_name.is_empty and shown_once) or opened_file
				loop
					shown_once := True
					dialog.show_modal_to_window (parent_window (parent_editor))
					if not dialog.file_name.is_empty and then valid_file_extension (dialog.file_name.substring (dialog.file_name.count -2, dialog.file_name.count)) then
						create new_pixmap
						new_pixmap.set_with_named_file (dialog.file_name)
							-- Must set the pixmap before the stretch takes place.
						for_all_objects (agent {EV_PIXMAPABLE}.set_pixmap (new_pixmap))
						for_all_objects (agent {EV_PIXMAPABLE}.set_pixmap_path (dialog.file_name))
						add_pixmap_to_pixmap_container (clone (new_pixmap))
						modify_button.set_text (Remove_string)
						modify_button.set_tooltip (Remove_tooltip)
						opened_file := True
					elseif not dialog.file_name.is_empty then
						create error_dialog
						error_dialog.set_text (invalid_type_warning)
						error_dialog.show_modal_to_window (parent_window (parent_editor))
					end
				end
			else
				for_all_objects (agent {EV_PIXMAPABLE}.remove_pixmap)
				for_all_objects (agent {EV_PIXMAPABLE}.set_pixmap_path (Void))
				pixmap_container.wipe_out
				modify_button.set_text (Select_button_text)
				modify_button.set_tooltip (Select_tooltip)
					-- Remove tooltip from `filler_label',
					-- no need to remove it from the pixmap
					-- as the pixmap will no be no longer visible.
				filler_label.remove_tooltip
				rebuild_associated_editors (first)
			end	
		end

end -- class GB_EV_PIXMAPABLE_EDITOR_CONSTRUCTOR
