indexing
	description: "[
		Objects defining the layout and content of a {ES_TAGABLE_GRID}. Since this applies to a generic
		{TAGABLE_I}, an descending implementation must be provided for concrete tagable items.
		
		For tags representing classes or feature clickable items are created. Other special tags such as
		dates or times are shown in a readable format.
		
		Note: This class implements several routines which make use of project data. However by default
		      no project is available. Any descendant can redefine project related attributes to enable
		      that functionality.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	ES_TAGABLE_GRID_LAYOUT [G -> TAGABLE_I]

inherit
	TAG_UTILITIES

	EB_CONSTANTS
		export
			{NONE} all
		end

	EB_PIXMAPABLE_ITEM_PIXMAP_FACTORY
		export
			{NONE} all
		end

feature -- Access

	project: !E_PROJECT
			-- Project used to find classes and features
		require
			available: is_project_available
		local
			l_project: like internal_project
		do
			l_project := internal_project
			check l_project /= Void end
			Result := l_project
		ensure
			project_usable: Result.initialized and Result.workbench.universe_defined and
			                Result.system_defined and then Result.universe.target /= Void
		end

feature {NONE} -- Access

	internal_project: ?like project
			-- Internal storage for `project'

feature -- Status report

	is_project_available: BOOLEAN
			-- Is `project' available and properly initialized?
		do
			Result := internal_project /= Void
		end

	column_count: INTEGER
			-- Number of columns supported by `Current'
		do
			Result := 1
		ensure
			result_positive: Result > 0
		end

	auto_size_column: INTEGER
			-- Index of column with variable size
			--
			-- Note: Can be zero to indicate that no column should have auto resize property.
		do
			Result := name_column
		ensure
			result_not_negative: Result >= 0
			result_small_enough: Result <= column_count
		end

	column_width (a_index: INTEGER): INTEGER
			-- Width of column at given index
			--
			-- `a_index': Index of column for which width should be returned.
		require
			a_index_positive: a_index > 0
			a_index_small_enough: a_index <= column_count
			a_index_not_auto_size: a_index /= auto_size_column
		do
		ensure
			result_not_negative: Result >= 0
		end

feature -- Status setting

	set_project (a_project: like internal_project)
			-- Set project to be used to generate grid items
		do
			internal_project := a_project
		ensure
			project_set: internal_project = a_project
		end

feature -- Query

	has_attached_items (a_row: !EV_GRID_ROW): BOOLEAN
			-- Are all items of `a_row' attached?
		local
			i: INTEGER
		do
			from
				i := 1
				Result := True
			until
				i > column_count or not Result
			loop
				Result := a_row.item (i) /= Void
				i := i + 1
			end
		end

feature {NONE} -- Query

	class_from_name (a_name: !STRING; a_group: ?CONF_GROUP): ?CLASS_I
			-- Class in `project' with `a_name'. Void if no class with name exists.
		local
			l_group: CONF_GROUP
		do
			if a_group /= Void then
				l_group := a_group
			else
				if not project.system.system.root_creators.is_empty then
					l_group := project.system.system.root_creators.first.cluster
				end
			end
			if l_group /= Void then
				Result := project.universe.safe_class_named (a_name, l_group)
			end
		end

feature -- Basic functionality

	populate_header (a_header: !EV_GRID_HEADER) is
			-- Populate header with items
		require
			valid_item_count: a_header.count = column_count
		do
		end

	populate_node_row (a_row: !EV_GRID_ROW; a_node: !TAG_BASED_TREE_NODE [G]) is
			-- Populate row with tree node information
		require
			valid_item_count: a_row.count = column_count
		do
			a_row.set_item (1, new_token_item (a_node))
			fill_with_empty_items (a_row, 2)
		ensure
			items_attached: has_attached_items (a_row)
		end

	populate_item_row (a_row: !EV_GRID_ROW; a_item: !G)
			-- Populate row with item information
		require
			valid_item_count: a_row.count = column_count
			a_item_usable: a_item.is_interface_usable
		do
			a_row.set_item (1, create {EV_GRID_LABEL_ITEM}.make_with_text (a_item.name))
			fill_with_empty_items (a_row, 2)
		ensure
			items_attached: has_attached_items (a_row)
		end

	populate_text_row (a_row: !EV_GRID_ROW; a_text: !STRING)
			-- Populate untagged row
		require
			valid_item_count: a_row.count = column_count
		do
			a_row.set_item (1, create {EV_GRID_LABEL_ITEM}.make_with_text (a_text))
			fill_with_empty_items (a_row, 2)
		ensure
			items_attached: has_attached_items (a_row)
		end

