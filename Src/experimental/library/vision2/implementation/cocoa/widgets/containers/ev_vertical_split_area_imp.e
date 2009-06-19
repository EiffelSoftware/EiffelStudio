note
	description:
		"Eiffel Vision Split Area, Cocoa implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_VERTICAL_SPLIT_AREA_IMP

inherit
	EV_VERTICAL_SPLIT_AREA_I
		undefine
			propagate_foreground_color,
			propagate_background_color
		redefine
			interface
		end

	EV_SPLIT_AREA_IMP
		redefine
			interface,
			client_height,
			client_width,
			make
		end

create
	make

feature -- Creation

	make
		do
			create {NS_SPLIT_VIEW}cocoa_item.make
			split_view.set_vertical (False)
			Precursor {EV_SPLIT_AREA_IMP}
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
				mw := mw.max (second.minimum_width)
				mh := mh + second.minimum_height + sep_wid
			end
			internal_set_minimum_size (mw, mh)
		end

	compute_minimum_height
			-- Recompute the minimum_height of `Current'.
		local
			mh, sep_wid: INTEGER
		do
			if first_visible then
				mh := first.minimum_height
				sep_wid := splitter_width
			end
			if second_visible then
				mh := mh + second.minimum_height + sep_wid
			end
			internal_set_minimum_height (mh)
		end

	compute_minimum_width
			-- Recompute the minimum_width of `Current'.
		local
			mw: INTEGER
		do
			if first_visible then
				mw := first.minimum_width
			end
			if second_visible then
				mw := mw.max (second.minimum_width)
			end
			internal_set_minimum_width (mw)
		end

feature -- access

	client_width: INTEGER
			-- Width of the client area of container.
			-- Redefined in children.
		do
			Result := width
		end

	client_height: INTEGER
			-- Height of the client area of container
			-- Redefined in children.
		do
			Result := (height - splitter_width).max(0)
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
					first_imp.set_move_and_size (0, 0, width, internal_split_position)
					second_imp.set_move_and_size (0, internal_split_position +
						splitter_width, width, height - internal_split_position -
						splitter_width)
				else
					first_imp.ev_apply_new_size (0, 0, width, internal_split_position,
						True)
					second_imp.ev_apply_new_size (0, internal_split_position +
						splitter_width, width, height - internal_split_position -
						splitter_width, True)
				end
			end

			split_view.adjust_subviews
		end

feature {EV_ANY_I} -- Implementation

	interface: detachable EV_VERTICAL_SPLIT_AREA note option: stable attribute end;
			-- Provides a common user interface to possibly dependent
			-- functionality implemented by `Current'.

note
	copyright:	"Copyright (c) 2009, Daniel Furrer"
end -- class EV_VERTICAL_SPLIT_AREA_IMP

