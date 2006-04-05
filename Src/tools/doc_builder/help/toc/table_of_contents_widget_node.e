indexing
	description: "Table of contents node as widget."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	TABLE_OF_CONTENTS_WIDGET_NODE
	
inherit
	EV_DYNAMIC_TREE_ITEM
	
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
			if node /= Void and then node.has_child then
				set_subtree_function (agent get_children)
			end			
			
			if is_heading then
				set_collapse_pixmap (folder_closed_icon)
				set_expand_pixmap (folder_open_icon)
				set_pixmap (folder_closed_icon)
				expand_actions.extend (agent toggle_expand (True))
				collapse_actions.extend (agent toggle_expand (False))				
			else
				set_pixmap (file_icon)
			end
					-- Display
			set_text (a_title)			
			
					-- Pick and drop
--			set_pebble (Current)
--			drop_actions.extend (agent move_node)
--			drop_actions.set_veto_pebble_function (agent can_insert_or_move_node)			
			
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
				set_expand_pixmap (a_node.icon_pixmap)
				set_collapse_pixmap (a_node.icon_pixmap)
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

feature -- Actions

--	move_node (a_node: like Current) is
--			-- Move `a_node' into Current
--		require
--			insertable: can_insert_or_move_node (a_node)
--		do
--			if not (a_node = Current) then
--					-- Remove actual node from its parent
--				a_node.node.parent.delete_node (a_node.node.id)
--					--Remove graphical node from it's parent
--				a_node.parent.prune (a_node)
--					-- Add actual node to Current
--				node.add_node (a_node.node)
--				
--				if not application.shift_pressed then
--					extend (a_node)
--				else
--					parent.go_i_th (parent.index_of (Current, 1))
--					parent.put_right (a_node)
--				end
--				
--				a_node.enable_select
--				parent_widget.set_modified (True)
--			end
--		end		
		
	move_node (up: BOOLEAN) is
			-- Move `a_node'.  If up move `up' if not, move down.
		local
			l_index: INTEGER
			l_parent: like parent			
		do					
			if up then
				l_index := node.parent.children.index_of (node, 1)
				if l_index = 1 and then node.parent.parent /= Void then
					node.parent.delete_node (node.id)
					node.parent.parent.add_node (node)
					
					parent.prune (Current)
					l_parent ?= parent.parent
					l_parent.extend (Current)
				else											
					node.parent.delete_node (node.id)
					node.parent.children.put_i_th (node, l_index - 1)
				end
			else
				
			end
			
			Current.enable_select
			parent_widget.set_modified (True)		
		end	

	can_insert_or_move_node (a_node: like Current): BOOLEAN is
			-- Can `a_node' be added into Current?
		do
			Result := a_node /= Current
		end

	open_file is
			-- Open Current as file
		do
			if file_url /= Void and then not file_url.is_empty then
				Shared_document_manager.load_document_from_file (file_url)
			end	
		end		

feature -- Status Setting

	set_expand_pixmap (a_pixmap: EV_PIXMAP) is
			-- Set pixmap when expanded.
		do
			expand_pixmap := a_pixmap	
		end
		
	set_collapse_pixmap (a_pixmap: EV_PIXMAP) is
			-- Set pixmap when collapsed.
		do
			collapse_pixmap := a_pixmap	
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
		do			
			create Result.make (5)
			if not is_currently_populating then
				is_currently_populating := True
				if node /= Void and then node.has_child then				
					from
						node.children.start				
					until
						node.children.after
					loop
						l_node := node.children.item
						create l_widget_node.make_from_node (l_node)					
						Result.extend (l_widget_node)
						node.children.forth
					end				
				end		
			end
			is_currently_populating := False
		end	
		
	is_currently_populating: BOOLEAN

	toggle_expand (on: BOOLEAN) is
			-- Toggle expansion
		do
			if on then
				set_pixmap (expand_pixmap)
			else
				set_pixmap (collapse_pixmap)
			end	
		end	

	expand_pixmap,
	collapse_pixmap: like pixmap
			-- Expand and collapse pixmap

feature {NONE} -- Properties Widget

	properties_widget: EV_EDITABLE_LIST
			-- Properties widget

	build_properties_list is
			-- Build list of both editable and read-only properties
		local			
			l_row: EV_MULTI_COLUMN_LIST_ROW
			l_list: ARRAYED_LIST [STRING_32]
			l_url: STRING
		do				
			create properties_widget.make (Application_window)

					-- Column Titles
			properties_widget.set_column_titles (<<"Property", "Value">>)

					-- Title
			create l_row
			create l_list.make_from_array (<<("Title").to_string_32, text>>)
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

	application: EV_APPLICATION is 
		once
			create Result
		end

invariant
	has_title: title /= Void
	valid_id: id > 0
			
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
end -- class TABLE_OF_CONTENTS_WIDGET_NODE
