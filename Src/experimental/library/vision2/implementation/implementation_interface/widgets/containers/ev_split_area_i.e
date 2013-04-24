note
	description:
		"Contains two widgets, each on either side of an adjustable separator."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_SPLIT_AREA_I

inherit

	EV_CONTAINER_I
		redefine
			interface,
			item,
			extend
		end

feature -- Access

	first: like item
			-- First item of `Current'.

	second: like item
			-- Second item of `Current'.

	item: detachable EV_WIDGET
			-- Current item.
		do
			if item_refers_to_second then
				Result := second
			else
				Result := first
			end
		end

feature -- Status report

	count: INTEGER
			-- Number of items in `Current'
		do
			if first /= Void then
				Result := 1
			end
			if second /= Void then
				Result := Result + 1
			end
		end

	has (v: like item): BOOLEAN
			-- Does structure include `v'?
		do
			Result := v = first or else v = second
		end

	minimum_split_position: INTEGER
			-- Minimum position the splitter can have.
		deferred
		ensure
			Result_not_negative: Result >= 0
			Result_valid: Result <= maximum_split_position
		end

	maximum_split_position: INTEGER
			-- Maximum position the splitter can have.
		deferred
		ensure
			Result_not_negative: Result >= 0
			Result_valid: Result >= minimum_split_position
		end

	is_item_expanded (an_item: EV_WIDGET): BOOLEAN
			-- Is `an_item' expanded relative to `Current'?
		require
			an_item_not_void: an_item /= Void
			has_an_item: has (an_item)
		do
			if an_item = first then
				Result := first_expandable
			elseif an_item = second then
				Result := second_expandable
			end
		end

feature -- Status setting

	set_first (an_item: like item)
			-- Assign `an_item' to first.
		require
			an_item_not_void: an_item /= Void
			an_item_not_in_split_area: not has (an_item)
			an_item_parent_void: an_item.parent = Void
			first_is_void: first = Void
		deferred
		ensure
			first_set: first = an_item
			an_item_parent_is_current: an_item.parent = interface
			an_item_not_expanded: not is_item_expanded (an_item)
		end

	set_second (an_item: like item)
			-- Assign `an_item' to second.
		require
			an_item_not_void: an_item /= Void
			an_item_not_in_split_area: not has (an_item)
			an_item_parent_void: an_item.parent = Void
			second_is_void: second = Void
		deferred
		ensure
			second_set: second = an_item
			an_item_parent_is_current: an_item.parent = interface
			an_item_expanded: is_item_expanded (an_item)
		end

	go_to_first
			-- Make `first' current `item'.
		require
			first_exist: first /= Void
		do
			item_refers_to_second := False
		ensure
			item_is_first: item = first
		end

	go_to_second
			-- Make `second' current `item'.
		require
			second_exists: second /= Void
		do
			item_refers_to_second := True
		ensure
			item_is_second: item = second
		end

	set_proportion (a_proportion: REAL)
			-- Position `split_position' between minimum and maximum determined
			-- by `a_proportion'.
		require
			proportion_in_valid_range:
				(a_proportion >= 0 and a_proportion <= 1)
		local
			max_sp, min_sp: INTEGER
		do
			max_sp := maximum_split_position
			min_sp := minimum_split_position
			set_split_position (((max_sp - min_sp).to_real * a_proportion).rounded +
				min_sp)
		end

	enable_item_expand (an_item: EV_WIDGET)
			-- When `Current' is resized, resize `an_item' respectively.
		deferred
		end

	disable_item_expand (an_item: EV_WIDGET)
			-- When `Current' is resized, do not resize `an_item'.
		deferred
		end

	set_split_position (a_split_position: INTEGER)
			-- Make `a_split_position' position of splitter in pixels.
		deferred
		end

	enable_flat_separator
			-- Set the separator to be "flat"
		obsolete "All split areas are now flat by default."
		do
		end

	disable_flat_separator
			-- Set the separator to be "raised"
		obsolete "All split areas are now flat by default."
		do
		end

feature -- Element change

	put (an_item: EV_WIDGET)
			-- Replace `item' with `an_item'.
		do
			if item = first then
				prune (first)
				set_first (an_item)
			elseif item = second then
				prune (second)
				set_second (an_item)
			end
		ensure
			item_position_not_changed: (old item = old first implies item = first) or
				(old item = old second implies item = second)
		end

	extend (an_item: EV_WIDGET)
			-- Assign `an_item' to `first_item' if not already assigned or to
			-- `second_item' otherwise.
		do
			if first = Void then
				set_first (an_item)
			else
				set_second (an_item)
			end
		end

	replace (an_item: EV_WIDGET)
			-- Replace item with `an_item'.
		do
			prune (item)
			if item_refers_to_second then
				set_second (an_item)
			else
				set_first (an_item)
			end
		end

feature -- Removal

	prune (v: like item)
			-- Remove occurrence of `v' if any.
		deferred
		end

	wipe_out
			-- Remove all items.
		do
			prune (first)
			prune (second)
			item_refers_to_second := False
		end

feature -- Conversion

	linear_representation: LINEAR [EV_WIDGET]
			-- Representation as a linear structure.
		local
			l: LINKED_LIST [EV_WIDGET]
		do
			create l.make
			if attached first as l_first then
				l.extend (l_first)
			end
			if attached second as l_second then
				l.extend (l_second)
			end
			Result := l
		end

feature {EV_SPLIT_AREA} -- Implementation

	item_refers_to_second: BOOLEAN
			-- Is `item' referring to `second'.

	split_position: INTEGER
			-- Offset of the splitter from the left or top.
		deferred
		end

	first_expandable: BOOLEAN
			-- Is `first' expandable?

	second_expandable: BOOLEAN
			-- Is `second' expandable?

	splitter_width: INTEGER
			-- Width of splitter.
		deferred
		end

feature {EV_SPLIT_AREA_I} -- Status Report

	first_visible: BOOLEAN
			-- Is `first' not Void and visible?
		do
			Result := attached first as l_first and then l_first.is_show_requested
		end

	second_visible: BOOLEAN
			-- Is `second' not Void and visible?
		do
			Result := attached second as l_second and then l_second.is_show_requested
		end


feature {EV_ANY_I} -- Implementation

	update_for_pick_and_drop (starting: BOOLEAN)
			-- Pick and drop status has changed so notify `first_imp' and `second_imp'.
		do
			if attached first as l_first then
				l_first.implementation.update_for_pick_and_drop (starting)
			end
			if attached second as l_second then
				l_second.implementation.update_for_pick_and_drop (starting)
			end
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_SPLIT_AREA note option: stable attribute end;

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




end -- class EV_SPLIT_AREA_I








