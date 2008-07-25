indexing
	description: "[
		Objects defining the layout and content of a {ES_TBT_GRID}. Since this applies to a generic
		{TAGABLE_I}, an effective implementation must be provided for concrete tagable items.
		
		For tags representing classes or feature clickable items are created. Other special tags such as
		dates or times are shown in a readable format.
	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_TBT_GRID_LAYOUT [G -> TAGABLE_I]

inherit
	SHARED_EIFFEL_PROJECT

	EB_CONSTANTS

feature {NONE} -- Access

	project: !E_PROJECT
			-- Project used to find classes and features
		deferred
		end

feature -- Status report

	column_count: NATURAL
			-- Number of columns supported by `Current'
		do
			Result := 1
		ensure
			result_positive: Result > 0
		end

feature {NONE} -- Query

	class_of_name (a_name: !STRING): ?CLASS_I
			-- Class in `project' with `a_name'. Void if no class with name exists.
		local
			l_uni: UNIVERSE_I
			l_list: LIST [CLASS_I]
		do
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
		local
			l_item: EV_GRID_ITEM
			l_eitem: EB_GRID_EDITOR_TOKEN_ITEM
			l_litem: EV_GRID_LABEL_ITEM
			l_pixmap: EV_PIXMAP
			l_token: !STRING
		do
			token_writer.new_line
			l_token := a_node.token
			if l_token.item (1) = '{' and l_token.item (l_token.count) = '}' then
				if {l_class: !CLASS_I} class_of_name (l_token.substring (2, l_token.count - 1)) then
					token_writer.add_class (l_class)
					l_pixmap := pixmaps.icon_pixmaps.class_normal_icon
				end
			end
			if not token_writer.last_line.empty then
				create l_eitem
				l_eitem.set_text_with_tokens (token_writer.last_line.content)
				if l_pixmap /= Void then
					l_eitem.set_pixmap (l_pixmap)
				end
				l_item := l_eitem
			else
				create l_litem.make_with_text (process_token (a_node.token))
				if l_pixmap /= Void then
					l_litem.set_pixmap (l_pixmap)
				end
				l_item := l_litem
			end
			a_row.set_item (1, l_item)
		end

	populate_item_row (a_row: !EV_GRID_ROW; a_item: !G)
			-- Populate row with item information
		require
			valid_item_count: a_row.count.as_natural_32 = column_count
		deferred
		end

	populate_untagged_row (a_row: !EV_GRID_ROW)
			-- Populate untagged row
		require
			valid_item_count: a_row.count.as_natural_32 = column_count
		do
			a_row.set_item (1, create {EV_GRID_LABEL_ITEM}.make_with_text ("<untagged>"))
		end

feature {NONE} -- Factory

	new_empty_item: !EV_GRID_ITEM
			-- Create an empty grid item
		do
			create Result
		end

	token_writer: EB_EDITOR_TOKEN_GENERATOR
			-- Token writer used to create clickable items
		once
			create Result.make
		end

feature {NONE} -- Implementation

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
