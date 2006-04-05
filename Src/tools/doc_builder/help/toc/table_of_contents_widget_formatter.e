indexing
	description: "Converts a table of contents structure to a corresponding tree widget."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	TABLE_OF_CONTENTS_WIDGET_FORMATTER
	
create
	make

feature -- Creation

	make is
			-- Create
		do
			create toc_widget.make
		end		

feature -- Access

	process_toc (a_toc: TABLE_OF_CONTENTS) is
			-- Process `a_toc'			
		do			
			process_toc_node (a_toc, toc_widget)
		end
		
	process_toc_node (a_node: TABLE_OF_CONTENTS_NODE; a_node_list: EV_TREE_NODE_LIST) is
			-- Process `a_node', creating widget nodes into `a_node_list'
		require
			a_node /= Void
		local
			l_item: TABLE_OF_CONTENTS_NODE
			l_children: ARRAYED_LIST [like a_node]			
			l_widget_item: TABLE_OF_CONTENTS_WIDGET_NODE
			l_is_parent: BOOLEAN
		do
			if a_node.has_child then
				l_children := a_node.children
				from
					l_children.start
				until
					l_children.after
				loop
					l_item := l_children.item
					l_is_parent := l_item.url_is_directory or l_item.has_child
					create l_widget_item.make (l_item.title, l_item.url, l_item.id, l_is_parent)
					a_node_list.extend (l_widget_item)
					if l_item.has_child then
						process_toc_node (l_item, l_widget_item)
					end
					l_children.forth
				end
			end			
		end		

	toc_widget: TABLE_OF_CONTENTS_WIDGET;
			-- Tree widget

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
end -- class TABLE_OF_CONTENTS_WIDGET_FORMATTER
