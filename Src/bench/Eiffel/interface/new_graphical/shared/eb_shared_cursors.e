indexing
	description:	
		"Cursors used in the interface."
	date: "$Date$"
	revision: "$Revision: "

class 
	EB_SHARED_CURSORS

inherit
	EIFFEL_ENV
	
	EB_SHARED_PIXMAP_FACTORY

feature -- Accepting cursor shapes

	cur_Class: EV_CURSOR is
		once
			Result := cursor_file_content ("class")
		end
		
	cur_Class_list: EV_CURSOR is
		once
			Result := cursor_file_content ("class_list")
		end

	cur_Favorites_folder: EV_CURSOR is
		once
			Result := cursor_file_content ("favorites_folder")
		end

	cur_Object: EV_CURSOR is
		once
			Result := cursor_file_content ("object")
		end

	cur_Setstop: EV_CURSOR is
		once
			Result := cursor_file_content ("stopexec")
		end 

	cur_Interro: EV_CURSOR is
		once
			Result := cursor_file_content ("interro")
		end 

	cur_Feature: EV_CURSOR is
		once
			Result := cursor_file_content ("feature")
		end

	cur_Cluster: EV_CURSOR is
		once
			Result := cursor_file_content ("cluster")
		end

	cur_Inherit_link: EV_CURSOR is
		once
			Result := cursor_file_content ("inheritlnk")
		end

	cur_Client_link: EV_CURSOR is
		once
			Result := cursor_file_content ("clientlnk")
		end

feature -- Non-Accepting cursor shapes

	cur_X_class: EV_CURSOR is
		once
			Result := cursor_file_content ("Xclass")
		end
		
	cur_X_class_list: EV_CURSOR is
		once
			Result := cursor_file_content ("Xclass_list")
		end

	cur_X_object: EV_CURSOR is
		once
			Result := cursor_file_content ("Xobject")
		end

	cur_X_cluster: EV_CURSOR is
		once
			Result := cursor_file_content ("Xcluster")
		end 

	cur_X_Favorites_folder: EV_CURSOR is
		once
			Result := cursor_file_content ("Xfavorites_folder")
		end

	cur_X_interro: EV_CURSOR is
		once
			Result := cursor_file_content ("Xinterro")
		end 

	cur_X_explain: EV_CURSOR is
		once
			Result := cursor_file_content ("Xobject")
		end

	cur_X_setstop: EV_CURSOR is
		once
			Result := cursor_file_content ("Xstopexec")
		end 

	cur_X_feature: EV_CURSOR is
		once
			Result := cursor_file_content ("Xfeature")
		end
		
	cur_X_client_link: EV_CURSOR is
		once
			Result := cursor_file_content ("Xclientlnk")
		end
		
	cur_X_inherit_link: EV_CURSOR is
		once
			Result := cursor_file_content ("Xinheritlnk")
		end

feature -- Other cursor

	cur_cut_selection: EV_CURSOR is
		once
			Result := cursor_file_content ("cut_selection")
			Result.set_x_hotspot (0)
			Result.set_y_hotspot (0)
		end

	cur_copy_selection: EV_CURSOR is
		once
			Result := cursor_file_content ("copy_selection")
			Result.set_x_hotspot (0)
			Result.set_y_hotspot (0)
		end
		
	open_hand_cursor: EV_CURSOR is
		once
			Result := cursor_file_content ("open_hand")
			Result.set_x_hotspot (8)
			Result.set_y_hotspot (8)
		end
		
	closed_hand_cursor: EV_CURSOR is
		once
			Result := cursor_file_content ("closed_hand")
			Result.set_x_hotspot (8)
			Result.set_y_hotspot (8)
		end

feature {NONE} -- Implementation

	pixmap_width: INTEGER is 32
		-- Width in pixels of generated factory image
		
	pixmap_height: INTEGER is 32
		-- Height in pixels of generated factory image

	image_matrix: EV_PIXMAP is
			-- Matrix pixmap containing all of the screen cursors
		once
			Result := pixmap_file_content ("studio_cursor_matrix")
		end

	cursor_file_content (fn: STRING): EV_CURSOR is
			-- Load the cursor contained in file `fn'.ico or `fn'.xpm, depending on the platform.
		local
			a_pix: EV_PIXMAP
		do
			a_pix := pixmap_file_content (fn)
			create Result.make_with_pixmap (a_pix, a_pix.width // 2, a_pix.height // 2)
		end

	pixmap_path: DIRECTORY_NAME is
			-- Path to cursor pixmaps
		once
			create Result.make_from_string (eiffel_installation_dir_name)
			Result.extend_from_array (<<short_studio_name, "bitmaps", "cursor">>)
		end

	pixmap_lookup: HASH_TABLE [TUPLE [INTEGER, INTEGER], STRING] is
			-- Lookup hash table for Studio pixmaps
		once
			create Result.make (32)
			Result.put ([1, 1], "class")
			Result.put ([1, 2], "clientlnk")
			Result.put ([1, 3], "cluster")
			Result.put ([1, 4], "favorites_folder")
			Result.put ([1, 5], "feature")
			Result.put ([1, 6], "inheritlnk")
			Result.put ([1, 7], "interro")
			Result.put ([1, 8], "object")
			Result.put ([1, 9], "stopexec")
			Result.put ([1, 10], "Xclass")
			Result.put ([1, 11], "Xcluster")
			Result.put ([1, 12], "Xobject")
			Result.put ([1, 13], "Xfavorites_folder")
			Result.put ([1, 14], "Xfeature")
			Result.put ([1, 15], "Xinterro")
			Result.put ([1, 16], "Xstopexec")
			Result.put ([2, 1], "cut_selection")
			Result.put ([2, 2], "copy_selection")
			Result.put ([2, 3], "Xclass_list")
			Result.put ([2, 4], "class_list")
			Result.put ([2, 5], "closed_hand")
			Result.put ([2, 6], "open_hand")

			Result.compare_objects
		end

end -- class EB_SHARED_CURSORS
