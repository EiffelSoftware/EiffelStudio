note
	description: "Eiffel Vision Split Area, Cocoa implementation."
	author: "Daniel Furrer"
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
			create split_view.make
			split_view.set_vertical (False)
			cocoa_view := split_view
			Precursor {EV_SPLIT_AREA_IMP}
		end

feature {NONE} -- Implementation

	compute_minimum_size
			-- Recompute the minimum_size of `Current'.
		local
			mh, mw, sep_wid: INTEGER
		do
			if first_visible and then attached first as l_first then
				mw := l_first.minimum_width
				mh := l_first.minimum_height
				sep_wid := splitter_width
			end
			if second_visible and then attached second as l_second then
				mw := mw.max (l_second.minimum_width)
				mh := mh + l_second.minimum_height + sep_wid
			end
			internal_set_minimum_size (mw, mh)
		end

	compute_minimum_height
			-- Recompute the minimum_height of `Current'.
		local
			mh, sep_wid: INTEGER
		do
			if first_visible and then attached first as l_first then
				mh := l_first.minimum_height
				sep_wid := splitter_width
			end
			if second_visible and then attached second as l_second then
				mh := mh + l_second.minimum_height + sep_wid
			end
			internal_set_minimum_height (mh)
		end

	compute_minimum_width
			-- Recompute the minimum_width of `Current'.
		local
			mw: INTEGER
		do
			if first_visible and then attached first as l_first then
				mw := l_first.minimum_width
			end
			if second_visible and then attached second as l_second then
				mw := mw.max (l_second.minimum_width)
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
		local
			l_first_imp: like first_imp
			l_second_imp: like second_imp
		do
			if first_visible and not second_visible then
				l_first_imp := first_imp
				check l_first_imp /= Void end
				if originator then
					l_first_imp.set_move_and_size (0, 0, width, height)
				else
					l_first_imp.ev_apply_new_size (0, 0, width, height, True)
				end
			end

			if second_visible and not first_visible then
				l_second_imp := second_imp
				check l_second_imp /= Void end
				if originator then
					l_second_imp.set_move_and_size (0, 0, width, height)
				else
					l_second_imp.ev_apply_new_size (0, 0, width, height, True)
				end
			end

			if first_visible and second_visible then
				l_first_imp := first_imp
				l_second_imp := second_imp
				check l_first_imp /= Void and l_second_imp /= Void end
				if originator then
					l_first_imp.set_move_and_size (0, 0, width, internal_split_position)
					l_second_imp.set_move_and_size (0, internal_split_position +
						splitter_width, width, height - internal_split_position -
						splitter_width)
				else
					l_first_imp.ev_apply_new_size (0, 0, width, internal_split_position,
						True)
					l_second_imp.ev_apply_new_size (0, internal_split_position +
						splitter_width, width, height - internal_split_position -
						splitter_width, True)
				end
			end

			split_view.adjust_subviews
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_VERTICAL_SPLIT_AREA note option: stable attribute end;
			-- Provides a common user interface to possibly dependent
			-- functionality implemented by `Current'.

end -- class EV_VERTICAL_SPLIT_AREA_IMP
