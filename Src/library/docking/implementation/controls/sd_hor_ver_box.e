indexing
	description: "EV_BOX that wrapper EV_HORIZONTAL_BOX and EV_VERTICAL_BOX. Actually this is EV_VERTICAL_BOX contain a EV_HORIZONTAL_BOX."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_HOR_VER_BOX

inherit
	EV_VERTICAL_BOX
		rename
			extend as extend_vertical_box,
			disable_item_expand as disable_item_expand_vertical_box,
			prune as prune_vertical_box,
			start as start_vertical_box,
			after as after_vertical_box,
			forth as forth_vertical_box,
			finish as finish_vertical_box,
			back as back_vertical_box,
			before as before_vertical_box,
			item as item_vertical_box,
			count as count_vertical_box,
			has as has_vertical_box,
			search as search_vertical_box,
			pointer_enter_actions as pointer_enter_actions_vertical_box,
			wipe_out as wipe_out_vertical_box,
			linear_representation as linear_representation_vertical_box,
			off as off_vertical_box,
			remove as remove_vertical_box,
			prune_all as prune_all_vertical_box,
			set_background_color as set_background_color_vertical_box,
			background_color as background_color_vertical_box,
			set_border_width as set_border_width_vertical_box,
			set_padding_width as set_padding_width_vertical_box,
			padding_width as padding_width_vertical_box,
			index as index_vertical_box,
			swap as swap_vertical_box,
			is_empty as is_empty_vertical_box
		export
			{NONE} all
			{ANY} height, set_minimum_height, set_minimum_width, has_recursive
		end

create

	init

feature {NONE} -- Initlization

	init (a_vertical_style: BOOLEAN)is
			-- Creation method.
		do
			internal_vertical_style := a_vertical_style
			if not internal_vertical_style then
				create horizontal_box
			end
			default_create
			if not internal_vertical_style then
				init_horizontal_style
			end
			create pointer_enter_actions.default_create
		ensure
			set: internal_vertical_style = a_vertical_style
		end

	init_horizontal_style is
			-- If internal_vertical_style false, add horizontal box.
		require
			horizontal: not internal_vertical_style
		do
			-- First change the style, so the horizontal_box can be added in.
			internal_vertical_style := not internal_vertical_style
			extend (horizontal_box)
			-- Then change the style back.
			internal_vertical_style := not internal_vertical_style
		ensure
			horizontal: not internal_vertical_style
		end

