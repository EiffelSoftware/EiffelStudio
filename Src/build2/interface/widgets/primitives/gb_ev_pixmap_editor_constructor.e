indexing
	description: "Builds an attribute editor for modification of objects of type EV_PIXMAP."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_EV_PIXMAP_EDITOR_CONSTRUCTOR
	
inherit
	GB_EV_COMMON_PIXMAP_EDITOR_CONSTRUCTOR
		undefine
			default_create
		end
		
	GB_EV_PIXMAP_HANDLER
		undefine
			default_create
		end
		
	GB_CONSTANTS
		export
			{NONE} all
		end
		
	GB_SHARED_PIXMAPS
		export
			{NONE} all
		undefine
			Visual_studio_information
		end
		
	GB_SHARED_CONSTANTS
		export
			{NONE} all
		end
		
feature -- Access

	ev_type: EV_PIXMAP
		-- Vision2 type represented by `Current'.
		
	type: STRING is "EV_PIXMAP"
			-- String representation of object_type modifyable by `Current'.
		
	update_attribute_editor is
			-- Update status of `attribute_editor' to reflect information
			-- from `objects.first'.
		do
			if first.pixmap_exists then
				add_pixmap_to_pixmap_container (clone (first))
				for_all_objects (agent {EV_PIXMAP}.enable_pixmap_exists)
			elseif first.pixmap_path = Void then 
				-- `pixmap_path' is Void when we have not assigned a path yet,
				-- so we do nothing.
			else
				create error_label.make_with_text ("Error - named pixmap missing.")
				error_label.set_tooltip (first.pixmap_path)
				pixmap_container.extend (error_label)
				for_all_objects (agent {EV_PIXMAP}.disable_pixmap_exists)
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
					for_all_objects (agent {EV_PIXMAP}.set_with_named_file (dialog.file_name))
					for_all_objects (agent {EV_PIXMAP}.set_pixmap_path (dialog.file_name))
					for_all_objects (agent {EV_PIXMAP}.enable_pixmap_exists)
					add_pixmap_to_pixmap_container (clone (new_pixmap))
					opened_file := True
				elseif not dialog.file_name.is_empty then
					create error_dialog
					error_dialog.set_text (invalid_type_warning)
					error_dialog.show_modal_to_window (parent_window (parent_editor))
				end
			end
			rebuild_associated_editors (first)
		end

end -- class GB_EV_PIXMAP_EDITOR_CONSTRUCTOR
