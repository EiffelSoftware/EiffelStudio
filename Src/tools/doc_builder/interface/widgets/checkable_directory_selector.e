indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CHECKABLE_DIRECTORY_SELECTOR

inherit
--	UTILITY_FUNCTIONS
--
--	SHARED_OBJECTS

	DOCUMENT_SELECTOR
		redefine
			make,
			get_children,
			internal_tree
		end

create
	make,
	make_with_data

feature -- Access

	make (root_directory: STRING; widget: EV_CHECKABLE_TREE) is
			-- Make with `root_directory'
		do
			Precursor (root_directory, widget)
		end		
		
--	make (root_directory: STRING; widget: EV_CHECKABLE_TREE) is
--			-- Make with `root_directory'
--		require
--			has_root: root_directory /= Void
--			has_widget: widget /= Void
--		local
--			top_node: EV_CHECKABLE_TREE_ITEM
--			root: DIRECTORY
--		do
--			default_create
--			internal_tree := widget
--			create root.make_open_read (root_directory)
--			create top_node.make_with_text (short_name (root.name))
--			top_node.set_pixmap (Shared_constants.Graphical_constants.Folder_closed_icon)
--			internal_tree.extend (top_node)
--			initialize (root, top_node)
--		end			
		
	make_with_data (root_directory: STRING; widget: EV_CHECKABLE_TREE; checked_items_data: ARRAYED_LIST [STRING]) is
			-- Make with `root_directory'
		require
			has_root: root_directory /= Void
			has_widget: widget /= Void
		do
			checked_item_data := checked_items_data
			make (root_directory, widget)			
		end	
		
--	initialize (root_dir: DIRECTORY; a_node: EV_CHECKABLE_TREE_ITEM) is
--			-- Return child directory and file nodes list
--		require
--			dir_not_void: root_dir /= Void
--		local
--			node: EV_CHECKABLE_TREE_ITEM
--			dir,
--			child_dir: DIRECTORY
--			cnt: INTEGER
--			l_last_entry: STRING
--			l_filename: FILE_NAME
--		do
--			from
--				cnt := 0
--				root_dir.open_read
--				root_dir.start
--			until
--				cnt = root_dir.count
--			loop
--				root_dir.readentry
--				l_last_entry := root_dir.lastentry
--				if l_last_entry /= Void and then not l_last_entry.is_equal (".") and then not l_last_entry.is_equal ("..") then
--					create l_filename.make_from_string (root_dir.name)
--					l_filename.extend (root_dir.lastentry)
--					create dir.make (l_filename.string)
--					if dir.exists then
--						create child_dir.make (dir.name)
--						create node.make_with_text (short_name (dir.name))
--						node.set_pixmap (Shared_constants.Graphical_constants.Folder_closed_icon)
--						node.set_data (child_dir.name)
--						internal_tree.register_checkable_node (node)
--						if checked_item_data /= Void and then checked_item_data.has (child_dir.name) then
--							node.set_checked
--						end
--						a_node.extend (node)													
--						initialize (child_dir, node)
--					end
--				end
--				cnt := cnt + 1
--			end	
--		end		

	get_children (root_dir: DIRECTORY; root_node: EV_DYNAMIC_TREE_ITEM): ARRAYED_LIST [EV_TREE_NODE] is
			-- Return child directory and file nodes list
		local
			node: EV_DYNAMIC_TREE_ITEM
			dir: DIRECTORY
			cnt: INTEGER
			file: RAW_FILE
			l_last_entry: STRING
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
						node.set_data (dir.name)
						Result.extend (node)
						if checked_item_data /= Void and then checked_item_data.has (dir.name) then
							internal_tree.check_item (node)
						end
					end
				end
				cnt := cnt + 1
			end	
		end		

feature {NONE} -- Implementation

	internal_tree: EV_CHECKABLE_TREE

	checked_item_data: ARRAYED_LIST [STRING];

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
end