feature -- Basic operations

	change_direction is
			-- Change `interal_direction', then change all items layout.
		require
			is_empty: is_empty
		local
			l_items: ARRAYED_LIST [EV_WIDGET]
		do
			internal_vertical_style := not internal_vertical_style
			if not internal_vertical_style then
				init_horizontal_style
			end
		ensure
			style_changed: old internal_vertical_style = not internal_vertical_style
		end

feature -- Actions

	pointer_enter_actions: EV_NOTIFY_ACTION_SEQUENCE

feature -- Query

	is_vertical: BOOLEAN is
			-- If Current vertical style?
		do
			Result := internal_vertical_style
		end

feature -- Redefine

	extend (v: like item) is
			-- Redefine.
		do
			if internal_vertical_style then
				extend_vertical_box (v)
			else
				horizontal_box.extend (v)
			end
		end

	prune (v: like item) is
			-- Redefine.
		do
			if internal_vertical_style then
				prune_vertical_box (v)
			else
				horizontal_box.prune (v)
			end
		end

	start is
			-- Redefine.
		do
			if internal_vertical_style then
				start_vertical_box
			else
				horizontal_box.start
			end
		end


	after: BOOLEAN is
			-- Redefine.
		do
			if internal_vertical_style then
				Result := after_vertical_box
			else
				Result := horizontal_box.after
			end
		end

	forth is
			-- Redefine.
		do
			if internal_vertical_style then
				forth_vertical_box
			else
				horizontal_box.forth
			end
		end

	finish is
			-- Redefine
		do
			if internal_vertical_style then
				finish_vertical_box
			else
				horizontal_box.finish
			end
		end

	back is
			-- Redefine
		do
			if internal_vertical_style then
				back_vertical_box
			else
				horizontal_box.back
			end
		end

	before: BOOLEAN is
			-- Redefine
		do
			if internal_vertical_style then
				Result := before_vertical_box
			else
				Result := horizontal_box.before
			end
		end

	item: EV_WIDGET is
			-- Redefine.
		do
			if internal_vertical_style then
				Result := item_vertical_box
			else
				Result := horizontal_box.item
			end
		end

	count: INTEGER is
			-- Redefine.
		do
			if internal_vertical_style then
				Result := count_vertical_box
			else
				Result := horizontal_box.count
			end
		end

	disable_item_expand (an_item: EV_WIDGET) is
			-- Redefine.
		do
			if internal_vertical_style then
				disable_item_expand_vertical_box (an_item)
			else
				horizontal_box.disable_item_expand (an_item)
			end
		end

	has (v: like item): BOOLEAN is
			-- Redefine.
		do
			if internal_vertical_style then
				Result := has_vertical_box (v)
			else
				Result := horizontal_box.has (v)
			end
		end

	search (v: like item) is
			-- Redefine.
		do
			if internal_vertical_style then
				search_vertical_box (v)
			else
				horizontal_box.search (v)
			end
		end

	wipe_out is
			-- Redefine.
		do
			if internal_vertical_style then
				wipe_out_vertical_box
			else
				horizontal_box.wipe_out
			end
		end

	linear_representation: LINEAR [EV_WIDGET] is
			-- Redefine.
		do
			if internal_vertical_style then
				Result := linear_representation_vertical_box
			else
				Result := horizontal_box.linear_representation
			end
		end

	off: BOOLEAN is
			-- Redefine.
		do
			if internal_vertical_style then
				Result := off_vertical_box
			else
				Result := horizontal_box.off
			end
		end

	remove is
			-- Redefine.
		do
			if internal_vertical_style then
				remove_vertical_box
			else
				horizontal_box.remove
			end
		end

	prune_all (a_item: EV_WIDGET) is
			-- Redefine.
		do
			if internal_vertical_style then
				prune_all_vertical_box (a_item)
			else
				horizontal_box.prune_all (a_item)
			end
		end

	set_background_color (a_color: EV_COLOR) is
			-- Redefine.
		do
			if internal_vertical_style then
				set_background_color_vertical_box (a_color)
			else
				horizontal_box.set_background_color (a_color)
			end
		end

	background_color: EV_COLOR is
			-- Redefine.
		do
			if internal_vertical_style then
				Result := background_color_vertical_box
			else
				Result := horizontal_box.background_color
			end
		end

	set_border_width (a_width: INTEGER) is
			-- Redefine
		do
			if internal_vertical_style then
				set_border_width_vertical_box (a_width)
			else
				horizontal_box.set_border_width (a_width)
			end
		end

	set_padding_width (a_width: INTEGER) is
			-- Redefine
		do
			if internal_vertical_style then
				set_padding_width_vertical_box (a_width)
			else
				horizontal_box.set_padding_width (a_width)
			end
		end

	padding_width: INTEGER is
			-- Redefine
		do
			if internal_vertical_style then
				Result := padding_width_vertical_box
			else
				Result := horizontal_box.padding_width
			end
		end

	index: INTEGER is
			-- Redefine
		do
			if is_vertical then
				Result := index_vertical_box
			else
				Result := horizontal_box.index
			end
		end

	swap (a_index: INTEGER) is
			-- Redefine
		do
			if is_vertical then
				swap_vertical_box (a_index)
			else
				horizontal_box.swap (a_index)
			end
		end

	is_empty: BOOLEAN is
			-- Redefine
		do
			if is_vertical then
				Result := is_empty_vertical_box
			else
				Result := horizontal_box.is_empty
			end
		end

feature {NONE} -- Implementation

	internal_vertical_style: BOOLEAN
			-- If current box show vertically? Otherwise is show horizontally.

	horizontal_box: EV_HORIZONTAL_BOX;
			-- Horizontal box in the Current when show horizontally.

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




end
