indexing
	description: "[
		Objects defining the layout and content of a {ES_TBT_GRID}. Since this applies to a generic
		{TAGABLE_I}, an effective implementation must be provided for concrete tagable items.
		
		For tags representing classes or feature clickable items are created. Other special tags such as
		dates or times are shown in a readable format.
		
		Note: This class implements several routines which make use of project data. However by default
		      no project is available. Any descendant can redefine project related attributes to enable
		      that functionality.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	ES_TBT_GRID_LAYOUT [G -> TAGABLE_I]

inherit

	TAG_UTILITIES

	EB_CONSTANTS

feature {NONE} -- Access

	project: !E_PROJECT
			-- Project used to find classes and features
		require
			available: is_project_available
		do
		ensure
			project_usable: Result.initialized and Result.workbench.universe_defined and
			                Result.system_defined and then Result.universe.target /= Void
		end

feature -- Status report

	is_project_available: BOOLEAN
			-- Is `project' available and properly initialized?
		do
		end

	column_count: NATURAL
			-- Number of columns supported by `Current'
		do
			Result := 1
		ensure
			result_positive: Result > 0
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
				i > column_count.as_integer_32 or not Result
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
				Result := project.universe.class_named (a_name, l_group)
			end
		end

	is_feature_token (a_token: !STRING): BOOLEAN
			-- Does `a_token' represent a feature name?
		require
			a_token_valid: is_valid_token (a_token)
		do
			Result := a_token.starts_with ("feature:")
		end

	feature_from_token (a_token: !STRING; a_class: !EIFFEL_CLASS_C): ?E_FEATURE is
		require
			a_token_valid: is_valid_token (a_token)
			a_token_is_feature: is_feature_token (a_token)
		do

		end

	is_cluster_token (a_token: !STRING): BOOLEAN
			-- Does `a_token' represent a cluster name?
		require
			a_token_valid: is_valid_token (a_token)
		do
			Result := a_token.starts_with ("cluster:")
		end

	cluster_from_token (a_token: !STRING; a_library: ?CONF_LIBRARY): ?CONF_CLUSTER
			-- Cluster represented by token
		require
			a_token_valid: is_valid_token (a_token)
			a_token_is_cluster: is_cluster_token (a_token)
		do

		end

	is_library_token (a_token: !STRING): BOOLEAN
			-- Does `a_token' represent a library name?
		require
			a_token_valid: is_valid_token (a_token)
		do
			Result := a_token.starts_with ("library:")
		end

	library_from_token (a_token: !STRING): ?CONF_CLUSTER
			-- Cluster represented by token
		require
			a_token_valid: is_valid_token (a_token)
			a_token_is_library: is_library_token (a_token)
		do

		end

feature -- Basic functionality

	populate_header (a_header: !EV_GRID_HEADER) is
			-- Populate header with items
		require
			valid_item_count: a_header.count.as_natural_32 = column_count
		do
			--a_header.i_th (1).set_text ("Tags")
		end

	populate_node_row (a_row: !EV_GRID_ROW; a_node: !TAG_BASED_TREE_NODE [G]) is
			-- Populate row with tree node information
		require
			valid_item_count: a_row.count.as_natural_32 = column_count
		do
			a_row.set_item (1, new_token_item (a_node))
			fill_with_empty_items (a_row, 2)
		ensure
			items_attached: has_attached_items (a_row)
		end

	populate_item_row (a_row: !EV_GRID_ROW; a_item: !G)
			-- Populate row with item information
		require
			valid_item_count: a_row.count.as_natural_32 = column_count
			a_item_usable: a_item.is_interface_usable
		do
			a_row.set_item (1, create {EV_GRID_LABEL_ITEM}.make_with_text (a_item.name))
			fill_with_empty_items (a_row, 2)
		ensure
			items_attached: has_attached_items (a_row)
		end

	populate_untagged_row (a_row: !EV_GRID_ROW)
			-- Populate untagged row
		require
			valid_item_count: a_row.count.as_natural_32 = column_count
		do
			a_row.set_item (1, create {EV_GRID_LABEL_ITEM}.make_with_text ("<untagged>"))
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
			l_token, l_name: !STRING
			l_editor_item: EB_GRID_EDITOR_TOKEN_ITEM
			l_label_item: EV_GRID_LABEL_ITEM
			l_pixmap: EV_PIXMAP
		do
			l_token := a_node.token
			token_writer.new_line
			if l_token.starts_with ("class:") then
				l_name := l_token.substring (7, l_token.count)
				l_pixmap := pixmaps.icon_pixmaps.class_normal_icon
				if {l_class: !CLASS_I} class_from_name (l_name, Void) then
					token_writer.add_class (l_class)
				end
			elseif l_token.starts_with ("feature:") then
				l_name := l_token.substring (9, l_token.count)
				l_pixmap := pixmaps.icon_pixmaps.feature_routine_icon
				if {l_parent2: TAG_BASED_TREE_NODE [G]} a_node.parent then
					if {l_classi: CLASS_I} l_parent2.data then
						if l_classi.is_compiled then
							if {l_feature: E_FEATURE} l_classi.compiled_class.feature_with_name (l_name) then
								token_writer.add_feature (l_feature, l_name)
								a_node.set_data (l_feature)
							end
						end
					end
				end
			elseif l_token.starts_with ("cluster:") then
				l_name := l_token.substring (9, l_token.count)
				l_pixmap := pixmaps.icon_pixmaps.folder_cluster_icon
				if {l_cluster: CONF_CLUSTER} project.universe.cluster_of_name (l_name) then
					token_writer.add_group (l_cluster, l_name)
				end
			elseif l_token.starts_with ("library:") then
				l_name := l_token.substring (9, l_token.count)
				l_pixmap := pixmaps.icon_pixmaps.folder_library_icon
				if {l_library: CONF_LIBRARY} project.universe.group_of_name (l_name) then
					token_writer.add_group (l_library, l_name)
				end
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
				i > column_count.as_integer_32
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

end
