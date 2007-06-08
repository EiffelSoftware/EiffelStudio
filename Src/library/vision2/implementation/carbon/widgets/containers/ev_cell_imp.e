indexing
	description:
		"Eiffel Vision cell, Carbon implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_CELL_IMP

inherit
	EV_CELL_I
		undefine
			propagate_foreground_color,
			propagate_background_color
		redefine
			interface
		end

	EV_CONTAINER_IMP
		redefine
			interface,
			replace,
			child_offset_bottom,
			child_offset_top,
			child_offset_left,
			child_offset_right
		end

	EV_DOCKABLE_TARGET_IMP
		redefine
			interface
		end

	CONTROLDEFINITIONS_FUNCTIONS_EXTERNAL
		export
			{NONE} all
		end

create
	make

feature -- initialization

	make (an_interface: like interface) is
			-- Connect interface and initialize `c_object'.
		local
			ret: INTEGER
			rect: RECT_STRUCT
			ptr: POINTER
		do
			base_make (an_interface)
			create rect.make_new_unshared
			rect.set_left (20)
			rect.set_right (100)
			rect.set_bottom (40)
			rect.set_top (20)
			ret := create_user_pane_control_external( null, rect.item,{CONTROLS_ANON_ENUMS}.kControlSupportsEmbedding, $ptr )
			set_c_object ( ptr )
		end

feature -- Access

	item: EV_WIDGET
			-- Current item.

feature -- Element change

	replace (v: like item) is
			-- Replace `item' with `v'.
		do
			Precursor {EV_CONTAINER_IMP} (v)
			item := v
		end
feature -- Measurement

	child_offset_bottom: INTEGER
	do
		Result := 2
	end

	child_offset_right: INTEGER
	do
		Result := 2
	end

	child_offset_left: INTEGER
	do
		Result := 2
	end

	child_offset_top: INTEGER
	do
		Result := 2
	end

	calculate_minimum_sizes is
			-- Calculate the CGRECTS rect_a, rect_b and splitter_rect
		do
			if temp_item /= void then
				buffered_minimum_width := (temp_item.minimum_width + child_offset_left + child_offset_right).max(internal_minimum_width)
				buffered_minimum_height := (temp_item.minimum_height + child_offset_top + child_offset_bottom).max(internal_minimum_height)
			elseif item /= void then
					buffered_minimum_width := (item.minimum_width + child_offset_left + child_offset_right).max(internal_minimum_width)
					buffered_minimum_height := (item.minimum_height + child_offset_top + child_offset_bottom).max(internal_minimum_height)
			else
					buffered_minimum_width := internal_minimum_width.max (child_offset_left + child_offset_right)
					buffered_minimum_height := internal_minimum_height.max (child_offset_top + child_offset_bottom)
			end
		end

--	minimum_width: INTEGER is
--		local
--			a,b: INTEGER
--		do
--			a := internal_minimum_width
--			if item /= void then
--				b := item.minimum_width + child_offset_right + child_offset_left
--			end
--			Result := a.max (b)

--		end

--	minimum_height: INTEGER is
--		local
--			a,b: INTEGER
--		do
--			a := internal_minimum_height
--			if item /= void then
--				b := item.minimum_height + child_offset_top + child_offset_bottom
--			end
--			Result := a.max (b)

--		end

feature {EV_ANY_I} -- Implementation

	interface: EV_CELL;
			-- Provides a common user interface to possibly dependent
			-- functionality implemented by `Current'.

indexing
	copyright:	"Copyright (c) 2006, The Eiffel.Mac Team"
end -- class EV_CELL_IMP

