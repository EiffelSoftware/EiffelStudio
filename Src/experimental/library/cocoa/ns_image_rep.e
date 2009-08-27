note
	description: "Wrapper for NSImageRep."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_IMAGE_REP

inherit
	NS_OBJECT

create {NS_OBJECT} -- Creation
	share_from_pointer

feature -- Creating an NSImageRep

--	image_reps_with_contents_of_file (a_filename: NS_STRING): NS_ARRAY
--			-- Creates and returns an array of image representation objects initialized using the contents of the specified file.
--		do
--			create Result.share_from_pointer ({NS_IMAGE_REP_API}.image_reps_with_contents_of_file (a_filename.item))
--		end

--	image_reps_with_pasteboard (a_pasteboard: NS_PASTEBOARD): NS_ARRAY
--			-- Creates and returns an array of image representation objects initialized using the contents of the pasteboard.
--		do
--			create Result.share_from_pointer ({NS_IMAGE_REP_API}.image_reps_with_pasteboard (a_pasteboard.item))
--		end

--	image_reps_with_contents_of_url (a_url: NS_URL): NS_ARRAY
--			-- Creates and returns an array of image representation objects initialized using the contents of the specified URL.
--		do
--			create Result.share_from_pointer ({NS_IMAGE_REP_API}.image_reps_with_contents_of_url (a_url.item))
--		end

	image_rep_with_contents_of_file (a_filename: NS_STRING)
			-- Creates and returns an image representation object using the contents of the specified file.
		do
			make_from_pointer ({NS_IMAGE_REP_API}.image_rep_with_contents_of_file (a_filename.item))
		end

	image_rep_with_pasteboard (a_pasteboard: NS_PASTEBOARD)
			-- Creates and returns an image representation object using the contents of the specified pasteboard.
		do
			make_from_pointer ({NS_IMAGE_REP_API}.image_rep_with_pasteboard (a_pasteboard.item))
		end

--	image_rep_with_contents_of_url (a_url: NSURL): NS_OBJECT
--			-- Creates and returns an image representation object using the data at the specified URL
--		do
--			create Result.share_from_pointer ({NS_IMAGE_REP_API}.image_rep_with_contents_of_url (a_url.item))
--		end

feature -- Determining the Supported Image Types

	can_init_with_data (a_data: NS_DATA): BOOLEAN
			-- Returns a Boolean value indicating whether the receiver can initialize itself from the specified data.
		do
			Result := {NS_IMAGE_REP_API}.can_init_with_data (a_data.item)
		end

	can_init_with_pasteboard (a_pasteboard: NS_PASTEBOARD): BOOLEAN
			-- Returns a Boolean value indicating whether the receiver can initialize itself from the data on the specified pasteboard.
		do
			Result := {NS_IMAGE_REP_API}.can_init_with_pasteboard (a_pasteboard.item)
		end

--	image_types: NS_ARRAY
--			-- Returns an array of UTI strings identifying the image types supported by the receiver, either directly or through a user-installed filter service.
--		do
--			create Result.share_from_pointer ({NS_IMAGE_REP_API}.image_types ())
--		end

--	image_unfiltered_types: NS_ARRAY
--			-- Returns an array of UTI strings identifying the image types supported directly by the receiver.
--		do
--			create Result.share_from_pointer ({NS_IMAGE_REP_API}.image_unfiltered_types ())
--		end

--	image_file_types: NS_ARRAY
--			-- Returns the file types supported by `NSImageRep' or one of its subclasses.
--		do
--			create Result.share_from_pointer ({NS_IMAGE_REP_API}.image_file_types ())
--		end

--	image_pasteboard_types: NS_ARRAY
--			-- Returns the pasteboard types supported by `NSImageRep' or one of its subclasses.
--		do
--			create Result.share_from_pointer ({NS_IMAGE_REP_API}.image_pasteboard_types ())
--		end

--	image_unfiltered_file_types: NS_ARRAY
--			-- Returns the list of file types supported directly by the receiver.
--		do
--			create Result.share_from_pointer ({NS_IMAGE_REP_API}.image_unfiltered_file_types ())
--		end

--	image_unfiltered_pasteboard_types: NS_ARRAY
--			-- Returns the list of pasteboard types supported directly by the receiver.
--		do
--			create Result.share_from_pointer ({NS_IMAGE_REP_API}.image_unfiltered_pasteboard_types ())
--		end

feature -- Setting the Size of the Image

	set_size (a_size: NS_SIZE)
			-- Sets the size of the image representation to the specified value.
		do
			{NS_IMAGE_REP_API}.set_size (item, a_size.item)
		end

	size: NS_SIZE
			-- Returns the size of the image representation.
		do
			create Result.make
			{NS_IMAGE_REP_API}.size (item, Result.item)
		end

