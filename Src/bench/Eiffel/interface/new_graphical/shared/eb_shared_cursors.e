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

feature {NONE} -- Implementation

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

end -- class EB_SHARED_CURSORS
