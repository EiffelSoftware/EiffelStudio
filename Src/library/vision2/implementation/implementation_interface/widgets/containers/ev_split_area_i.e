indexing
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

	item: EV_WIDGET is
			-- Current item.
		do
			if item_refers_to_second then
				Result := second
			else
				Result := first
			end
		end

feature -- Status report

	count: INTEGER is
			-- Number of items in `Current'
		do
			if first /= Void then
				Result := 1
			end
			if second /= Void then
				Result := Result + 1
			end
		end

	has (v: like item): BOOLEAN is
			-- Does structure include `v'?
		do
			Result := v = first or else v = second
		end

	minimum_split_position: INTEGER is
			-- Minimum position the splitter can have.
		deferred
		ensure
			Result_not_negative: Result >= 0
			Result_valid: Result <= maximum_split_position
		end

	maximum_split_position: INTEGER is
			-- Maximum position the splitter can have.
		deferred
		ensure
			Result_not_negative: Result >= 0
			Result_valid: Result >= minimum_split_position
		end

	is_item_expanded (an_item: EV_WIDGET): BOOLEAN is
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

	set_first (an_item: like item) is
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

	set_second (an_item: like item) is
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

	go_to_first is
			-- Make `first' current `item'.
		require
			first_exist: first /= Void
		do
			item_refers_to_second := False
		ensure
			item_is_first: item = first
		end

	go_to_second is
			-- Make `second' current `item'.
		require
			second_exists: second /= Void
		do
			item_refers_to_second := True
		ensure
			item_is_second: item = second
		end

	set_proportion (a_proportion: REAL) is
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

	enable_item_expand (an_item: EV_WIDGET) is
			-- When `Current' is resized, resize `an_item' respectively.
		deferred
		end

	disable_item_expand (an_item: EV_WIDGET) is
			-- When `Current' is resized, do not resize `an_item'.
		deferred
		end

	set_split_position (a_split_position: INTEGER) is
			-- Make `a_split_position' position of splitter in pixels.
		deferred
		end

	enable_flat_separator is
			-- Set the separator to be "flat"
		obsolete "All split areas are now flat by default."
		do
		end

	disable_flat_separator is
			-- Set the separator to be "raised"
		obsolete "All split areas are now flat by default."
		do
		end

feature -- Element change

	put (an_item: like item) is
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

	extend (an_item: like item) is
			-- Assign `an_item' to `first_item' if not already assigned or to
			-- `second_item' otherwise.
		do
			if first = Void then
				set_first (an_item)
			else
				set_second (an_item)
			end
		end

	replace (an_item: like item) is
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

	prune (v: like item) is
			-- Remove occurrence of `v' if any.
		deferred
		end

	wipe_out is
			-- Remove all items.
		do
			prune (first)
			prune (second)
			item_refers_to_second := False
		end

feature -- Conversion

	linear_representation: LINEAR [like item] is
			-- Representation as a linear structure.
		local
			l: LINKED_LIST [like item]
		do
			create l.make
			if first /= Void then
				l.extend (first)
			end
			if second /= Void then
				l.extend (second)
			end
			Result := l
		end

feature {EV_SPLIT_AREA} -- Implementation

	item_refers_to_second: BOOLEAN
			-- Is `item' referring to `second'.

	split_position: INTEGER is
			-- Offset of the splitter from the left or top.
		deferred
		end

	first_expandable: BOOLEAN
			-- Is `first' expandable?

	second_expandable: BOOLEAN
			-- Is `second' expandable?

	splitter_width: INTEGER is
			-- Width of splitter.
		deferred
		end

feature {EV_SPLIT_AREA_I} -- Status Report

	first_visible: BOOLEAN is
			-- Is `first' not Void and visible?
		do
			Result := first /= Void and first.is_show_requested
		end

	second_visible: BOOLEAN is
			-- Is `second' not Void and visible?
		do
			Result := second /= Void and second.is_show_requested
		end

feature {EV_ANY_I, EV_ANY} -- Implementation

	interface: EV_SPLIT_AREA;

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




end -- class EV_SPLIT_AREA_I