feature -- Specifying Information About the Representation

	bits_per_sample: INTEGER
			-- Returns the number of bits per sample in the receiver.
		do
			Result := {NS_IMAGE_REP_API}.bits_per_sample (item)
		end

	color_space_name: NS_STRING
			-- Returns the name of the receiver`s color space.
		do
			create Result.share_from_pointer ({NS_IMAGE_REP_API}.color_space_name (item))
		end

	has_alpha: BOOLEAN
			-- Returns a Boolean value indicating whether the receiver has an alpha channel.
		do
			Result := {NS_IMAGE_REP_API}.has_alpha (item)
		end

	is_opaque: BOOLEAN
			-- Returns a Boolean value indicating whether the receiver is opaque.
		do
			Result := {NS_IMAGE_REP_API}.is_opaque (item)
		end

	pixels_high: INTEGER
			-- Returns the height of the image, measured in pixels.
		do
			Result := {NS_IMAGE_REP_API}.pixels_high (item)
		end

	pixels_wide: INTEGER
			-- Returns the width of the image, measured in pixels.
		do
			Result := {NS_IMAGE_REP_API}.pixels_wide (item)
		end

	set_alpha (a_flag: BOOLEAN)
			-- Informs the receiver that its image data has an alpha component.
		do
			{NS_IMAGE_REP_API}.set_alpha (item, a_flag)
		end

	set_bits_per_sample (a_an_int: INTEGER)
			-- Informs the receiver that its image data has the specified number of bits for each component of a pixel.
		do
			{NS_IMAGE_REP_API}.set_bits_per_sample (item, a_an_int)
		end

	set_color_space_name (a_string: NS_STRING)
			-- Informs the receiver of the color space used by the image data.
		do
			{NS_IMAGE_REP_API}.set_color_space_name (item, a_string.item)
		end

	set_opaque (a_flag: BOOLEAN)
			-- Sets whether the receiver`s image is opaque.
		do
			{NS_IMAGE_REP_API}.set_opaque (item, a_flag)
		end

	set_pixels_high (a_an_int: INTEGER)
			-- Informs the receiver of the image data height.
		do
			{NS_IMAGE_REP_API}.set_pixels_high (item, a_an_int)
		end

	set_pixels_wide (a_an_int: INTEGER)
			-- Informs the receiver of the image data width.
		do
			{NS_IMAGE_REP_API}.set_pixels_wide (item, a_an_int)
		end

feature -- Drawing the Image

	draw: BOOLEAN
			-- Implemented by subclasses to draw the image in the current coordinate system.
		do
			Result := {NS_IMAGE_REP_API}.draw (item)
		end

	draw_at_point (a_point: NS_POINT): BOOLEAN
			-- Draws the receiver`s image data at the specified point in the current coordinate system.
		do
			Result := {NS_IMAGE_REP_API}.draw_at_point (item, a_point.item)
		end

	draw_in_rect (a_rect: NS_RECT): BOOLEAN
			-- Draws the image, scaling it (as needed) to fit the specified rectangle.
		do
			Result := {NS_IMAGE_REP_API}.draw_in_rect (item, a_rect.item)
		end

feature -- Managing NSImageRep Subclasses

--	image_rep_class_for_type (a_type: NS_STRING): POINTER
--			-- Returns the `NSImageRep' subclass that handles image data for the specified UTI.
--		do
--			create Result.make
--			{NS_IMAGE_REP_API}.image_rep_class_for_type (a_type.item, Result.item)
--		end

--	image_rep_class_for_data (a_data: NS_DATA): POINTER
--			-- Returns the `NSImageRep' subclass that handles the specified type of data.
--		do
--			create Result.make
--			{NS_IMAGE_REP_API}.image_rep_class_for_data (a_data.item, Result.item)
--		end

--	image_rep_class_for_file_type (a_type: NS_STRING): POINTER
--			-- Returns the `NSImageRep' subclass that handles data with the specified type.
--		do
--			create Result.make
--			{NS_IMAGE_REP_API}.image_rep_class_for_file_type (a_type.item, Result.item)
--		end

--	image_rep_class_for_pasteboard_type (a_type: NS_STRING): POINTER
--			-- Returns the `NSImageRep' subclass that handles data with the specified pasteboard type.
--		do
--			create Result.make
--			{NS_IMAGE_REP_API}.image_rep_class_for_pasteboard_type (a_type.item, Result.item)
--		end

--	registered_image_rep_classes: NS_ARRAY
--			-- Returns an array containing the registered `NSImageRep' classes.
--		do
--			create Result.share_from_pointer ({NS_IMAGE_REP_API}.registered_image_rep_classes ())
--		end

--	register_image_rep_class (a_image_rep_class: POINTER)
--			-- Adds the specified class to the registry of available `NSImageRep' subclasses.
--		do
--			{NS_IMAGE_REP_API}.register_image_rep_class (a_image_rep_class.item)
--		end

--	unregister_image_rep_class (a_image_rep_class: POINTER)
--			-- Removes the specified `NSImageRep' subclass from the registry of available image representations.
--		do
--			{NS_IMAGE_REP_API}.unregister_image_rep_class (a_image_rep_class.item)
--		end

end
