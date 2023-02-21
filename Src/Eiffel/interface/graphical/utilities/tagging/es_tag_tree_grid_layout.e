note
	description: "Summary description for {ES_TAG_TREE_GRID_LAYOUT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_TAG_TREE_GRID_LAYOUT [G -> TAG_ITEM]

inherit
	TAG_TREE_GRID_LAYOUT [G]
		redefine
			make,
			new_item
		end

	EC_TAG_TREE_NODE_VISITOR [G]

	EB_PIXMAPABLE_ITEM_PIXMAP_FACTORY
		export
			{NONE} all
		end

	SHARED_TEST_SERVICE
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make
			-- <Precursor>
		do
			Precursor
			create token_writer.make
		end

feature -- Access

	auto_size_column: like column_count
			-- Index of column with variable size
			--
			-- Note: can be zero to indicate that no column should have auto resize property.
		do
			Result := 1
		ensure
			valid_result: Result >= 0 and Result <= column_count
		end

feature {NONE} -- Access

	token_writer: EB_EDITOR_TOKEN_GENERATOR
			-- Token writer used to create clickable items

	last_pixmap: detachable EV_PIXMAP
			-- Last set pixmap to be used in item

feature -- Factory

	new_item (a_column: like column_count; a_grid: TAG_TREE_GRID [G]; a_node: TAG_TREE_NODE [G]): detachable EV_GRID_ITEM
			-- <Precursor>
		local
			l_editor_item: EB_GRID_EDITOR_TOKEN_ITEM
		do
			if a_column = 1 then
				last_pixmap := Void

				create l_editor_item
				if a_node = a_grid.common_parent then
					process_parents (a_node)
					last_pixmap := Void
				else
					a_node.process (Current)
				end
				l_editor_item.set_text_with_tokens (token_writer.last_line.content)
				token_writer.wipe_out_lines
				if attached last_pixmap as l_pixmap then
					l_editor_item.set_pixmap (l_pixmap)
				end
				Result := l_editor_item
			end
		end

feature {TAG_TREE_NODE} -- Basic operations

	process_node (a_node: TAG_TREE_NODE [G])
			-- <Precursor>
		do
			token_writer.process_basic_text (process_token (a_node.token))
		end

feature {EC_TAG_TREE_NODE} -- Basic operations

	process_class_node (a_node: EC_TAG_TREE_CLASS_NODE [G])
			-- <Precursor>
		do
			if attached a_node.item (project_access) as l_class then
				last_pixmap := pixmap_from_class_i (l_class)
				token_writer.add_class (l_class)
			else
				last_pixmap := pixmaps.icon_pixmaps.class_normal_icon
				process_ec_node (a_node)
			end
		end

	process_feature_node (a_node: EC_TAG_TREE_FEATURE_NODE [G])
			-- <Precursor>
		do
			if attached a_node.item (project_access) as l_feature then
				last_pixmap := pixmap_from_e_feature (l_feature)
				token_writer.add_feature (l_feature, a_node.name)
			else
				last_pixmap := pixmaps.icon_pixmaps.feature_routine_icon
				process_ec_node (a_node)
			end
		end

	process_library_node (a_node: EC_TAG_TREE_LIBRARY_NODE [G])
			-- <Precursor>
		do
			if attached a_node.item (project_access) as l_library then
				last_pixmap := pixmap_from_group (l_library)
				token_writer.add_group (l_library, a_node.name)
			else
				last_pixmap := pixmaps.icon_pixmaps.folder_library_icon
				process_ec_node (a_node)
			end
		end

	process_cluster_node (a_node: EC_TAG_TREE_CLUSTER_NODE [G])
			-- <Precursor>
		do
			if attached a_node.item (project_access) as l_cluster then
				last_pixmap := pixmap_from_group (l_cluster)
				token_writer.add_group (l_cluster, a_node.name)
			else
				last_pixmap := pixmaps.icon_pixmaps.folder_cluster_icon
				process_ec_node (a_node)
			end
		end

	process_override_node (a_node: EC_TAG_TREE_OVERRIDE_NODE [G])
			-- <Precursor>
		do
			if attached a_node.item (project_access) as l_override then
				last_pixmap := pixmap_from_group (l_override)
				token_writer.add_group (l_override, a_node.name)
			else
				last_pixmap := pixmaps.icon_pixmaps.folder_override_cluster_icon
				process_ec_node (a_node)
			end
		end

	process_directory_node (a_node: EC_TAG_TREE_DIRECTORY_NODE [G])
			-- <Precursor>
		local
			l_name: READABLE_STRING_32
		do
			if attached a_node.item (project_access) as l_cluster then
				l_name := a_node.name
				last_pixmap := pixmap_from_group_path (l_cluster, l_name)
				token_writer.add_group (l_cluster, l_name)
			else
				last_pixmap := pixmaps.icon_pixmaps.folder_override_cluster_icon
				process_ec_node (a_node)
			end
		end

feature {NONE} -- Implementation

	process_parents (a_node: TAG_TREE_NODE [G])
			-- Recursively process parents before processing given node.
			--
			-- `a_node': Node for which parents should be processed first.
		require
			a_node_attached: a_node /= Void
			a_node_active: a_node.is_active
			a_node_not_root: not a_node.is_root
		local
			l_parent: TAG_TREE_NODE [G]
		do
			l_parent := a_node.parent
			if not l_parent.is_root then
				process_parents (l_parent)
				token_writer.process_basic_text ("/")
			end
			a_node.process (Current)
		end

	process_ec_node (a_node: EC_TAG_TREE_NODE [G, ANY])
			-- Process {EC_TAG_TREE_NODE}.
		do
			token_writer.process_basic_text (a_node.name)
		end

	process_token (a_token: READABLE_STRING_GENERAL): STRING
			-- Replace underscores in `a_token' with whitespace
		local
			i: INTEGER
			c: CHARACTER
		do
			create Result.make (a_token.count)
			from
				i := 1
			until
				i > a_token.count
			loop
				c := a_token.code (i).to_character_8
				if c = '_' then
					Result.append_character (' ')
				else
					Result.append_character (c)
				end
				i := i + 1
			end
		end

note
	copyright: "Copyright (c) 1984-2023, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
