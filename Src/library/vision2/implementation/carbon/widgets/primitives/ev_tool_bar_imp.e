note
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
			set_parent_imp,
			minimum_width,
			minimum_height
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

feature {NONE} -- Initialization



	make (an_interface: like interface)
			-- Create the tool-bar.
		local
			ret: INTEGER
			rect: RECT_STRUCT
			ptr: POINTER
			control_ptr : POINTER
		do

			base_make (an_interface)
			create rect.make_new_unshared
			rect.set_right (1)
			rect.set_bottom (1)
			ret := create_user_pane_control_external ( null, rect.item, {CONTROLS_ANON_ENUMS}.kControlSupportsEmbedding, $ptr )
			ret := create_radio_group_control_external (null,rect.item, $radio_group)
			ret := hiview_add_subview_external (ptr, radio_group)
			set_c_object ( ptr )


			event_id := app_implementation.get_id (current)
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
		local
			button: EV_TOOL_BAR_BUTTON_IMP
		do
			from
				child_array.start
			until
				child_array.after
			loop
				button ?= child_array.item
				if
					button /= Void
				then
					button.disable_vertical_button_style
				end

				child_array.forth
			end
			has_vertical_button_style := True

			layout
		end

	disable_vertical_button_style
			-- Ensure `has_vertical_button_style' is `False'.
				local
			button_imp: EV_TOOL_BAR_BUTTON_IMP
		do
			from
				child_array.start
			until
				child_array.after
			loop
				button_imp ?= child_array.item
				if
					button_imp /= Void
				then
					button_imp.set_vertical_button_style
				end

				child_array.forth

			end
			has_vertical_button_style := False
			layout
		end

	enable_vertical
			-- Enable vertical toolbar style.
		do
			is_vertical := True

			layout
		end

	disable_vertical
			-- Disable vertical toolbar style (ie: Horizontal).
		do
			is_vertical := False

			layout
		end



feature -- Implementation


	minimum_width: INTEGER
			-- Minimum width that the widget may occupy.

		do
			Result := get_embedded_width
		end

	minimum_height: INTEGER
			-- Minimum width that the widget may occupy.

		do
			Result := get_embedded_height
		end


	layout
			-- Set the style of `Current' relative to items
		local
			button_imp: EV_TOOL_BAR_BUTTON_IMP
			sep_imp: EV_TOOL_BAR_SEPARATOR_IMP
			rect: RECT_STRUCT
			ret: INTEGER
		do
			from
				child_array.start
			until
				child_array.after
			loop
				if child_array.item /= Void and child_array.item.implementation /= Void then
					button_imp ?= child_array.item.implementation
					sep_imp ?= child_array.item.implementation
				end

				if
					button_imp /= Void
				then
					rect := get_insertion_coords (child_array.index)
					move_control_external (button_imp.c_object, rect.left, rect.top)
				elseif
					sep_imp /= Void
				then
					--sep_imp.layout
					--rect := get_insertion_coords (child_array.index)
					--move_control_external (sep_imp.c_object, rect.left, rect.top)
				end
				button_imp := Void
				sep_imp := Void
				child_array.forth
			end

			-- Radio Group does not adjust size automatically...
			size_control_external (radio_group, height, width)

			if parent_imp /= Void then
				parent_imp.child_has_resized (current, minimum_width, minimum_height)
			end

		end

	get_insertion_coords (an_index: INTEGER): RECT_STRUCT
			-- Get the coordinates for insertion of the current tool bar item
		local
			carbon_item: EV_CARBON_WIDGET_IMP
		do
			create Result.make_new_unshared
			from
				child_array.start
			until
				child_array.index >= an_index
			loop
				carbon_item ?= child_array.item.implementation
				if
					carbon_item /= Void
				then
					if
						is_vertical
					then
						Result.set_top (Result.top + carbon_item.height)
						Result.set_left (0)
					else
						Result.set_left (Result.left + carbon_item.width)
						Result.set_top (0)
					end
				end
				child_array.forth
			end
		end

	get_embedded_width: INTEGER
			-- Get the width of all embedded items
		local
			carbon_item: EV_CARBON_WIDGET_IMP
		do
			if is_vertical then
				from
					child_array.start
				until
					child_array.after
				loop
					carbon_item ?= child_array.item.implementation
					if
						carbon_item /= Void
					then
						Result := Result.max (carbon_item.width)
					end
					child_array.forth
				end
			else
				from
					child_array.start
				until
					child_array.after
				loop
					carbon_item ?= child_array.item.implementation
					if
						carbon_item /= Void
					then
						Result := Result + carbon_item.width
					end
					child_array.forth
				end
			end
		end

	get_embedded_height: INTEGER
			-- Get the height of all embedded items
		local
			carbon_item: EV_CARBON_WIDGET_IMP
		do
			if not is_vertical then
				from
					child_array.start
				until
					child_array.after
				loop
					carbon_item ?= child_array.item.implementation
					if
						carbon_item /= Void
					then
						Result := Result.max (carbon_item.height)
					end
					child_array.forth
				end
			else
				from
					child_array.start
				until
					child_array.after
				loop
					carbon_item ?= child_array.item.implementation
					if
						carbon_item /= Void
					then
						Result := Result + carbon_item.height
					end
					child_array.forth
				end
			end
		end




	insert_i_th (v: like item; i: INTEGER)
			-- Insert `v' at position `i'.
		local
			v_imp: EV_ITEM_IMP
			ret: INTEGER
			radio_peer_imp: EV_RADIO_PEER_IMP
			rect, rect_1: RECT_STRUCT
			ptr: POINTER
		do

			-- Special treatment for radio buttons
			radio_peer_imp ?= v.implementation
			v_imp ?= v.implementation
			if
				radio_peer_imp /= Void
			then
				add_radio_button (radio_peer_imp)
			else
				ret := embed_control_external (v_imp.c_object, c_object)
			end
			v_imp.set_item_parent_imp (Current)


			child_array.go_i_th (i)
			child_array.put_left (v)



			layout

		end


	remove_i_th (i: INTEGER)
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



feature {EV_TOOL_BAR_RADIO_BUTTON_IMP} -- Radio button handling

	add_radio_button (w: EV_RADIO_PEER_IMP)
			-- Connect radio button to tool bar group.
		require
			w_not_void: w /= Void
		local
			ret: INTEGER
		do
			ret := embed_control_external (w.c_object, radio_group)

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

	list_widget: POINTER
			--
		do
		end

feature {EV_ANY_I} -- Interface

	interface: EV_TOOL_BAR;


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




end -- class EV_TOOL_BAR_IMP

