note
	description:
		"Eiffel Vision Split Area, Cocoa implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_HORIZONTAL_SPLIT_AREA_IMP

inherit
	EV_HORIZONTAL_SPLIT_AREA_I
		undefine
			propagate_foreground_color,
			propagate_background_color
		redefine
			interface
		end

	EV_SPLIT_AREA_IMP
		redefine
			interface
		end

create
	make

feature

	make (an_interface: like interface)
		-- Connect interface and initialize `c_object'.
	do
		base_make (an_interface)
		create {NS_SPLIT_VIEW}cocoa_item.make
		split_view.set_vertical (True)
	end

feature {NONE} -- Implementation

	compute_minimum_size
			-- Recompute the minimum_size of `Current'.
		local
			mh, mw, sep_wid: INTEGER
		do
			if first_visible then
				mw := first.minimum_width
				mh := first.minimum_height
				sep_wid := splitter_width
			end
			if second_visible then
				mw := mw + second.minimum_width + sep_wid
				mh := mh.max (second.minimum_height)
			end
			internal_set_minimum_size (mw, mh)
		end

	compute_minimum_height
			-- Recompute the minimum_height of `Current'.
		local
			mh: INTEGER
		do
			if first_visible then
				mh := first.minimum_height
			end
			if second_visible then
				mh := mh.max (second.minimum_height)
			end
			internal_set_minimum_height (mh)
		end

	compute_minimum_width
			-- Recompute the minimum_width of `Current'.
		local
			mw: INTEGER
			sep_wid: INTEGER
		do
			if first_visible then
				mw := first.minimum_width
				sep_wid := splitter_width
			end
			if second_visible then
				mw := mw + second.minimum_width + sep_wid
			end
			internal_set_minimum_width (mw)
		end

	layout_widgets (originator: BOOLEAN)
		do
			if first_visible and not second_visible then
				if originator then
					first_imp.set_move_and_size (0, 0, width, height)
				else
					first_imp.ev_apply_new_size (0, 0, width, height, True)
				end
			end

			if second_visible and not first_visible then
				if originator then
					second_imp.set_move_and_size (0, 0, width, height)
				else
					second_imp.ev_apply_new_size (0, 0, width, height, True)
				end
			end

			if first_visible and second_visible then
				if originator then
					first_imp.set_move_and_size (0, 0, internal_split_position, height)
					second_imp.set_move_and_size
						(internal_split_position + splitter_width, 0, width -
						internal_split_position - splitter_width, height)
				else
					first_imp.ev_apply_new_size (0, 0, internal_split_position, height,
						True)
					second_imp.ev_apply_new_size
						(internal_split_position + splitter_width, 0, width -
						internal_split_position - splitter_width, height, True)
				end
			end

			split_view.adjust_subviews
		end

 feature {EV_ANY_I} -- Implementation

	interface: EV_HORIZONTAL_SPLIT_AREA;
			-- Provides a common user interface to possibly dependent
			-- functionality implemented by `Current'.

note
	copyright:	"Copyright (c) 2009, Daniel Furrer"
end -- class EV_HORIZONTAL_SPLIT_AREA_IMP

