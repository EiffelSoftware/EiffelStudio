note
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
			is_empty as is_empty_vertical_box,
			put_right as put_right_vertical_box
		redefine
			is_background_color_void
		end

create
	init

feature {NONE} -- Initlization

	init (a_vertical_style: BOOLEAN)
			-- Creation method
		do
			internal_vertical_style := a_vertical_style
			if not internal_vertical_style then
				create internal_horizontal_box
			end
			create internal_pointer_enter_actions
			default_create
			if not internal_vertical_style then
				init_horizontal_style
			end
		ensure
			set: internal_vertical_style = a_vertical_style
		end

	init_horizontal_style
			-- If internal_vertical_style false, add horizontal box
		require
			horizontal: not internal_vertical_style
		do
			-- First change the style, so the horizontal_box can be added in
			internal_vertical_style := not internal_vertical_style
			extend (horizontal_box)
			-- Then change the style back
			internal_vertical_style := not internal_vertical_style
		ensure
			horizontal: not internal_vertical_style
		end

feature -- Basic operations

	change_direction
			-- Change `interal_direction', then change all items layout
		require
			is_empty: is_empty
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
			-- Actions to be executed when pointer enter
		require
			set: internal_pointer_enter_actions /= Void
		local
			l_result: like internal_pointer_enter_actions
		do
			l_result := internal_pointer_enter_actions
			check l_result /= Void end -- Implied by precondition `set'
			Result := l_result
		ensure
			not_void: Result /= Void
		end

	internal_pointer_enter_actions: detachable EV_NOTIFY_ACTION_SEQUENCE
			-- Instance holder of `pointer_enter_actions'

feature -- Query

	is_vertical: BOOLEAN
			-- If Current vertical style?
		do
			Result := internal_vertical_style
		end

feature -- Redefine

	extend (v: like item)
			-- <Precursor>
		do
			if internal_vertical_style then
				extend_vertical_box (v)
			else
				horizontal_box.extend (v)
			end
		end

	prune (v: like item)
			-- <Precursor>
		do
			if internal_vertical_style then
				prune_vertical_box (v)
			else
				horizontal_box.prune (v)
			end
		end

	start
			-- <Precursor>
		do
			if internal_vertical_style then
				start_vertical_box
			else
				horizontal_box.start
			end
		end


	after: BOOLEAN
			-- <Precursor>
		do
			if internal_vertical_style then
				Result := after_vertical_box
			else
				Result := horizontal_box.after
			end
		end

	forth
			-- <Precursor>
		do
			if internal_vertical_style then
				forth_vertical_box
			else
				horizontal_box.forth
			end
		end

	finish
			-- <Precursor>
		do
			if internal_vertical_style then
				finish_vertical_box
			else
				horizontal_box.finish
			end
		end

	back
			-- <Precursor>
		do
			if internal_vertical_style then
				back_vertical_box
			else
				horizontal_box.back
			end
		end

	before: BOOLEAN
			-- <Precursor>
		do
			if internal_vertical_style then
				Result := before_vertical_box
			else
				Result := horizontal_box.before
			end
		end

	item: EV_WIDGET
			-- <Precursor>
		do
			if internal_vertical_style then
				Result := item_vertical_box
			else
				Result := horizontal_box.item
			end
		end

	count: INTEGER
			-- <Precursor>
		do
			if internal_vertical_style then
				Result := count_vertical_box
			else
				Result := horizontal_box.count
			end
		end

	disable_item_expand (an_item: EV_WIDGET)
			-- <Precursor>
		do
			if internal_vertical_style then
				disable_item_expand_vertical_box (an_item)
			else
				horizontal_box.disable_item_expand (an_item)
			end
		end

	has (v: like item): BOOLEAN
			-- <Precursor>
		do
			if internal_vertical_style then
				Result := has_vertical_box (v)
			else
				Result := horizontal_box.has (v)
			end
		end

	search (v: like item)
			-- <Precursor>
		do
			if internal_vertical_style then
				search_vertical_box (v)
			else
				horizontal_box.search (v)
			end
		end

	wipe_out
			-- <Precursor>
		do
			if internal_vertical_style then
				wipe_out_vertical_box
			else
				horizontal_box.wipe_out
			end
		end

	linear_representation: LINEAR [EV_WIDGET]
			-- <Precursor>
		do
			if internal_vertical_style then
				Result := linear_representation_vertical_box
			else
				Result := horizontal_box.linear_representation
			end
		end

	off: BOOLEAN
			-- <Precursor>
		do
			if internal_vertical_style then
				Result := off_vertical_box
			else
				Result := horizontal_box.off
			end
		end

	remove
			-- <Precursor>
		do
			if internal_vertical_style then
				remove_vertical_box
			else
				horizontal_box.remove
			end
		end

	prune_all (a_item: EV_WIDGET)
			-- <Precursor>
		do
			if internal_vertical_style then
				prune_all_vertical_box (a_item)
			else
				horizontal_box.prune_all (a_item)
			end
		end

	set_background_color (a_color: EV_COLOR)
			-- <Precursor>
		do
			if internal_vertical_style then
				set_background_color_vertical_box (a_color)
			else
				horizontal_box.set_background_color (a_color)
			end
		end

	background_color: EV_COLOR
			-- <Precursor>
		do
			if internal_vertical_style then
				Result := background_color_vertical_box
			else
				Result := horizontal_box.background_color
			end
		end

	set_border_width (a_width: INTEGER)
			-- <Precursor>
		do
			if internal_vertical_style then
				set_border_width_vertical_box (a_width)
			else
				horizontal_box.set_border_width (a_width)
			end
		end

	set_padding_width (a_width: INTEGER)
			-- <Precursor>
		do
			if internal_vertical_style then
				set_padding_width_vertical_box (a_width)
			else
				horizontal_box.set_padding_width (a_width)
			end
		end

	padding_width: INTEGER
			-- <Precursor>
		do
			if internal_vertical_style then
				Result := padding_width_vertical_box
			else
				Result := horizontal_box.padding_width
			end
		end

	index: INTEGER
			-- <Precursor>
		do
			if is_vertical then
				Result := index_vertical_box
			else
				Result := horizontal_box.index
			end
		end

	swap (a_index: INTEGER)
			-- <Precursor>
		do
			if is_vertical then
				swap_vertical_box (a_index)
			else
				horizontal_box.swap (a_index)
			end
		end

	is_empty: BOOLEAN
			-- <Precursor>
		do
			if is_vertical then
				Result := is_empty_vertical_box
			else
				Result := horizontal_box.is_empty
			end
		end

	put_right (a_widget: EV_WIDGET)
			-- <Precursor>
		do
			if is_vertical then
				put_right_vertical_box (a_widget)
			else
				horizontal_box.put_right (a_widget)
			end
		end

feature {NONE} -- Implementation

	internal_vertical_style: BOOLEAN
			-- If current box show vertically? Otherwise is show horizontally

	horizontal_box: EV_HORIZONTAL_BOX
			-- Attached `internal_horizontal_box'
		require
			set: internal_horizontal_box /= Void
		local
			l_result: like internal_horizontal_box
		do
			l_result := internal_horizontal_box
			check l_result /= Void end -- Implied by precondition `set'
			Result := l_result
		ensure
			not_void: Result /= Void
		end

	internal_horizontal_box: detachable EV_HORIZONTAL_BOX
			-- Horizontal box in the Current when show horizontally

feature {NONE} -- Contract Support

	is_background_color_void: BOOLEAN = False
		-- <Precursor>
		-- We have to disable the invariant {EV_COLORIZABLE} background_color_not_void when executing `background_color'. Otherwise there is stack overflow when executing `background_color'.
		-- Because in the descendant SD_AUTO_HIDE_ZONE, this `background_color' is selected to replace the original `background_color' in the invariant.
		-- For example: When start Eiffel Studio 6.1 without empty application data, stack overflow will happen.

;note
	library:	"SmartDocking: Library of reusable components for Eiffel."
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
