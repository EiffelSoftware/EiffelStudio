indexing
	description: "Objects that manipulate objects of type EV_PIXMAPABLE."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_EV_PIXMAPABLE
	
	-- The following properties from EV_PIXMAPABLE are manipulated by `Current'.
	-- Pixmap - Performed on the real object and the display_object.

inherit
	GB_EV_ANY
		redefine
			attribute_editor,
			ev_type
		end
		
	GB_XML_UTILITIES
		undefine
			default_create
		end
		
	EV_ANY_HANDLER
		undefine
			default_create
		end
		
	EIFFEL_ENV
		undefine
			default_create
		end

feature -- Access


	ev_type: EV_PIXMAPABLE
		-- Vision2 type represented by `Current'.
		
	type: STRING is "EV_PIXMAPABLE"
		-- String representation of object_type modifyable by `Current'.
		
	attribute_editor: GB_OBJECT_EDITOR_ITEM is
			-- A vision2 component to enable modification
			-- of items held in `objects'.
		local
			horizontal_box: EV_HORIZONTAL_BOX
			frame: EV_FRAME
			frame_box: EV_VERTICAL_BOX
		do
			Result := Precursor {GB_EV_ANY}
			create horizontal_box
			create frame_box
			create modify_button
			modify_button.select_actions.extend (agent modify_pixmap)
			modify_button.select_actions.extend (agent update_editors)
			horizontal_box.extend (modify_button)
			create filler_label
			horizontal_box.extend (filler_label)
			horizontal_box.disable_item_expand (modify_button)
			frame_box.extend (horizontal_box)
			create pixmap_container
			frame_box.extend (pixmap_container)
			create frame.make_with_text ("Pixmap")
			frame.extend (frame_box)
			Result.extend (frame)
			update_attribute_editor
		end
		
	update_attribute_editor is
			-- Update status of `attribute_editor' to reflect information
			-- from `objects.first'.
			local
				error_label: EV_LABEL
		do
			if first.pixmap /= Void then
				add_pixmap_to_pixmap_container (first.pixmap)
				modify_button.set_text (Remove_string)
				modify_button.set_tooltip (Remove_tooltip)
			else
				pixmap_container.wipe_out
				modify_button.set_text (Select_string)
				modify_button.set_tooltip (Select_tooltip)
					-- Remove tooltip from `filler_label',
					-- no need to remove it from the pixmap
					-- as the pixmap will no be no longer visible.
				filler_label.remove_tooltip
				if first.pixmap_path /= Void then
					create error_label.make_with_text ("Error - Pixmap does not exist")
					error_label.set_tooltip (first.pixmap_path)
					pixmap_container.extend (error_label)
				end
			end
		end
		
		
feature {GB_XML_STORE} -- Output

	generate_xml (element: XML_ELEMENT) is
			-- Generate an XML representation of `Current' in `element'.
		do
			if first.pixmap_path /= Void then
				add_element_containing_string (element, pixmap_path_string, objects.first.pixmap_path)
			end
		end

	modify_from_xml (element: XML_ELEMENT) is
			-- Update all items in `objects' based on information held in `element'.
		local
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			element_info: ELEMENT_INFORMATION
			new_pixmap: EV_PIXMAP
			file_name: FILE_NAME
			file: RAW_FILE
		do
			full_information := get_unique_full_info (element)
			element_info := full_information @ (pixmap_path_string)	
			if element_info /= Void then
				create new_pixmap
				create file_name.make_from_string (element_info.data)
				create file.make (file_name)
				if file.exists then
					new_pixmap.set_with_named_file (element_info.data)
					for_all_objects (agent {EV_PIXMAPABLE}.set_pixmap (new_pixmap))
				else
					new_pixmap.draw_text (10, 10, "Error - Pixmap does not exist")
					new_pixmap.set_minimum_height (20)
				end
				for_all_objects (agent {EV_PIXMAPABLE}.set_pixmap_path (element_info.data))
			end
		end
		

feature {GB_CODE_GENERATOR} -- Output

	generate_code (element: XML_ELEMENT; a_name: STRING; children_names: ARRAYED_LIST [STRING]): STRING is
			-- `Result' is string representation of
			-- settings held in `Current' which is
			-- in a compilable format.
		local
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			element_info: ELEMENT_INFORMATION
		do
			Result := ""
			full_information := get_unique_full_info (element)
			element_info := full_information @ (pixmap_path_string)
			if element_info /= Void then
				Result := pixmap_name + ".set_with_named_file (%"" + element_info.data + "%")"
				Result := Result + indent + a_name + ".set_pixmap (" + pixmap_name + ")"
			end
			Result := strip_leading_indent (Result)
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
			if first.pixmap = Void then
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
						if Eiffel_platform.is_equal ("windows") then
							error_dialog.set_text (Windows_unsupported_pixmap_type)
						else
							error_dialog.set_text (Unix_unsupported_pixmap_type)
						end
						error_dialog.show_modal_to_window (parent_editor.parent_window (parent_editor))
					end
				end
			else
				for_all_objects (agent {EV_PIXMAPABLE}.remove_pixmap)
				for_all_objects (agent {EV_PIXMAPABLE}.set_pixmap_path (Void))
				pixmap_container.wipe_out
				modify_button.set_text (Select_string)
				modify_button.set_tooltip (Select_tooltip)
					-- Remove tooltip from `filler_label',
					-- no need to remove it from the pixmap
					-- as the pixmap will no be no longer visible.
				filler_label.remove_tooltip
				rebuild_associated_editors (first)
			end	
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
			pixmap.set_tooltip (first.pixmap_path)
				-- We also add a tooltip to the space to the right
				-- of the buttom, through `filler_label'.
			filler_label.set_tooltip (first.pixmap_path)
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
		
	modify_button: EV_BUTTON
		-- Is either "Select" or "Remove"
		-- depending on current context.

	pixmap_path_string: STRING is "Pixmap_path"
	
	Remove_string: STRING is "Remove"
		-- String on `modify_button' when able to remove pixmap.
		
	Select_string: STRING is "Select"
		-- String on `modify_button' ahen able to select pixmap.
		
	Remove_tooltip: STRING is "Remove pixmap"
		-- Tooltip on `modify_button' when able to remove pixmap.
		
	Select_tooltip: STRING is "Select pixmap"
		-- Tooltip on `modify_button' when able to remove pixmap.


end -- class GB_EV_PIXMAPABLE