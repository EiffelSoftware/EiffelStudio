indexing
	description: "EiffelVision2 toolbar, carbon implementation."
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
			update_for_pick_and_drop
		redefine
			interface,
			initialize,
			set_parent_imp
		end

	EV_ITEM_LIST_IMP [EV_TOOL_BAR_ITEM]
		undefine
			item_by_data
		redefine
			interface,
			insert_i_th,
			initialize
		end

	CONTROLDEFINITIONS_FUNCTIONS_EXTERNAL
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Implementation

	remove_i_th (i: INTEGER) is
			-- Remove item at `i'-th position.
		local
			imp: EV_ITEM_IMP
			item_ptr: POINTER
			ret: INTEGER
		do
			child_array.go_i_th (i)
			imp ?= child_array.i_th (i).implementation
			item_ptr := imp.c_object
			ret := hiview_remove_from_superview_external (item_ptr)
			child_array.remove
			imp.set_item_parent_imp (Void)
		end

	make (an_interface: like interface) is
			-- Create the tool-bar.
		local
			ret: INTEGER
			rect: RECT_STRUCT
			ptr: POINTER
			control_ptr : POINTER
		do
			base_make (an_interface)
			create rect.make_new_unshared
			rect.set_right (300)
			rect.set_bottom (30)
			ret := create_user_pane_control_external ( null, rect.item, {CONTROLS_ANON_ENUMS}.kControlSupportsEmbedding, $ptr )
			ret := create_radio_group_control_external (null,rect.item, $radio_group)
			set_c_object ( radio_group )





			event_id := app_implementation.get_id (current)
		end

	initialize is
			-- Initialize `Current'.
		do
			Precursor {EV_ITEM_LIST_IMP}
			Precursor {EV_PRIMITIVE_IMP}
			has_vertical_button_style := True
		end

	list_widget: POINTER is
			--
		do
		end

	set_parent_imp (a_container_imp: EV_CONTAINER_IMP) is
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

	enable_vertical_button_style is
			-- Ensure `has_vertical_button_style' is `True'.
		do
		end

	disable_vertical_button_style is
			-- Ensure `has_vertical_button_style' is `False'.
		do
		end

	enable_vertical is
			-- Enable vertical toolbar style.
		do
		end

	disable_vertical is
			-- Disable vertical toolbar style (ie: Horizontal).
		do
		end

feature {EV_DOCKABLE_SOURCE_I} -- Implementation

	block_selection_for_docking is
			--
		do
		end

feature -- Implementation

	update_toolbar_style is
			-- Set the style of `Current' relative to items
		do
		end

	insertion_position: INTEGER is
			-- `Result' is index - 1 of item beneath the
			-- current mouse pointer or count + 1 if over the toolbar
			-- and not over a button.
		do
		end

	insert_i_th (v: like item; i: INTEGER) is
			-- Insert `v' at position `i'.
		local
			v_imp: EV_ITEM_IMP
			ret: INTEGER
			radio_peer_imp: EV_RADIO_PEER_IMP
		do

			-- Special treatment for radio buttons
			radio_peer_imp ?= v.implementation
			v_imp ?= v.implementation
			if
				radio_peer_imp /= Void
			then
				ret := embed_control_external (v_imp.c_object, radio_group)
			else
				ret := embed_control_external (v_imp.c_object, c_object)
			end
			v_imp.set_item_parent_imp (Current)
			move_control_external (v_imp.c_object, (i - 1) * 100, 0)

			child_array.go_i_th (i)
			child_array.put_left (v)
			if parent_imp /= Void then
				update_toolbar_style
			end
		end

	add_radio_button (w: EV_RADIO_PEER_IMP) is
			-- Connect radio button to tool bar group.
		require
			w_not_void: w /= Void
		local
			ret: INTEGER
		do

		end

feature {EV_TOOL_BAR_RADIO_BUTTON_IMP} -- Implementation

	radio_group: POINTER

feature {EV_ANY_I} -- Implementation

	interface: EV_TOOL_BAR;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_TOOL_BAR_IMP

