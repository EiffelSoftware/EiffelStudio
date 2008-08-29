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

	is_class_token (a_token: !STRING): BOOLEAN
			-- Does `a_token' represent a class name?
		require
			is_valid_token (a_token)
		do
			Result := a_token.item (1) = '{' and a_token.item (a_token.count) = '}'
		end

	class_name (a_token: !STRING): !STRING
			-- Extract actual class name from class token
		require
			valid_token: is_valid_token (a_token)
			class_token: is_class_token (a_token)
		do
			Result := a_token.substring (2, a_token.count - 1)
		end

	class_of_name (a_name: !STRING): ?CLASS_I
			-- Class in `project' with `a_name'. Void if no class with name exists.
		local
			l_uni: UNIVERSE_I
			l_list: LIST [CLASS_I]
		do
			if is_project_available then
				l_uni := project.universe
				l_list := l_uni.classes_with_name (a_name)
				from
					l_list.start
				until
					l_list.after or Result /= Void
				loop
					Result := l_list.item_for_iteration
					l_list.forth
				end
			end
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
			a_row.set_item (1, new_token_item (a_node.token, a_node.tag))
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
			create Result.make_with_text (process_token (a_token))
		end

	new_token_item (a_token: !STRING; a_tag: !STRING): !EV_GRID_ITEM
			-- Create new item based on a tag.
			--
			-- `a_token': last token of the original tag.
			-- `a_tag': prefix of original tag where last token has been removed (may be empty).
		local
			l_editor_item: EB_GRID_EDITOR_TOKEN_ITEM
			l_label_item: EV_GRID_LABEL_ITEM
			l_pixmap: EV_PIXMAP
		do
			token_writer.new_line
			if is_class_token (a_token) then
				if {l_class: !CLASS_I} class_of_name (class_name (a_token)) then
					token_writer.new_line
					token_writer.add_class (l_class)
					l_pixmap := pixmaps.icon_pixmaps.class_normal_icon
				end
			end
			if not token_writer.last_line.empty then
				create l_editor_item
				l_editor_item.set_text_with_tokens (token_writer.last_line.content)
				if l_pixmap /= Void then
					l_editor_item.set_pixmap (l_pixmap)
				end
				Result := l_editor_item
			else
				l_label_item := new_label_item (a_token)
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
