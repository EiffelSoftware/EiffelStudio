indexing
	description: "Pixmaps used in interface."
	date: "$Date$"
	revision: "$Revision$"

class
	GB_SHARED_PIXMAPS

inherit
	EV_STOCK_PIXMAPS

	EIFFEL_ENV
		export
			{NONE} all
		end

feature -- Pngs

	Help_about_pixmap: EV_PIXMAP is
			-- Full path name and file title of PNG used in the help about window.
		local
			file_name: FILE_NAME
		once
			create file_name.make_from_string ((create {EIFFEL_ENV}).Eiffel_installation_dir_name)
			file_name.extend ("build")
			file_name.extend ("bitmaps")
			file_name.extend ("png")
			file_name.extend ("bm_about.png")
			create Result
			Result.set_with_named_file (file_name)
		end

	Icon_object_symbol: EV_PIXMAP is
		once
			Result := pixmap_file_content ("icon_object_symbol")
		end

	Icon_save: ARRAY [EV_PIXMAP] is
			-- Array containing both the color & the gray pixmap
			-- Color is at index 1, gray at index 2
		once
			Result := build_classic_pixmap ("save")
		end

	Icon_undo: ARRAY [EV_PIXMAP] is
			-- Array containing both the color & the gray pixmap
			-- Color is at index 1, gray at index 2
		once
			Result := build_classic_pixmap ("undo")
		end

	Icon_cmd_history: ARRAY [EV_PIXMAP] is
			-- Array containing both the color & the gray pixmap
			-- Color is at index 1, gray at index 2
		once
			Result := build_classic_pixmap ("cmd_history")
		end

	Icon_redo: ARRAY [EV_PIXMAP] is
			-- Array containing both the color & the gray pixmap
			-- Color is at index 1, gray at index 2
		once
			Result := build_classic_pixmap ("redo")
		end

	Icon_new_editor: ARRAY [EV_PIXMAP] is
			-- Array containing both the color & the gray pixmap
			-- Color is at index 1, gray at index 2
		once
			Result := build_classic_pixmap ("new_editor")
		end

	Icon_new_class: ARRAY [EV_PIXMAP] is
			-- Array containing both the color & the gray pixmap
			-- Color is at index 1, gray at index 2
		once
			Result := build_classic_pixmap ("new_class")
		end

	Icon_delete_small: ARRAY [EV_PIXMAP] is
		once
			Result := build_classic_pixmap ("delete_small")
		end

	Icon_system_window: EV_PIXMAP is
		once
			Result := pixmap_file_content ("icon_system_color")
		end
		
	Icon_component_display_view: EV_PIXMAP is
		once
			Result := pixmap_file_content ("icon_component_display_view_color")
		end
		
	Icon_component_build_view: EV_PIXMAP is
		once
			Result := pixmap_file_content ("icon_component_build_view_color")
		end
		
	Icon_display_window: ARRAY [EV_PIXMAP] is
		once
			Result := build_classic_pixmap ("display_window")
		end
		
	Icon_builder_window: ARRAY [EV_PIXMAP] is
		once
			Result := build_classic_pixmap ("builder_window")
		end
		
	Icon_object_editor: ARRAY [EV_PIXMAP] is
		once
			Result := build_classic_pixmap ("object_editor")
		end
		
	Icon_component_viewer: ARRAY [EV_PIXMAP] is
		once
			Result := build_classic_pixmap ("component_viewer")
		end
	
	Icon_component_window: ARRAY [EV_PIXMAP] is
		once
			Result := build_classic_pixmap ("component_window")
		end
		
	Icon_object_window: ARRAY [EV_PIXMAP] is
		once
			Result := build_classic_pixmap ("object_window")
		end
		
	Icon_code_generation: ARRAY [EV_PIXMAP] is
		once
			Result := build_classic_pixmap ("code_generation")
		end
		
	Icon_build_window: ARRAY [EV_PIXMAP] is
		once
			Result := build_classic_pixmap ("build_window")
		end
		
		
	Icon_minimize: ARRAY [EV_PIXMAP] is
		once
			Result := build_classic_pixmap ("minimize")
		end
		
	Icon_maximize: ARRAY [EV_PIXMAP] is
		once
			Result := build_classic_pixmap ("maximize")
		end
		
	Icon_close: ARRAY [EV_PIXMAP] is
		once
			Result := build_classic_pixmap ("close")
		end

feature -- Reading

	pixmap_file_content (fn: STRING): EV_PIXMAP is
		local
			full_path: FILE_NAME
			retried: BOOLEAN
			warning_dialog: EV_WARNING_DIALOG
		do
				-- Create the pixmap
			create Result

			if not retried then
					-- Initialize the pathname & load the file
				if
					-- |FIXME
					True --Platform_constants.is_windows and then
					--fn.substring_index ("icon_", 1) = 1
				then
					create full_path.make_from_string (Icon_path)
					full_path.set_file_name (fn)
					full_path.add_extension ("ico")
				else
					create full_path.make_from_string (Bitmap_path)
					full_path.set_file_name (fn)
					full_path.add_extension (Pixmap_suffix)
				end
				Result.set_with_named_file (full_path)
			else
				create warning_dialog.make_with_text (
					"Cannot read pixmap file:%N" + full_path + ".%N%
					%Please make sure the installation is not corrupted.")
				warning_dialog.show
				Result.set_size (16, 16) -- Default pixmap size
			end
		rescue
			retried := True
			retry
		end

feature {NONE} -- Update

	Pixmap_suffix: STRING is "png"
			-- Suffix for pixmaps.

	Bitmap_path: DIRECTORY_NAME is
			-- Path for Bmp/Xpm for Windows/Unix.
		once
			create Result.make_from_string ((create {EIFFEL_ENV}).Bitmaps_path)
			Result.extend (Pixmap_suffix)
		end

	Icon_path: DIRECTORY_NAME is
			-- Path for Icons for Windows.
		once
			create Result.make_from_string ((create {EIFFEL_ENV}).Bitmaps_path)
			Result.extend ("ico")
		end

	build_classic_pixmap (pixmap_name: STRING): ARRAY [EV_PIXMAP] is
			-- Build an array of 2 pixmaps. The first pixmap is the
			-- colored pixmap, the second is the corresponding gray pixmap.
			--
			-- `pixmap_name' is the core name of the pixmap.
		do
				-- Read the pixmaps 
			create Result.make (1,1)
			Result.put (pixmap_file_content ("icon_" + pixmap_name + "_color"), 1)
		ensure
			result_valid: Result /= Void and then Result.count = 1
		end

	build_text_pixmap (pixmap_name: STRING): ARRAY [EV_PIXMAP] is
			-- Build an array of 4 pixmaps. The first pixmap is the
			-- colored pixmap, the second is the corresponding gray pixmap.
			-- The third is a colored pixmap with some explaining text and
			-- the forth is the grayed version of the third.
			--
			-- `pixmap_name' is the core name of the pixmap.
		do
				-- Read the pixmaps 
			create Result.make (1,2)
			Result.put (pixmap_file_content ("icon_" + pixmap_name + "_color"), 1)
			Result.put (pixmap_file_content ("icon_" + pixmap_name + "_text_color"), 2)
		ensure
			result_valid: Result /= Void and then Result.count = 2
		end

end -- Class GB_SHARED_PIXMAPS
