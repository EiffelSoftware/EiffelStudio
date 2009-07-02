note
	description: "Wrapper for NSImage."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_IMAGE

inherit
	NS_OBJECT
		undefine
			copy
		end

	NS_COPYING

create
	make_with_referencing_file,
	make_with_size,
	make_named
create {NS_OBJECT}
	make_from_pointer,
	share_from_pointer

feature {NONE} -- Creation

	make_with_referencing_file (a_path: STRING_GENERAL)
		do
			make_from_pointer ({NS_IMAGE_API}.init_by_referencing_file ((create {NS_STRING}.make_with_string(a_path)).item))
		end

	make_with_size (a_size: NS_SIZE)
		do
			make_from_pointer ({NS_IMAGE_API}.init_with_size (a_size.item))
		end

	make_named (a_name: STRING_GENERAL)
		do
			make_from_pointer ({NS_IMAGE_API}.image_named ((create {NS_STRING}.make_with_string (a_name)).item))
		end

feature -- Access

	size: NS_SIZE
			-- Returns the size of the receiver.
			-- The size of the receiver or (0.0, 0.0) if no size has been set and the size cannot be determined from any of the receiver's image representations.
		do
			create Result.make
			{NS_IMAGE_API}.size (item, Result.item)
		ensure
			Result.width >= 0
			Result.height >= 0
		end

	set_size (a_size: NS_SIZE)
		do
			{NS_IMAGE_API}.set_size (item, a_size.item)
		end

	representations: NS_ARRAY [NS_IMAGE_REP]
			-- Returns an array containing all of the receiver's image representations.
		do
			create Result.share_from_pointer ({NS_IMAGE_API}.representations (item))
		end

	draw (a_point: NS_POINT; a_from_rect: NS_RECT; a_op: INTEGER; a_delta: REAL)
			-- Draws all or part of the image at the specified point in the current coordinate system.
			-- `delta': The opacity of the image, specified as a value from 0.0 to 1.0. Specifying a value of 0.0 draws the image as fully transparent
			--  while a value of 1.0 draws the image as fully opaque. Values greater than 1.0 are interpreted as 1.0.
		require
			a_point /= void
			a_from_rect /= void
			valid_operation: valid_operation (a_op)
		do
			{NS_IMAGE_API}.draw_at_point_from_rect_operation_fraction (item, a_point.item, a_from_rect.item, a_op, a_delta)
		end

	lock_focus
			-- Prepares the image to receive drawing commands.
		do
			{NS_IMAGE_API}.lock_focus (item)
		end

	unlock_focus
			-- Removes the focus from the receiver.
		do
			{NS_IMAGE_API}.unlock_focus (item)
		end

	set_flipped (a_flag: BOOLEAN)
			-- Sets whether the polarity of the y axis is inverted when drawing an image.
		do
			{NS_IMAGE_API}.set_flipped (item, a_flag)
		ensure
			flipped_set: a_flag = is_flipped
		end

	is_flipped: BOOLEAN
			-- Returns a Boolean value indicating whether the image uses a flipped coordinate system.
		do
			Result := {NS_IMAGE_API}.is_flipped (item)
		end

feature -- Contract Support

	valid_operation (a_integer: INTEGER): BOOLEAN
		do
			 Result := (<<composite_clear, composite_copy, composite_source_over, composite_xor>>).has (a_integer)
		end

feature -- NSCompositingOperation Constants

	frozen composite_clear: INTEGER
			-- Transparent. (R = 0)
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSCompositeClear"
		end

	frozen composite_copy: INTEGER
			-- Source image. (R = S)
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSCompositeCopy"
		end

	frozen composite_source_over: INTEGER
			-- Source image wherever source image is opaque, and destination image elsewhere. (R = S + D*(1 - Sa))
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSCompositeSourceOver"
		end

	frozen composite_xor: INTEGER
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSCompositeXOR"
		end

feature {NS_IMAGE_CONSTANTS} -- Named Images

	frozen image_name_info: POINTER
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSImageNameInfo"
		end

end
