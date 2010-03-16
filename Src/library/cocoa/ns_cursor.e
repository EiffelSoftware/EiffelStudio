note
	description: "Summary description for {NS_CURSOR}."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

	-- TODO should there be a class with the 'static' features? NS_CURSORS?

class
	NS_CURSOR

inherit
	NS_OBJECT

create {NS_OBJECT}
	share_from_pointer

create
	make,
	make_with_image

feature -- Access

	make
		do

		end

	make_with_image (a_image: NS_IMAGE; a_hot_spot: NS_POINT)
		do
			make_from_pointer ({NS_CURSOR_API}.alloc)
			{NS_CURSOR_API}.init_with_image_hot_spot (item, a_image.item, a_hot_spot.item)
		end

feature -- Setting Cursor Attributes

	image: detachable NS_IMAGE
			-- The cursor image or Void if none exists
		local
			l_result: POINTER
		do
			l_result := {NS_CURSOR_API}.image (item)
			if l_result /= default_pointer then
				create Result.share_from_pointer (l_result)
			end
		end

feature -- Retrieving Cursor Instances

	arrow_cursor: NS_CURSOR
			-- The default cursor, the arrow cursor.
		once
			create  Result.share_from_pointer ({NS_CURSOR_API}.arrow_cursor)
		end

	closed_hand_cursor: NS_CURSOR
		once
			create  Result.share_from_pointer ({NS_CURSOR_API}.closed_hand_cursor)
		end

	crosshair_cursor: NS_CURSOR
		once
			create  Result.share_from_pointer ({NS_CURSOR_API}.crosshair_cursor)
		end

	ibeam_cursor: NS_CURSOR
			-- A cursor that looks like a capital I with a tiny crossbeam at its middle.
		once
			create  Result.share_from_pointer ({NS_CURSOR_API}.ibeam_cursor)
		end

	open_hand_cursor: NS_CURSOR
			-- The open-hand system cursor.
		once
			create  Result.share_from_pointer ({NS_CURSOR_API}.open_hand_cursor)
		end

	pointing_hand_cursor: NS_CURSOR
		once
			create  Result.share_from_pointer ({NS_CURSOR_API}.pointing_hand_cursor)
		end

	resize_down_cursor: NS_CURSOR
		once
			create  Result.share_from_pointer ({NS_CURSOR_API}.resize_down_cursor)
		end

	resize_left_cursor: NS_CURSOR
		once
			create  Result.share_from_pointer ({NS_CURSOR_API}.resize_left_cursor)
		end

	resize_left_right_cursor: NS_CURSOR
		once
			create  Result.share_from_pointer ({NS_CURSOR_API}.resize_left_right_cursor)
		end

	resize_right_cursor: NS_CURSOR
		once
			create  Result.share_from_pointer ({NS_CURSOR_API}.resize_right_cursor)
		end

	resize_up_cursor: NS_CURSOR
		once
			create  Result.share_from_pointer ({NS_CURSOR_API}.resize_up_cursor)
		end

	resize_up_down_cursor: NS_CURSOR
		once
			create  Result.share_from_pointer ({NS_CURSOR_API}.resize_up_down_cursor)
		end

feature {NONE} -- Implementation

end
