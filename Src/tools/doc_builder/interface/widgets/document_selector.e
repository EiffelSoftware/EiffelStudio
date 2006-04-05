indexing
	description: "Tree selector for browsing projects and documents."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DOCUMENT_SELECTOR

inherit
	UTILITY_FUNCTIONS

	SHARED_OBJECTS

create
	make
	
feature -- Creation

	make (root_directory: STRING; widget: EV_TREE) is
			-- Make with `root_directory'
		require
			has_root: root_directory /= Void
			has_widget: widget /= Void
		local
			top_node: EV_DYNAMIC_TREE_ITEM
		do
			default_create
			internal_tree := widget
			create root.make_open_read (root_directory)
			create top_node.make_with_function (agent get_children (root, top_node))
			top_node.set_pixmap (Shared_constants.Graphical_constants.Folder_closed_icon)
			top_node.set_text (short_name (root.name))
			internal_tree.extend (top_node)
		end		

feature -- Commands

	clear is
			-- Wipe out widget
		do
			internal_tree.wipe_out	
		end		

feature -- Access
	
	root: DIRECTORY
			-- Root directory

feature -- Query
	
	get_children (root_dir: DIRECTORY; root_node: EV_DYNAMIC_TREE_ITEM): ARRAYED_LIST [EV_TREE_NODE] is
			-- Return child directory and file nodes list
		require
			dir_not_void: root_dir /= Void
		local
			node: EV_DYNAMIC_TREE_ITEM
			file_node: EV_TREE_ITEM
			dir: DIRECTORY
			cnt: INTEGER
			file: RAW_FILE
			l_last_entry,
			l_file_type: STRING
			l_file_pixmap: EV_PIXMAP
			l_filename: FILE_NAME
		do
			create Result.make (5)
			from
				cnt := 0
				root_dir.open_read
				root_dir.start
			until
				cnt = root_dir.count
			loop
				root_dir.readentry
				l_last_entry := root_dir.lastentry
				if l_last_entry /= Void and then not l_last_entry.is_equal (".") and then not l_last_entry.is_equal ("..") and not l_last_entry.is_equal ("CVS") then
					create l_filename.make_from_string (root_dir.name)
					l_filename.extend (root_dir.lastentry)
					create file.make (l_filename.string)
					create dir.make (l_filename.string)
					if dir.exists then
						create node.make_with_function (agent get_children (dir, node))
						node.set_text (short_name (dir.name))
						node.set_pixmap (Shared_constants.Graphical_constants.Folder_closed_icon)
						Result.extend (node)
					elseif file.exists then 
						l_file_type := file_type (short_name (file.name))
						if shared_constants.application_constants.allowed_file_types.has (l_file_type) then
							l_file_pixmap := shared_constants.application_constants.file_type_icons.item (l_file_type)	
							create file_node.make_with_text (root_dir.lastentry)
							file_node.pointer_button_press_actions.extend (agent on_button_pressed (?,?,?,?,?,?,?,?, file.name))
							file_node.set_pixmap (l_file_pixmap)
							file_node.set_pebble (file.name)
							Result.extend (file_node)	
						end											
					end
				end
				cnt := cnt + 1
			end	
		end		

feature {NONE} -- Implementation

	on_button_pressed (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER; name: STRING) is
			-- Button pressed
		do
			if a_button = 1 then				
				Shared_document_manager.load_document_from_file (name)	
			end
		end		

	internal_tree: EV_TREE
			-- Internal widget
			
invariant
	has_root: root /= Void
	has_widget: internal_tree /= Void

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
end -- class DOCUMENT_SELECTOR
