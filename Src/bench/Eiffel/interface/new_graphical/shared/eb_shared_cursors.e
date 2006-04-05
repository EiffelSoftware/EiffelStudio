indexing
	description:
		"Cursors used in the interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			Result := cursor_file_content (class_value)
		end

	cur_Class_list: EV_CURSOR is
		once
			Result := cursor_file_content (class_list_value)
		end

	cur_Favorites_folder: EV_CURSOR is
		once
			Result := cursor_file_content (favorites_folder_value)
		end

	cur_Object: EV_CURSOR is
		once
			Result := cursor_file_content (object_value)
		end

	cur_Setstop: EV_CURSOR is
		once
			Result := cursor_file_content (stopexec_value)
		end

	cur_Interro: EV_CURSOR is
		once
			Result := cursor_file_content (interro_value)
		end

	cur_Feature: EV_CURSOR is
		once
			Result := cursor_file_content (feature_value)
		end

	cur_Cluster: EV_CURSOR is
		once
			Result := cursor_file_content (cluster_value)
		end

	cur_Inherit_link: EV_CURSOR is
		once
			Result := cursor_file_content (inheritlnk_value)
		end

	cur_Client_link: EV_CURSOR is
		once
			Result := cursor_file_content (clientlnk_value)
		end

feature -- Non-Accepting cursor shapes

	cur_X_class: EV_CURSOR is
		once
			Result := cursor_file_content (Xclass_value)
		end

	cur_X_class_list: EV_CURSOR is
		once
			Result := cursor_file_content (Xclass_list_value)
		end

	cur_X_object: EV_CURSOR is
		once
			Result := cursor_file_content (Xobject_value)
		end

	cur_X_cluster: EV_CURSOR is
		once
			Result := cursor_file_content (Xcluster_value)
		end

	cur_X_Favorites_folder: EV_CURSOR is
		once
			Result := cursor_file_content (Xfavorites_folder_value)
		end

	cur_X_interro: EV_CURSOR is
		once
			Result := cursor_file_content (Xinterro_value)
		end

	cur_X_explain: EV_CURSOR is
		once
			Result := cursor_file_content (Xobject_value)
		end

	cur_X_setstop: EV_CURSOR is
		once
			Result := cursor_file_content (Xstopexec_value)
		end

	cur_X_feature: EV_CURSOR is
		once
			Result := cursor_file_content (Xfeature_value)
		end

	cur_X_client_link: EV_CURSOR is
		once
			Result := cursor_file_content (Xclientlnk_value)
		end

	cur_X_inherit_link: EV_CURSOR is
		once
			Result := cursor_file_content (Xinheritlnk_value)
		end

feature -- Other cursor

	cur_cut_selection: EV_CURSOR is
		once
			Result := cursor_file_content (cut_selection_value)
			Result.set_x_hotspot (0)
			Result.set_y_hotspot (0)
		end

	cur_copy_selection: EV_CURSOR is
		once
			Result := cursor_file_content (copy_selection_value)
			Result.set_x_hotspot (0)
			Result.set_y_hotspot (0)
		end

	open_hand_cursor: EV_CURSOR is
		once
			Result := cursor_file_content (open_hand_value)
			Result.set_x_hotspot (Result.width // 2)
			Result.set_y_hotspot (Result.height // 2)
		end

	closed_hand_cursor: EV_CURSOR is
		once
			Result := cursor_file_content (closed_hand_value)
			Result.set_x_hotspot (Result.width // 2)
			Result.set_y_hotspot (Result.height // 2)
		end

feature {NONE} -- Implementation

	pixmap_width: INTEGER is 32
		-- Width in pixels of generated factory image

	pixmap_height: INTEGER is 32
		-- Height in pixels of generated factory image

	image_matrix: EV_PIXMAP is
			-- Matrix pixmap containing all of the screen cursors
		once
			Result := load_pixmap_from_repository ("studio_cursor_matrix")
		end

	cursor_file_content (a_cursor_constant: INTEGER): EV_CURSOR is
			-- Load the cursor referenced from `a_cursor_constant'.
		local
			a_pix: EV_PIXMAP
		do
			a_pix := pixmap_from_constant (a_cursor_constant)
			create Result.make_with_pixmap (a_pix, a_pix.width // 2, a_pix.height // 2)
		end

	pixmap_path: DIRECTORY_NAME is
			-- Path to cursor pixmaps
		once
			create Result.make_from_string (eiffel_installation_dir_name)
			Result.extend_from_array (<<short_studio_name, "bitmaps", "cursor">>)
		end

	pixmap_lookup_table: ES_PIXMAP_LOOKUP_TABLE is
			-- Lookup hash table for Studio pixmaps
		once
			create Result.make_with_values (16, 2)
			Result.add_pixmap (1, 1, class_value)
			Result.add_pixmap (2, 1, clientlnk_value)
			Result.add_pixmap (3, 1, cluster_value)
			Result.add_pixmap (4, 1, favorites_folder_value)
			Result.add_pixmap (5, 1, feature_value)
			Result.add_pixmap (6, 1, inheritlnk_value)
			Result.add_pixmap (7, 1, interro_value)
			Result.add_pixmap (8, 1, object_value)
			Result.add_pixmap (9, 1, stopexec_value)
			Result.add_pixmap (10, 1, Xclass_value)
			Result.add_pixmap (11, 1, Xcluster_value)
			Result.add_pixmap (12, 1, Xobject_value)
			Result.add_pixmap (13, 1, Xfavorites_folder_value)
			Result.add_pixmap (14, 1, Xfeature_value)
			Result.add_pixmap (15, 1, Xinterro_value)
			Result.add_pixmap (16, 1, Xstopexec_value)
			Result.add_pixmap (1, 2, cut_selection_value)
			Result.add_pixmap (2, 2, copy_selection_value)
			Result.add_pixmap (3, 2, Xclass_list_value)
			Result.add_pixmap (4, 2, class_list_value)
			Result.add_pixmap (5, 2, closed_hand_value)
			Result.add_pixmap (6, 2, open_hand_value)
			Result.add_pixmap (7, 2, Xinheritlnk_value)
			Result.add_pixmap (8, 2, Xclientlnk_value)
		end

feature {NONE} -- Constants

	class_value,
	clientlnk_value,
	cluster_value,
	favorites_folder_value,
	feature_value,
	inheritlnk_value,
	interro_value,
	object_value,
	stopexec_value,
	Xclass_value,
	Xcluster_value,
	Xobject_value,
	Xfavorites_folder_value,
	Xfeature_value,
	Xinterro_value,
	Xstopexec_value,
	cut_selection_value,
	copy_selection_value,
	Xclass_list_value,
	class_list_value,
	closed_hand_value,
	open_hand_value,
	Xinheritlnk_value,
	Xclientlnk_value: INTEGER is unique;
		-- Constants used for pixmap lookup.

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

end -- class EB_SHARED_CURSORS
