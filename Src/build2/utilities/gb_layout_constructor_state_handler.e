indexing
	description: "[
			Objects that allow you to temporarily store and retrieve the expanded state of all items in the
			GB_LAYOUT_CONSTRUCTOR.
				]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_LAYOUT_CONSTRUCTOR_STATE_HANDLER

create
	make_with_components

feature {NONE} -- Initialization

	components: GB_INTERNAL_COMPONENTS
		-- Access to a set of internal components for an EiffelBuild instance.

	make_with_components (a_components: GB_INTERNAL_COMPONENTS) is
			-- Create `Current' and assign `a_components' to `components'.
		require
			a_components_not_void: a_components /= Void
		do
			components := a_components
			default_create
		ensure
			components_set: components = a_components
		end

feature -- Access

	store_layout_constructor is
			-- Store representation of `layout_constructor' in `state_tree'.
		local
			tree_item: GB_BOOLEAN_TREE_ITEM
			layout_constructor_item: GB_LAYOUT_CONSTRUCTOR_ITEM
		do
			create state_tree
			create tree_item
			layout_constructor_item ?= components.tools.layout_constructor.first
			check
				not_void: layout_constructor_item /= Void
			end
			store_item (tree_item, layout_constructor_item)
			state_tree.set_root_node (tree_item)
		end

	restore_layout_constructor is
			-- Restore representation of `layout_constructor' from `state_tree'.
		local
			layout_constructor_item: GB_LAYOUT_CONSTRUCTOR_ITEM
		do
			layout_constructor_item ?= components.tools.layout_constructor.first
			reset_item (state_tree.root_node, layout_constructor_item)
		end

feature {NONE} -- Implementation

	reset_item (tree_item: GB_BOOLEAN_TREE_ITEM; layout_item: GB_LAYOUT_CONSTRUCTOR_ITEM) is
			-- Reset state of `layout_item' from `tree_item'.
		local
			current_tree_item: GB_BOOLEAN_TREE_ITEM
			layout_constructor_item: GB_LAYOUT_CONSTRUCTOR_ITEM
		do
			from
				tree_item.start
				layout_item.start
			until
				tree_item.off
			loop
				current_tree_item := tree_item.item
				layout_constructor_item ?= layout_item.item
				check
					not_void: layout_constructor_item /= Void
				end
				reset_item (current_tree_item, layout_constructor_item)
				if tree_item.state then
					layout_item.expand
				else
					layout_item.collapse
				end
				if tree_item.selected then
					layout_item.enable_select
				end
				layout_item.forth
				tree_item.forth
			end
		end


	store_item (tree_item: GB_BOOLEAN_TREE_ITEM; layout_item: GB_LAYOUT_CONSTRUCTOR_ITEM) is
			-- Store representation of `layout_item' into `tree_item'.
		local
			new_tree_item: GB_BOOLEAN_TREE_ITEM
			temp_item: GB_LAYOUT_CONSTRUCTOR_ITEM
		do
			if layout_item.is_expanded then
				tree_item.enable_state
			else
				tree_item.disable_state
			end
			if layout_item.is_selected then
				tree_item.enable_selected
			else
				tree_item.disable_selected
			end
			from
				layout_item.start
			until
				layout_item.off
			loop
				create new_tree_item
				tree_item.extend (new_tree_item)
				temp_item ?= layout_item.item
				check
					temp_item_not_void: temp_item /= Void
				end
				store_item (new_tree_item, temp_item)
				layout_item.forth
			end
		end

	state_tree: GB_BOOLEAN_TREE;
		-- An internal representation of layout_constructor.
		-- Void unless `store_layout_constructor' called.

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


end -- class GB_LAYOUT_CONSTRUCTOR_STATE_HANDLER
