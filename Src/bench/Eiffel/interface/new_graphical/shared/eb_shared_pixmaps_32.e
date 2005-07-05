indexing
	description: "32x32 matrix pixmap for EiffelStudio user interface"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SHARED_PIXMAPS_32

inherit
	EIFFEL_ENV
		export
			{NONE} all
		end	
		
	EB_SHARED_PIXMAP_FACTORY
		export
			{NONE} all
		end
	
feature -- Pixmap Icons
			
	icons_progress_degree: ARRAY [EV_PIXMAP] is
			-- Icons representing a thermometer a different temperatures.
		local
			i: INTEGER
		once
			create Result.make (-3, 6)
			from
				i := -3
			until
				i > 6
			loop
				Result.put (pixmap_file_content ("icon_degree" + i.out), i)
				i := i + 1
			end
		end

	icon_wizard_blank_project: EV_PIXMAP is
		once
			Result := pixmap_file_content ("icon_wizard_blank_project")
		end

	icon_wizard_project: EV_PIXMAP is
		once
			Result := pixmap_file_content ("icon_wizard_project")
		end

	icon_wizard_ace_project: EV_PIXMAP is
		once
			Result := pixmap_file_content ("icon_wizard_ace_project")
		end

	icon_open_project: EV_PIXMAP is
		once
			Result := pixmap_file_content ("icon_open_project")
		end
		
feature {NONE} -- {EB_SHARED_PIXMAP_FACTORY} Implementation

	pixmap_width: INTEGER is 32
		-- Width in pixels of generated factory image
		
	pixmap_height: INTEGER is 32
		-- Height in pixels of generated factory image

	image_matrix: EV_PIXMAP is
			-- Matrix pixmap containing all of the screen cursors
		once
			Result := pixmap_file_content ("icon_matrix_32")
		end

	pixmap_path: DIRECTORY_NAME is
			-- Path to cursor pixmaps
		once
			create Result.make_from_string (eiffel_installation_dir_name)
			Result.extend_from_array (<<short_studio_name, "bitmaps", "png">>)
		end

	pixmap_lookup: HASH_TABLE [TUPLE [INTEGER, INTEGER], STRING] is
			-- Lookup hash table for studio pixmaps
		once
			create Result.make (14)		
			
			Result.put ([1, 1], "icon_degree-3")
			Result.put ([1, 2], "icon_degree-2")
			Result.put ([1, 3], "icon_degree-1")
			Result.put ([1, 4], "icon_degree0")
			Result.put ([1, 5], "icon_degree1")
			Result.put ([1, 6], "icon_degree2")	
			Result.put ([1, 7], "icon_degree3")
			Result.put ([1, 8], "icon_degree4")
		
			Result.put ([2, 1], "icon_degree5")
			Result.put ([2, 2], "icon_degree6")
			Result.put ([2, 3], "icon_open_project")
			Result.put ([2, 4], "icon_wizard_ace_project")
			Result.put ([2, 5], "icon_wizard_project")
			Result.put ([2, 6], "icon_wizard_blank_project")
			
			Result.compare_objects
		end

end -- class EB_SHARED_PIXMAPS_32
