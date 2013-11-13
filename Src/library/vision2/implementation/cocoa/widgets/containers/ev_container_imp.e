note
	description: "Eiffel Vision container, Cocoa implementation."
	author: "Daniel Furrer"
	keywords: "container"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_CONTAINER_IMP

inherit
	EV_CONTAINER_I
		undefine
			interface_item
		redefine
			interface,
			propagate_foreground_color,
			propagate_background_color
		end

	EV_WIDGET_IMP
		undefine
			ev_apply_new_size,
			minimum_width,
			minimum_height
		redefine
			initialize,
			interface,
			destroy
		end

	EV_SIZEABLE_CONTAINER_IMP
		redefine
			interface
		end

	EV_CONTAINER_ACTION_SEQUENCES_IMP

	PLATFORM

feature {NONE}

	initialize
			-- Show non window widgets.
			-- Initialize default options, colors and sizes.
		do
			create radio_group.make
			initialize_sizeable
			create remove_item_actions
			new_item_actions.extend (agent add_radio_button)
			remove_item_actions.extend (agent remove_radio_button)
			Precursor {EV_WIDGET_IMP}
		end

feature -- Access

	client_width: INTEGER
			-- Width of the client area of container.
			-- Redefined in children.
		do
			Result := width
		end

	client_height: INTEGER
			-- Height of the client area of container
			-- Redefined in children.
		do
			Result := height
		end

	background_pixmap: detachable EV_PIXMAP
			-- the background pixmap

	item_imp: detachable EV_WIDGET_IMP
			-- `item'.`implementation'.
		do
			if attached item as l_item then
				Result ?= l_item.implementation
			end
		end

feature -- Element change

	replace (v: like item)
			-- Replace `item' with `v'.
		deferred

		end

feature -- Status Setting

	connect_radio_grouping (a_container: EV_CONTAINER)
			-- Join radio grouping of `a_container' to `Current'.
		local
			l: like radio_group
			peer: detachable EV_CONTAINER_IMP
		do
			peer ?= a_container.implementation
			check peer /= Void then end
			l := peer.radio_group
			if l /= radio_group then
				from
					l.start
				until
					l.is_empty
				loop
					add_radio_button (l.item.attached_interface)
				end
				peer.set_radio_group (radio_group)
			end
		end

	unconnect_radio_grouping (a_container: EV_CONTAINER)
			-- Removed radio grouping of `a_container' from `Current'.
		local
			l: detachable like radio_group
			peer: detachable EV_CONTAINER_IMP
			r: detachable EV_RADIO_BUTTON_IMP
			original_selected_button: detachable EV_RADIO_BUTTON_IMP
		do
			peer ?= a_container.implementation
			check peer /= Void then end
			l := radio_group
			from
				l.start
			until
				l.off
			loop
				r ?= l.item
				check r /= Void then end
				if r.is_selected then
						-- Store originally selected button,
						-- for selection of necessary button at
						-- end of unmerge, as a button has to
						-- be selected in all groups.
					original_selected_button := r
				end
				if r.parent = a_container then
					if peer.radio_group = radio_group then
							-- Reset radio group, back to
							-- empty.
						peer.reset_radio_group
					end
						-- Remove radio button from radio group
						-- of `Current'.
					l.remove
						-- Link radio group of `r' to match that of `a_container'.
					r.internal_set_radio_group (peer.radio_group)
						-- Add `r' to radio group of `container'.
					peer.radio_group.extend (r)
				else
					l.forth
				end
			end
			if not l.is_empty then
				check
					had_original_selection: original_selected_button /= Void
				end
			end
				-- There was not necessarily a selected item, as
				-- the containers may not contain a radio button.
			if original_selected_button /= Void then
					-- We now select a radio button in the new group,
					-- that does not already have one selected.
				if original_selected_button.parent_imp = peer then
					if has_selected_radio_button then
						select_first_radio_button
					end
				elseif peer.has_radio_button then
					peer.select_first_radio_button
				end
			end
		end

	internal_set_background_pixmap (a_pixmap: EV_PIXMAP)
			-- Set the container background pixmap to `pixmap'.
		do
		end

	set_background_pixmap (a_pixmap: EV_PIXMAP)
			-- Set the container background pixmap to `pixmap'.
		do
		end

	bg_pixmap (p: POINTER): POINTER
		do
		end

	remove_background_pixmap
			-- Make background pixmap Void.
		do
		end

feature -- Basic operations

	propagate_foreground_color
			-- Propagate the current foreground color of the
			-- container to the children.
		do
			--precursor {EV_CONTAINER_PI}

		end

	propagate_background_color
			-- Propagate the current background color of the
			-- container to the children.
		do
			Precursor {EV_CONTAINER_I}
		end

feature -- Command

	destroy
			-- Render `Current' unusable.
		do
--			if interface.prunable then
--				interface.wipe_out
--			end
			Precursor {EV_WIDGET_IMP}
		end

feature -- Event handling

	remove_item_actions: EV_LITE_ACTION_SEQUENCE [TUPLE [EV_WIDGET]]
			-- Actions to be performed before an item is removed.

feature {EV_CONTAINER_IMP} -- Implementation

	radio_group: LINKED_LIST [EV_RADIO_BUTTON_IMP]
			-- Radio items in `Current'.
			-- `Current' shares reference with merged containers.

	is_merged (other: EV_CONTAINER): BOOLEAN
			-- Is `Current' merged with `other'?
		require
			other_not_void: other /= Void
		local
			c_imp: detachable EV_CONTAINER_IMP
		do
			c_imp ?= other.implementation
			check c_imp /= Void then end
			Result := c_imp.radio_group = radio_group
		end

	reset_radio_group
			-- Reset radio group to be an empty
			-- list.
		do
			create radio_group.make
		ensure
			radio_group_exists: radio_group /= Void
			radio_group_empty: radio_group.is_empty
		end


	set_radio_group (rg: like radio_group)
			-- Set `radio_group' by reference. (Merge)
		do
			radio_group := rg
		ensure
			radio_group_set: radio_group = rg
		end

	add_radio_button (w: EV_WIDGET)
			-- Called every time a widget is added to the container.
			--| If `w' is a radio button then we update associated
			--| radio buttons as necessary.
		require
			w_not_void: w /= Void
		do
			if attached {EV_RADIO_BUTTON_IMP} w.implementation as r then
				if not radio_group.is_empty then
					r.set_state ({NS_CELL}.off_state)
				end
				r.set_radio_group (radio_group)
			end
		end

	remove_radio_button (w: EV_WIDGET)
			-- Called every time a widget is removed from the container.
			--| If `w' is a radio button then we update  associated
			--| radio buttons as necessary.
		require
			w_not_void: w /= Void
		do
			if attached {EV_RADIO_BUTTON_IMP} w.implementation as r then
				r.remove_from_radio_group
				r.set_state ({NS_CELL}.on_state)
			end
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_CONTAINER note option: stable attribute end;
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end -- class EV_CONTAINER_IMP
