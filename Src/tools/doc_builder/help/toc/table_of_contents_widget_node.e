indexing
	description: "Table of contents node as widget."
	date: "$Date$"
	revision: "$Revision$"

class
	TABLE_OF_CONTENTS_WIDGET_NODE
	
inherit
	EV_DYNAMIC_TREE_ITEM
		redefine
			set_pixmap
		end
	
	TABLE_OF_CONTENTS_CONSTANTS
		undefine
			copy,
			default_create,
			is_equal
		end

	SHARED_OBJECTS
		undefine
			copy,
			default_create,
			is_equal
		end

create
	make,
	make_from_node

feature -- Creation

	make (a_title, a_url: STRING; a_id: INTEGER; heading: BOOLEAN) is
			-- Create
		require
			has_title: a_title /= Void
			valid_id: a_id > 0
		do
			default_create
			id := a_id
			file_url := a_url
			is_heading := heading
			set_included (True)
			if node /= Void and then node.has_child then
				set_subtree_function (agent get_children)
			end			
			
					-- Display
			set_text (a_title)			
			
					-- Pick and drop
			set_pebble (Current)
			drop_actions.extend (agent move_node)
			drop_actions.set_veto_pebble_function (agent can_insert_node)			
			
					-- Gui Agents
			pointer_double_press_actions.force_extend (agent open_file)			
			select_actions.extend (agent build_properties_list)			
		ensure
			has_title: title /= Void
			valid_id: id > 0
		end

	make_from_node (a_node: TABLE_OF_CONTENTS_NODE) is
			-- Make from a node
		require
			node_not_void: a_node /= Void
		local
			l_is_parent: BOOLEAN
			l_icon: STRING
		do
			node := a_node
			l_is_parent := node.url_is_directory or node.has_child
			make (node.title, node.url, node.id, l_is_parent)
			l_icon := a_node.icon
			if l_icon /= Void then
				set_pixmap (a_node.icon_pixmap)
			end
		end		

feature -- Access

	title: STRING is
			-- Title in widget
		do
			Result := text
		end
			
	file_url: STRING
			-- Associated file url
			
	id: INTEGER
			-- Unique identifier in widget

	is_heading: BOOLEAN
			-- Heading node?

	node: TABLE_OF_CONTENTS_NODE
			-- Node

feature -- Query

	include: BOOLEAN
			-- Include node in sorting operations?  Applies to children also.

feature {TABLE_OF_CONTENTS_NODE_AGENT_FACTORY} -- Actions

	move_node (a_node: like Current) is
			-- Move `a_node' into Current
		require
			insertable: can_insert_node (a_node)
		do
			a_node.parent.prune (a_node)
			extend (a_node)
			a_node.enable_select
			parent_widget.set_modified (True)
		end		

	can_insert_node (a_node: like Current): BOOLEAN is
			-- Can `a_node' be added into Current?
		do
			Result := is_heading and then a_node /= Current
		end

	open_file is
			-- Open Current as file
		do
			if file_url /= Void and then not file_url.is_empty then
				Shared_document_manager.load_document_from_file (file_url)
			end	
		end		

feature -- Status Setting

	set_pixmap (a_pixmap: EV_PIXMAP) is
			-- Set pixmap.  Since a custom icon is being used we wipe out
			-- previous expand and collapse agents.
		do
			expand_actions.wipe_out
			collapse_actions.wipe_out
			Precursor (a_pixmap)
		ensure then
			has_no_expand_actions: expand_actions.is_empty
			has_no_collapse_actions: collapse_actions.is_empty
		end

	set_included (a_flag: BOOLEAN) is
			-- Toggle `included'.
		do
			include := a_flag
			if not include then
				set_pixmap (Excluded_node_icon)
			else
				if is_heading then
					if is_expanded then
						set_pixmap (Folder_open_icon)
					else
						set_pixmap (Folder_closed_icon)
					end
					expand_actions.extend (agent set_pixmap (Folder_open_icon))
					collapse_actions.extend (agent set_pixmap (Folder_closed_icon))
				else
					set_pixmap (File_icon)
				end								
			end
		end		

feature {NONE} -- Implementation

	parent_widget: TABLE_OF_CONTENTS_WIDGET is
			-- Parent widget
		once
			Result ?= parent_tree
		end		

	get_children: ARRAYED_LIST [EV_TREE_NODE] is
			-- Return children nodes
		local
			l_node: TABLE_OF_CONTENTS_NODE
			l_widget_node: TABLE_OF_CONTENTS_WIDGET_NODE
			l_is_heading: BOOLEAN
		do
			create Result.make (5)
			if node /= Void and then node.has_child then				
				from
					node.children.start				
				until
					node.children.after
				loop
					l_node := node.children.item
					l_is_heading := l_node.url_is_directory or l_node.has_child
					create l_widget_node.make_from_node (l_node)					
					Result.extend (l_widget_node)
					node.children.forth
				end
			end
		end	

feature {NONE} -- Properties Widget

	properties_widget: EV_EDITABLE_LIST
			-- Properties widget

	build_properties_list is
			-- Build list of both editable and read-only properties
		local			
			l_row: EV_MULTI_COLUMN_LIST_ROW
			l_list: ARRAYED_LIST [STRING]
			l_url: STRING
		do				
			create properties_widget.make (Application_window)

					-- Column Titles
			properties_widget.set_column_titles (<<"Property", "Value">>)

					-- Title
			create l_row
			create l_list.make_from_array (<<"Title", text>>)
			l_row.append (l_list)
			properties_widget.extend (l_row)

					-- Url			
			if file_url /= Void then
				l_url := file_url
			else
				create l_url.make_empty
			end			
			create l_row
			create l_list.make_from_array (<<"File Url", l_url>>)
			l_row.append (l_list)
			properties_widget.extend (l_row)
			
					
			properties_widget.set_column_editable (True, 2)
			properties_widget.end_edit_actions.extend (agent update_display)
			Application_window.set_toc_node_widget (properties_widget)
		end	

	update_display is
			-- Synchronize Current with associated widgets
		do
			set_text (properties_widget.i_th (1).i_th (2))
			file_url := properties_widget.i_th (2).i_th (2)
		end		

invariant
	has_title: title /= Void
	valid_id: id > 0
			
end -- class TABLE_OF_CONTENTS_WIDGET_NODE
