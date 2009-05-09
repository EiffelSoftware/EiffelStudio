note
	description: "EiffelVision2 toolbar, Cocoa implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			initialize,
			set_parent_imp,
			ev_apply_new_size
		end

	EV_ITEM_LIST_IMP [EV_TOOL_BAR_ITEM, EV_ITEM_IMP]
		undefine
			item_by_data
		redefine
			interface,
			initialize,
			insert_i_th
		end

	EV_SIZEABLE_CONTAINER_IMP
		redefine
			interface
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface)
			-- Create the tool-bar.
		do
			base_make (an_interface)
			create {NS_BOX}cocoa_item.new
			box.set_title ("TOOLBAR")
		end

	initialize
			-- Initialize `Current'.
		do
			Precursor {EV_ITEM_LIST_IMP}
			Precursor {EV_PRIMITIVE_IMP}
			has_vertical_button_style := True
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

feature -- Implementation

	insert_i_th (v: like item; i: INTEGER_32)
		local
			v_imp: EV_ANY_IMP
			l_view: NS_VIEW
		do
			Precursor {EV_ITEM_LIST_IMP} (v, i)
			v_imp ?= v.implementation
			l_view ?= v_imp.cocoa_item
			box.add_subview (l_view)
			notify_change (nc_minsize, Current)
		end

	compute_minimum_width
			-- Update the minimum-size of `Current'.
		do
			internal_set_minimum_width (20 * count)
		end

	compute_minimum_height
			-- Update the minimum-size of `Current'.
		do
			internal_set_minimum_height (30)
		end

	compute_minimum_size
			-- Recompute both the minimum_width and then
			-- minimum_height of `Current'.
		do
			compute_minimum_height
			compute_minimum_width
		end

	ev_apply_new_size (a_x_position, a_y_position, a_width, a_height: INTEGER_32; repaint: BOOLEAN)
		do
			ev_move_and_resize (a_x_position, a_y_position, a_width, a_height, repaint)
			--ev_children
		end

feature {EV_TOOL_BAR_RADIO_BUTTON_IMP} -- Radio button handling

	add_radio_button (w: EV_RADIO_PEER_IMP)
			-- Connect radio button to tool bar group.
		require
			w_not_void: w /= Void
		do
		end

	radio_group: POINTER

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

feature {EV_ANY_I} -- Interface

	interface: EV_TOOL_BAR;

	box: NS_BOX
		do
			Result ?= cocoa_item
		end

note
	copyright:	"Copyright (c) 2009, Daniel Furrer"
end -- class EV_TOOL_BAR_IMP

