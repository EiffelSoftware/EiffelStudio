note
	description: "EiffelVision2 toolbar, Cocoa implementation."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TOOL_BAR_IMP

inherit
	EV_TOOL_BAR_I
		redefine
			interface
		end

	EV_PRIMITIVE_IMP
		undefine
			update_for_pick_and_drop, minimum_width, minimum_height,
			internal_set_minimum_height, internal_set_minimum_width, internal_set_minimum_size
		redefine
			interface,
			make,
			set_parent_imp,
			ev_apply_new_size
		end

	EV_ITEM_LIST_IMP [EV_TOOL_BAR_ITEM, EV_ITEM_IMP]
		undefine
			item_by_data
		redefine
			interface
		end

	EV_SIZEABLE_CONTAINER_IMP
		redefine
			interface
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		do
			initialize_item_list
			create radio_group.make

			create box.make
			box.set_title_position ({NS_BOX}.no_title)
			box.set_box_type ({NS_BOX}.box_custom)
			box.set_border_type ({NS_BOX}.no_border)
			box.set_content_view_margins (0, 0)
			cocoa_view := box

			Precursor {EV_PRIMITIVE_IMP}
			disable_tabable_from
			has_vertical_button_style := True

			new_item_actions.extend (agent add_radio_button)
			remove_item_actions.extend (agent remove_radio_button)
		end

	set_parent_imp (a_container_imp: EV_CONTAINER_IMP)
			-- Set `parent_imp' to `a_container_imp'.
		do
			parent_imp := a_container_imp
		end

feature -- Status report

	has_vertical_button_style: BOOLEAN
			-- Is the `pixmap' displayed vertically above `text' for
			-- all buttons contained in `Current'? If `False', then
			-- the `pixmap' is displayed to left of `text'.

	is_vertical: BOOLEAN
			-- Are the buttons in `Current' arranged vertically?

feature -- Status setting

	enable_vertical_button_style
			-- Ensure `has_vertical_button_style' is `True'.
		do
			has_vertical_button_style := True
		end

	disable_vertical_button_style
			-- Ensure `has_vertical_button_style' is `False'.
		do
			has_vertical_button_style := False
		end

	enable_vertical
			-- Enable vertical toolbar style.
		do
			is_vertical := True
		end

	disable_vertical
			-- Disable vertical toolbar style (ie: Horizontal).
		do
			is_vertical := False
		end

feature -- Access

	insert_item (v: EV_ITEM_IMP; i: INTEGER_32)
		local
			l_view: detachable NS_VIEW
		do
			l_view ?= v.cocoa_view
			check l_view /= void then end
			box.add_subview (l_view)
			notify_change (nc_minsize, Current)
		end

	remove_item (button: EV_ITEM_IMP)
			-- Remove `button' from `current'.
		do
			-- TODO remove
			notify_change (nc_minsize, Current)
		end

feature -- Implementation

	compute_minimum_width
			-- Update the minimum-size of `Current'.
		local
			l_width: INTEGER
		do
			from
				ev_children.start
			until
				ev_children.after
			loop
				l_width := l_width + ev_children.item.minimum_width
				ev_children.forth
			end
			internal_set_minimum_width (l_width)
		end

	compute_minimum_height
			-- Update the minimum-size of `Current'.
		local
			l_height: INTEGER
		do
			from
				ev_children.start
			until
				ev_children.after
			loop
				l_height := l_height.max (ev_children.item.minimum_height)
				ev_children.forth
			end
			internal_set_minimum_height (l_height)
		end

	compute_minimum_size
			-- Recompute both the minimum_width and then
			-- minimum_height of `Current'.
		do
			compute_minimum_height
			compute_minimum_width
		end

	ev_apply_new_size (a_x_position, a_y_position, a_width, a_height: INTEGER_32; repaint: BOOLEAN)
			-- Precursor		
		local
			litem: detachable EV_NS_VIEW
			x: INTEGER
			item_width, item_height: INTEGER
		do
			ev_move_and_resize (a_x_position, a_y_position, a_width, a_height, repaint)
			item_height := box.content_view.bounds.size.height.rounded
			from
				ev_children.start
				x := 0
			until
				ev_children.after
			loop
				litem ?= ev_children.item
				check litem /= Void then end
				item_width := litem.minimum_width
				litem.cocoa_set_size (x, 0, item_width, item_height)
				x := x + item_width
				ev_children.forth
			end
		end

feature {EV_DOCKABLE_SOURCE_I} -- Implementation (obsolete?)

	block_selection_for_docking
			--
		do
		end

	insertion_position: INTEGER
			-- `Result' is index - 1 of item beneath the
			-- current mouse pointer or count + 1 if over the toolbar
			-- and not over a button.
		do
		end


feature {EV_TOOL_BAR_IMP} -- Implementation
	-- TODO: is this the same for all radio-containers? (menu, toolbar, widget container)
	-- if so, share the code.

	radio_group: LINKED_LIST [EV_TOOL_BAR_RADIO_BUTTON_IMP]
			-- Radio items in `Current'.
			-- `Current' shares reference with merged containers.

	is_merged (other: EV_TOOL_BAR): BOOLEAN
			-- Is `Current' merged with `other'?
		require
			other_not_void: other /= Void
		local
			t_imp: detachable EV_TOOL_BAR_IMP
		do
			t_imp ?= other.implementation
			check t_imp /= Void then end
			Result := t_imp.radio_group = radio_group
		end

	set_radio_group (rg: like radio_group)
			-- Set `radio_group' by reference. (Merge)
		do
			radio_group := rg
		end

	add_radio_button (w: EV_ITEM)
			-- Called when `w' has been added to `Current'.
		require
			w_not_void: w /= Void
			w_correct_type: attached {EV_TOOL_BAR_ITEM} w
		local
			r: detachable EV_TOOL_BAR_RADIO_BUTTON_IMP
		do
			r ?= w.implementation
			if r /= Void then
				if not radio_group.is_empty then
					r.disable_select
				end
				r.set_radio_group (radio_group)
			end
		end

	add_button (w: EV_ITEM)
			-- Called when `w' has been added to `Current'.
		require
			w_not_void: w /= Void
			w_correct_type: attached {EV_TOOL_BAR_ITEM} w
		local
			button_imp: detachable EV_TOOL_BAR_BUTTON_IMP -- was: EV_TOOL_BAR_ITEM_IMP
		do
			button_imp ?= w.implementation
			check
				implementation_not_void: button_imp /= Void then
			end
			if not button_imp.is_sensitive then
				--disable_button (button_imp.id)
			end
		end

	remove_radio_button (w: EV_ITEM)
			-- Called when `w' has been removed from `Current'.
		require
			w_not_void: w /= Void
			w_correct_type: attached {EV_TOOL_BAR_ITEM} w
		local
			r: detachable EV_TOOL_BAR_RADIO_BUTTON_IMP
		do
			r ?= w.implementation
			if r /= Void then
				r.remove_from_radio_group
				r.enable_select
			end
		end

feature {EV_ANY_I} -- Interface

	box: NS_BOX

feature {EV_ANY, EV_ANY_I} -- Interface

	interface: detachable EV_TOOL_BAR note option: stable attribute end;

note
	copyright: "Copyright (c) 1984-2019, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
