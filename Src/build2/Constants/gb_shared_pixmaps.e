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
		
	Icon_cmd_history_title: ARRAY [EV_PIXMAP] is
			-- Array containing both the color & the gray pixmap
			-- Color is at index 1, gray at index 2
		once
			Result := build_classic_pixmap ("cmd_history_title")
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
		
	Icon_restore: ARRAY [EV_PIXMAP] is
		once
			Result := build_classic_pixmap ("restore")
		end
		
	Icon_close: ARRAY [EV_PIXMAP] is
		once
			Result := build_classic_pixmap ("close")
		end
		
	pixmap_by_name (a_name: STRING): EV_PIXMAP is
			-- `Result' is a pixmap loaded from file matching
			-- `a_name' in Build bitmaps location.
			-- If platform is windows then add ".ico" to name
			-- else add ".png" to name.
		require
			a_name_not_void: a_name /= Void
		local
			file: RAW_FILE
		do
			create Result
				-- We first attempt to retrieve the pixmap
				-- from `pixmaps_by_name'. If it is contained
				-- then this means that the pixmap has already been loaded.
				-- This stops us form having to load the pixmap every time.
			if pixmaps_by_name.has (a_name) then
				Result := pixmaps_by_name @ (a_name)
			else
				create file.make (pixmap_file_name (a_name))
				--| FIXME This is a temporary hack to display
				--| a not found pixmap if the pixmap does not exist.
				--| Replace with a check when all pixmaps have been implemented.
				if file.exists then
					Result.set_with_named_file (pixmap_file_name (a_name))
					check
						pixmap_not_contained: not pixmaps_by_name.has (a_name)
					end
						-- Store `Result' in `pixmaps_by_name'
						-- For quick retrieval.
					pixmaps_by_name.put (Result, a_name)
				else
					Result := icon_delete_small @ 1
				end
			end
		ensure
			result_not_void: Result /= Void
		end

feature {NONE} -- Update

	pixmap_file_content (fn: STRING): EV_PIXMAP is
		local
			full_path: FILE_NAME
			retried: BOOLEAN
			warning_dialog: EV_WARNING_DIALOG
		do
				-- Create the pixmap
			create Result

			if not retried then
					-- load the file
				Result.set_with_named_file (pixmap_file_name (fn))
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

	pixmaps_by_name: HASH_TABLE [EV_PIXMAP, STRING] is
			-- All pixmaps returned from `pixmap_by_name'.
			-- Key is name used as argument.
		once
			create Result.make (50)
		end

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

	pixmap_file_name (file: STRING): FILE_NAME is
			-- `Result' is full path to `file'.
			-- Dependent on platform, and type of
			-- execution (Wizard, normal.)
		require
			file_name_exists: file /= Void and not file.is_empty
		do
				-- Note that if we have launched from
				-- VisualStudio, then we look for the pixmaps
				-- relative to the current directory, which is the location
				-- of build.exe
			if visual_studio_information.is_visual_studio_wizard then
				create Result.make_from_string (visual_studio_information.wizard_installation_path)
				Result.extend ("Wizards")
				Result.extend ("build")
				Result.extend ("bitmaps")
				Result.extend ("ico")
				Result.set_file_name (file)
				Result.add_extension ("ico")
			else
				if Eiffel_platform.as_lower.is_equal ("windows") then
					create Result.make_from_string (Icon_path)
					Result.set_file_name (file)
					Result.add_extension ("ico")
				else
					create Result.make_from_string (Bitmap_path)
					Result.set_file_name (file)
					Result.add_extension (Pixmap_suffix)
				end
			end
		ensure
			Result_not_void: Result /= Void
		end
		
feature {NONE} -- Implementation

	visual_studio_information: VISUAL_STUDIO_INFORMATION is
			-- `Result' is instance of VISUAL_STUDIO_INFORMATION.
			-- Is a Once, as the state will never change during the
			-- execution of Build.
		once
			create Result
		ensure
			Result_not_void: Result /= Void
		end

end -- Class GB_SHARED_PIXMAPS
