indexing
	description: "Pixmaps used in interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	GB_SHARED_PIXMAPS

inherit
	EV_STOCK_PIXMAPS
		rename
			implementation as stock_pixmaps_implementation
		end

	GB_EIFFEL_ENV
		export
			{NONE} all
		end

feature -- Pngs

	Help_about_pixmap: EV_PIXMAP is
			-- Full path name and file title of PNG used in the help about window.
		local
			file_name: FILE_NAME
		once
			create file_name.make_from_string ((create {GB_EIFFEL_ENV}).Eiffel_installation_dir_name)
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

	Icon_open_file: ARRAY [EV_PIXMAP] is
			-- Array containing both the color & the gray pixmap
			-- Color is at index 1, gray at index 2
		once
			Result := build_classic_pixmap ("open_file")
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

	Icon_format_onces: ARRAY [EV_PIXMAP] is
		once
			Result := build_classic_pixmap ("format_onces")
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

	Icon_directory: ARRAY [EV_PIXMAP] is
		once
			Result := build_classic_pixmap ("cluster_symbol")
		end

	Icon_string: ARRAY [EV_PIXMAP] is
		once
			Result := build_classic_pixmap ("string_small")
		end

	Icon_integer: ARRAY [EV_PIXMAP] is
		once
			Result := build_classic_pixmap ("integer_small")
		end

	Icon_titled_window_main: ARRAY [EV_PIXMAP] is
		once
			Result := build_classic_pixmap ("titled_window_main")
		end

	Icon_titled_window_main_small: ARRAY [EV_PIXMAP] is
		once
			Result := build_classic_pixmap ("titled_window_main_small")
		end

	Icon_missing_pixmap_small: ARRAY [EV_PIXMAP] is
		once
			Result := build_classic_pixmap ("missing_pixmap_small")
		end

	Icon_locked: ARRAY [EV_PIXMAP] is
		once
			Result := build_classic_pixmap ("locked")
		end

	Icon_paste: ARRAY [EV_PIXMAP] is
		once
			Result := build_classic_pixmap ("past")
		end

	Icon_cut: ARRAY [EV_PIXMAP] is
		once
			Result := build_classic_pixmap ("cut")
		end

	Icon_copy: ARRAY [EV_PIXMAP] is
		once
			Result := build_classic_pixmap ("copy")
		end

	Icon_clipboard: ARRAY [EV_PIXMAP] is
		once
			Result := build_classic_pixmap ("clipboard")
		end

	Icon_mini_back: ARRAY [EV_PIXMAP] is
		once
			Result := build_classic_pixmap ("mini_back")
		end

	Icon_mini_forth: ARRAY [EV_PIXMAP] is
		once
			Result := build_classic_pixmap ("mini_forth")
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
				-- This stops us from having to load the pixmap every time.
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
					update_warning_dialog_text (pixmap_file_name (a_name))
					if not pixmap_warning_dialog.is_destroyed and then not pixmap_warning_dialog.is_show_requested then
						pixmap_warning_dialog.show
					end
					Result := icon_delete_small @ 1
				end
			end
		ensure
			result_not_void: Result /= Void
		end

	png_location: STRING is
			-- `Result' is directory containing png files.
		once
			Result := Bitmap_path
		ensure
			Result_not_void: Result /= Void
		end

feature {NONE} -- Update

	pixmap_file_content (fn: STRING): EV_PIXMAP is
		local
			file_name: FILE_NAME
			file: RAW_FILE
		do
				-- Create the pixmap
			create Result

			file_name := pixmap_file_name (fn)
			create file.make (file_name)
			if file.exists then
					-- load the file
				Result.set_with_named_file (pixmap_file_name (fn))
			else
				update_warning_dialog_text (pixmap_file_name (fn))
				Result.set_size (16, 16) -- Default pixmap size
			end
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
			create Result.make_from_string ((create {GB_EIFFEL_ENV}).Bitmaps_path)
			Result.extend (Pixmap_suffix)
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
			create Result.make_from_string (Bitmap_path)
			Result.set_file_name (file)
			Result.add_extension (Pixmap_suffix)
		ensure
			Result_not_void: Result /= Void
		end

feature {NONE} -- Implementation

	all_missing_files: HASH_TABLE [STRING, STRING] is
			-- All pixmaps that have been found to be missing so far.
		once
			create Result.make (10)
		end

	pixmap_warning_dialog: EV_WARNING_DIALOG is
			-- Dialog to be displayed, when a pixmap is
			-- missing from the installation.
		once
			create Result.make_with_text ("Cannot read pixmap files:%NPlease make sure the installation is not corrupted.")
			Result.show
		end

	update_warning_dialog_text (new_text: STRING) is
			-- Add `new_text' to text of warning dialog, one
			-- line before the end.
		require
			new_text_not_void: new_text /= Void
		local
			new_line_index: INTEGER
		do
			if not pixmap_warning_dialog.is_destroyed then
				if not all_missing_files.has (new_text) then
					all_missing_files.put (new_text, new_text)
					new_line_index := pixmap_warning_dialog.text.last_index_of ('%N', pixmap_warning_dialog.text.count)
					pixmap_warning_dialog.set_text (pixmap_warning_dialog.text.substring (1, new_line_index - 1) + "%N" +
						new_text + pixmap_warning_dialog.text.substring (new_line_index, pixmap_warning_dialog.text.count))
				end
			end
		end


indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- Class GB_SHARED_PIXMAPS
