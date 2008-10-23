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
		rename
			set_pebble as set_pebble_original
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

	EV_SHARED_APPLICATION
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

	stone: STONE is
			-- Class stone representing `Current'.
		deferred
		end

feature -- Status Setting

	set_pebble (a_pebble: like pebble)
			-- Redirect pebbles to pebble functions in which we do specific control in ES.
		require
			a_pebble_not_void: a_pebble /= Void
		do
			set_pebble_function (agent pebble_adapter (a_pebble))
		ensure
			pebble_function_set: pebble_function /= Void
		end

feature -- Interactivity

	associate_with_window (a_window: like associated_window) is
			-- Associate recursively with `a_window' so that we can call `set_stone' on `a_window'.
		do
			if pointer_press_action_agent = Void then
				pointer_press_action_agent := agent pointer_press_action
				pointer_button_press_actions.force_extend (pointer_press_action_agent)
			end
			associated_window := a_window
		end

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

	associated_window: EB_STONABLE
			-- Is `Current' already associated to a window?

	pointer_press_action (a_x: INTEGER_32; a_y: INTEGER_32; a_button: INTEGER_32; a_x_tilt: REAL_64; a_y_tilt: REAL_64; a_pressure: REAL_64;
						 a_screen_x: INTEGER_32; a_screen_y: INTEGER_32; action: PROCEDURE [ANY, TUPLE]) is
			-- Send a stone corresponding to `Current' to `associated_window'.
		local
			l_stone: STONE
		do
			if a_button = 1 and then associated_window /= Void then
				associated_window.set_stone (stone)
			elseif a_button = {EV_POINTER_CONSTANTS}.right and then ev_application.ctrl_pressed then
				l_stone := stone
				if l_stone /= Void and then l_stone.is_valid then
						(create {EB_CONTROL_PICK_HANDLER}).launch_stone (l_stone)
				end
			end
		end

	pebble_adapter (a_pebble: like pebble): like pebble
			-- Pebble adapter to enable control right click
		require
			a_pebble_not_void: a_pebble /= Void
		do
			if not ev_application.ctrl_pressed then
				Result := a_pebble
			end
		end

	pointer_press_action_agent: PROCEDURE [ANY, TUPLE [x: INTEGER_32; y: INTEGER_32; button: INTEGER_32; x_tilt: REAL_64; y_tilt: REAL_64; pressure: REAL_64; screen_x: INTEGER_32; screen_y: INTEGER_32]];
			-- `pointer_press_action' handler

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
