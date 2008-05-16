indexing
	description: "Tree items in a cluster tree"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_CLASSES_TREE_ITEM

inherit
	EV_TREE_ITEM
		redefine
			parent_tree
		end

	EB_CONSTANTS
		undefine
			default_create, is_equal, copy
		end

	SHARED_EIFFEL_PROJECT
		undefine
			default_create, is_equal, copy
		end

	EB_RECYCLABLE
		undefine
			default_create, is_equal, copy
		end

feature -- Access

	parent_tree: EB_CLASSES_TREE is
			-- Tree of clusters containing `Current'.
		do
			Result ?= Precursor
		end

	set_associated_textable (textable: EV_TEXT_COMPONENT) is
			-- Associate `Current' with `textable' and change event handling.
		require
			textable /= Void
		do
			associated_textable := textable
			select_actions.wipe_out
			select_actions.extend (agent print_name)
		end

	dummy_string: STRING is "DUMMY"
			-- Dummy string used by `fake_load'

feature {NONE} -- Context menu

	context_menu_handler (a_menu: EV_MENU; a_target_list: ARRAYED_LIST [EV_PND_TARGET_DATA]; a_source: EV_PICK_AND_DROPABLE; a_pebble: ANY) is
			-- Context menu
		local
			l_factory: EB_CONTEXT_MENU_FACTORY
		do
			if parent_tree /= Void then
				l_factory := parent_tree.context_menu_factory
				l_factory.class_tree_menu (a_menu, a_target_list, a_source, a_pebble)
			end
		end

feature {NONE} -- Recyclable

	internal_recycle is
			-- Recycle
		local
			l_item: EB_CLASSES_TREE_ITEM
		do
			from
				start
			until
				after
			loop
				l_item ?= item
				if l_item /= Void then
				 	l_item.recycle
				end
				forth
			end
			destroy
		end

feature {NONE} -- Implementation

	associated_textable: EV_TEXT_COMPONENT
			-- Text component in which `Current' writes its name when clicked on.

	print_name is
			-- Print class name in textable, the associated text component.
		do
			if associated_textable /= Void then
				associated_textable.set_data (Void)
				associated_textable.set_text (text)
			end
		end

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

end -- class EB_CLASSES_TREE_ITEM
