note
	description: "Objects that allow positioning of WEL_WINDOW in a Vision2 system."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_WEL_CONTAINER

inherit
	EV_CELL
		rename
			wipe_out as cell_wipe_out,
			replace as cell_replace,
			put as cell_put,
			has as cell_has,
			prune as cell_prune,
			item as cell_item,
			extend as cell_extend,
			linear_representation as cell_linear_representation
		export {NONE}
			cell_replace,
			cell_put,
			cell_prune,
			cell_item,
			cell_extend,
			has_recursive,
			merge_radio_button_groups,
			propagate_background_color,
			propagate_foreground_color,
			fill,
			is_inserted,
			prune_all
			{EV_ANY_I} cell_has
		redefine
			implementation,
			create_implementation,
			full
		end

feature -- Access

	implementation_window: WEL_WINDOW
			-- Underlying WEL_WINDOW which `Current' is
			-- composed of.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.implementation_window
		end

	item: detachable WEL_WINDOW
			-- `Result' is WEL_WINDOW contained in `Current'.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.item
		end

	full: BOOLEAN
			-- Is there no element?
		do
			Result := item /= Void
		end

	has (v: WEL_WINDOW): BOOLEAN
			-- Is `v' contained in `Current'?
		require
			not_destroyed: not is_destroyed
		do
			Result := (v /= Void and then item = v)
		end

	linear_representation: LINEAR [like item]
			-- Representation as a linear structure
		local
			l: LINKED_LIST [like item]
		do
			create l.make
			if attached implementation.item as l_item then
				l.extend (l_item)
			end
			Result := l
		end

feature -- Status setting

	wipe_out
			-- Remove `child_item'.
		require
			not_destroyed: not is_destroyed
			prunable: prunable
		do
			implementation.replace (Void)
		end

	put, replace  (a_window: WEL_WINDOW)
			-- Replace `child_item' with `a_window'.
		require
			not_destroyed: not is_destroyed
			writeable: writable
			a_window_not_void: a_window /= Void
		do
			implementation.replace (a_window)
		end

	extend (an_item: WEL_WINDOW)
			-- Ensure that structure includes `an_item'.
		do
			replace (an_item)
		end

	prune (v: WEL_WINDOW)
			-- Remove `v' if contained.
		require
			not_destroyed: not is_destroyed
		do
			if item = v then
				wipe_out
			end
		ensure
			v_not_contained: not has (v)
		end

feature -- Event handling

	wel_message_actions: EV_WEL_MESSAGE_ACTION_SEQUENCE
			-- Actions to be performed when a message is received by `implementation_window'.
		do
			Result := implementation.wel_message_actions
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_WEL_CONTAINER_I
			-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation
			-- Create implementation of `Current'.
		do
			create {EV_WEL_CONTAINER_IMP} implementation.make
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class WEL_WINDOW_CELL



