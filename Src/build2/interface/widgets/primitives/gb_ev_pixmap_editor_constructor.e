indexing
	description: "Builds an attribute editor for modification of objects of type EV_PIXMAP."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_EV_PIXMAP_EDITOR_CONSTRUCTOR
	
inherit
	GB_EV_EDITOR_CONSTRUCTOR
		undefine
			default_create
		end
		
	EIFFEL_ENV
		undefine
			default_create
		end
		
feature -- Access

	ev_type: EV_PIXMAP
		-- Vision2 type represented by `Current'.
		
	type: STRING is "EV_PIXMAP"
		-- String representation of object_type modifyable by `Current'.
		
	attribute_editor: GB_OBJECT_EDITOR_ITEM is
			-- A vision2 component to enable modification
			-- of items held in `objects'.
		local
			horizontal_box: EV_HORIZONTAL_BOX
			frame: EV_FRAME
			frame_box: EV_VERTICAL_BOX
		do
			create Result
			initialize_attribute_editor (Result)
			create horizontal_box
			create frame_box
			create modify_button.make_with_text ("Set with named file")
			modify_button.select_actions.extend (agent modify_pixmap)
			modify_button.select_actions.extend (agent update_editors)
			horizontal_box.extend (modify_button)
			create filler_label
			horizontal_box.extend (filler_label)
			horizontal_box.disable_item_expand (modify_button)
			frame_box.extend (horizontal_box)
			create pixmap_container
			frame_box.extend (pixmap_container)
			create frame.make_with_text (gb_ev_pixmap_pixmap)
			frame.extend (frame_box)
			Result.extend (frame)
			update_attribute_editor
		end
		
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
					if Eiffel_platform.is_equal ("windows") then
						error_dialog.set_text (Windows_unsupported_pixmap_type)
					else
						error_dialog.set_text (Unix_unsupported_pixmap_type)
					end
					error_dialog.show_modal_to_window (parent_window (parent_editor))
				end
			end
			rebuild_associated_editors (first)
		end
		
	valid_file_extension (extension: STRING): BOOLEAN is
			-- Is `extension' a valid file format for
			-- a pixmap on the current platform?
		require
			extension_length_3: extension.count = 3
		do
			extension.to_upper
			if Eiffel_platform.is_equal ("windows") and
				(extension.is_equal ("BMP") or extension.is_equal ("ICO") or
				extension.is_equal ("PNG")) then
				Result := True
			elseif (extension.is_equal ("PNG") or extension.is_equal ("XPM")) then
				Result := True
			end
		end

	add_pixmap_to_pixmap_container (pixmap: EV_PIXMAP) is
			-- Add `pixmap' to `pixmap_container'.
		local
			x_ratio, y_ratio: REAL
			new_x, new_y: INTEGER
			biggest_ratio: REAL
		do
			if first.pixmap_path /= Void then
				pixmap.set_tooltip (first.pixmap_path)
					-- We also add a tooltip to the space to the right
					-- of the buttom, through `filler_label'.
				filler_label.set_tooltip (first.pixmap_path)
			end
			x_ratio := pixmap.width / minimum_width_of_object_editor
			y_ratio := pixmap.height / minimum_width_of_object_editor
			if x_ratio > 1 and y_ratio < 1 then 
				new_x := minimum_width_of_object_editor
				new_y := (pixmap.height / x_ratio).truncated_to_integer
			end
			if y_ratio > 1 and x_ratio < 1 then
				new_y := minimum_width_of_object_editor
				new_x := (pixmap.width / y_ratio).truncated_to_integer
			end
			if y_ratio > 1 and x_ratio > 1 then
				biggest_ratio := x_ratio.max (y_ratio)
				new_x := (pixmap.width / biggest_ratio).truncated_to_integer
				new_y := (pixmap.height / biggest_ratio).truncated_to_integer
			end
			
			if new_x /= 0 and new_y /= 0 then
				pixmap.stretch (new_x, new_y)	
			end
			pixmap_container.wipe_out
			pixmap_container.extend (pixmap)
			pixmap.set_minimum_size (pixmap.width, pixmap.height)
		end

	pixmap_container: EV_CELL
		-- Holds a representation of the loaded pixmap.
		
	filler_label: EV_LABEL
	
	error_label: EV_LABEL
		
	modify_button: EV_BUTTON
		-- Is either "Select" or "Remove"
		-- depending on current context.

	pixmap_path_string: STRING is "Pixmap_path"
	
	Remove_string: STRING is "Remove"
		-- String on `modify_button' when able to remove pixmap.

	Remove_tooltip: STRING is "Remove pixmap"
		-- Tooltip on `modify_button' when able to remove pixmap.
		
	Select_tooltip: STRING is "Select pixmap"
		-- Tooltip on `modify_button' when able to remove pixmap.

end -- class GB_EV_PIXMAP_EDITOR_CONSTRUCTOR