feature {NONE} -- Factory

	new_empty_item: !EV_GRID_ITEM
			-- Create an empty grid item
		do
			create Result
		end

	new_label_item (a_token: !STRING): !EV_GRID_LABEL_ITEM
			-- Create a new label item
			--
			-- `a_token': Text used in new label item.
		do
			create Result.make_with_text (a_token)
		end

	new_token_item (a_node: !TAG_BASED_TREE_NODE [G]): !EV_GRID_ITEM is
			-- Create new item according to given node.
			--
			-- `a_node': Node for which token item should be created.
		local
			l_token: !STRING
			l_name, l_uuid: ?STRING
			l_editor_item: EB_GRID_EDITOR_TOKEN_ITEM
			l_label_item: EV_GRID_LABEL_ITEM
			l_pixmap: EV_PIXMAP
			l_pnode: ?TAG_BASED_TREE_NODE [G]
			l_cluster: ?CONF_CLUSTER
			l_library: CONF_LIBRARY
			l_list: LIST [CONF_LIBRARY]
		do
			l_token := a_node.token
			token_writer.new_line
			if {l_pnode2: TAG_BASED_TREE_NODE [G]} a_node.parent then
				l_pnode := l_pnode2
				if {l_data: CONF_CLUSTER} l_pnode.data then
					l_cluster := l_data
				elseif {l_lib_data: CONF_LIBRARY} l_pnode.data then
					l_library := l_lib_data
				end
			end
			if l_token.starts_with (class_prefix) and l_token.count > class_prefix.count then
				l_name := l_token.substring (class_prefix.count + 1, l_token.count)
				if {l_class: !CLASS_I} class_from_name (l_name, l_cluster) then
					a_node.set_data (l_class)
					token_writer.add_class (l_class)
					l_pixmap := pixmap_from_class_i (l_class)
				else
					l_pixmap := pixmaps.icon_pixmaps.class_normal_icon
				end
			elseif l_token.starts_with (feature_prefix) and l_token.count > feature_prefix.count then
				l_name := l_token.substring (feature_prefix.count + 1, l_token.count)
				l_pixmap := pixmaps.icon_pixmaps.feature_routine_icon
				if l_pnode /= Void then
					if {l_classi: CLASS_I} l_pnode.data then
						if l_classi.is_compiled and then l_classi.compiled_class.has_feature_table then
							if {l_feature: E_FEATURE} l_classi.compiled_class.feature_with_name (l_name) then
								token_writer.add_feature (l_feature, l_name)
								a_node.set_data (l_feature)
							end
						end
					end
				end
			elseif l_token.starts_with (cluster_prefix) and l_token.count > cluster_prefix.count then
				l_name := l_token.substring (cluster_prefix.count + 1, l_token.count)
				l_pixmap := pixmaps.icon_pixmaps.folder_cluster_icon
				if l_pnode /= Void then
					if l_cluster /= Void then
						l_cluster := l_cluster.target.clusters.item (l_name)
					elseif l_library /= Void then
						l_cluster := l_library.library_target.clusters.item (l_name)
					end
				end
				if l_cluster = Void and l_library = Void then
					l_cluster := project.universe.cluster_of_name (l_name)
				end
				if l_cluster /= Void then
					token_writer.add_group (l_cluster, l_name)
					a_node.set_data (l_cluster)
				end
			elseif l_token.starts_with (override_prefix) and l_token.count > override_prefix.count  then
				l_name := l_token.substring (override_prefix.count + 1, l_token.count)
				l_pixmap := pixmaps.icon_pixmaps.folder_override_cluster_icon
				if l_pnode /= Void then
					if l_cluster /= Void then
						l_cluster := l_cluster.target.overrides.item (l_name)
					elseif l_library /= Void then
						l_cluster := l_library.library_target.overrides.item (l_name)
					end
				end
				if l_cluster = Void then
					l_cluster := project.universe.cluster_of_name (l_name)
				end
				if l_cluster /= Void then
					token_writer.add_group (l_cluster, l_name)
					a_node.set_data (l_cluster)
				end
			elseif l_token.starts_with (library_prefix) and l_token.count > library_prefix.count then
				if l_token.count > 37 + library_prefix.count then
					l_name := l_token.substring (library_prefix.count + 1, l_token.count - 37)
					l_uuid := l_token.substring (l_token.count - 35, l_token.count)
					check l_uuid /= Void end
					if (create {UUID}.default_create).is_valid_uuid (l_uuid) then
						l_list := project.universe.library_of_uuid (create {UUID}.make_from_string (l_uuid), True)
						if not l_list.is_empty then
							from
								l_list.start
							until
								l_list.after
							loop
								if l_list.item_for_iteration.target = project.universe.target or
								   l_list.item_for_iteration = l_list.last
								then
									token_writer.add_group (l_list.item_for_iteration, l_name)
									a_node.set_data (l_list.item_for_iteration)
									l_list.finish
								end
								l_list.forth
							end
						end
					end
				else
					l_name := l_token.substring (library_prefix.count + 1, l_token.count)
				end
				l_pixmap := pixmaps.icon_pixmaps.folder_library_icon
			elseif False then
				-- More tokens to come
			else

			end


			if not token_writer.last_line.empty then
				create l_editor_item
				l_editor_item.set_text_with_tokens (token_writer.last_line.content)
				if l_pixmap /= Void then
					l_editor_item.set_pixmap (l_pixmap)
				end
				Result := l_editor_item
			else
				if l_name /= Void then
					l_label_item := new_label_item (l_name)
				else
					l_label_item := new_label_item (process_token (l_token))
				end
				if l_pixmap /= Void then
					l_label_item.set_pixmap (l_pixmap)
				end
				Result := l_label_item
			end
		end

	token_writer: EB_EDITOR_TOKEN_GENERATOR
			-- Token writer used to create clickable items
		once
			create Result.make
		end

feature {NONE} -- Implementation

	fill_with_empty_items (a_row: !EV_GRID_ROW; a_start: INTEGER)
			-- Fill missing items of row with empty items.
			--
			-- `a_row': Row to be filled with empty items
			-- `a_start': Index of first empty.
		local
			i: INTEGER
		do
			from
				i := a_start
			until
				i > column_count
			loop
				a_row.set_item (i, new_empty_item)
				i := i + 1
			end
		end

	process_token (a_token: !STRING): !STRING is
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
				c := a_token.item (i)
				if c = '_' then
					Result.append_character (' ')
				else
					Result.append_character (c)
				end
				i := i + 1
			end
		end

feature {NONE} -- Constants

	name_column: INTEGER = 1

end
