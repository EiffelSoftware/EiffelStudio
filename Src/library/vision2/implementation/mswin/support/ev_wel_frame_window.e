indexing
	description: "EiffelVision wel frame window is a certain kind of %
				  % wel_frame_window designed for ev."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_WEL_FRAME_WINDOW

inherit
	WEL_FRAME_WINDOW
		redefine
			default_style,
			on_show,
			on_size,
			on_destroy,
			on_get_min_max_info
		end


creation
	make_top,
	make_child


feature
	
	initialize (the_container: EV_CONTAINER_IMP) is
		do
			container := the_container
		end


feature {NONE} -- Access

	container: EV_CONTAINER_IMP


feature {NONE} -- Implementation 

	default_style: INTEGER is
			-- Set with the option `Ws_clipchildren' to avoid flashing.
		once
			Result := Ws_overlappedwindow + Ws_clipchildren
		end

	on_show is
		do
			if container.the_child /= Void then
				container.parent_ask_resize (container.the_child.minimum_width, container.the_child.minimum_height)
			end
		end

	on_size (size_type, a_width, a_height: INTEGER) is
		do
			if container.the_child /= Void then
					container.the_child.parent_ask_resize (a_width, a_height)
			end
		end

	on_destroy is
		do
			if container.parent_imp /= Void then
				container.parent_imp.set_insensitive (False)
			end
		end

	on_get_min_max_info (min_max_info: WEL_MIN_MAX_INFO) is
		local
			min_track: WEL_POINT
		do
			!! min_track.make (container.the_child.minimum_width + 2*window_frame_width, container.the_child.minimum_height + title_bar_height + window_border_height + 2 * window_frame_height)
			min_max_info.set_min_track_size (min_track)
		end
	
end -- class EV_WEL_FRAME_WINDOW

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
