note
	description:
		"Graphical picture stored as a two dimensional map of pixels.%N%
		%Can be modified and displayed."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "drawable, primitives, figures, buffer, bitmap, picture"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_PIXMAP

inherit
	EV_DRAWABLE
		redefine
			is_in_default_state,
			implementation,
			create_implementation,
			is_equal,
			copy
		end

	EV_PRIMITIVE
		undefine
			set_background_color,
			background_color,
			set_foreground_color,
			foreground_color,
			is_equal,
			copy
		redefine
			is_in_default_state,
			is_in_default_state_for_tabs,
			implementation
		end

	EV_PIXMAP_ACTION_SEQUENCES
		undefine
			is_equal,
			copy
		redefine
			implementation
		end

create
	default_create,
	make_with_size,
	make_with_pointer_style,
	make_with_pixel_buffer

convert
	make_with_pointer_style ({EV_POINTER_STYLE}),
	make_with_pixel_buffer ({EV_PIXEL_BUFFER})

feature {NONE} -- Initialization

	make_with_size (a_width, a_height: INTEGER)
			-- Create with `a_width' and `a_height'.
		require
			a_width_positive: a_width > 0
			a_height_positive: a_height > 0
		do
			default_create
			set_size (a_width, a_height)
		ensure then
			width_assigned: width = a_width
			height_assigned: height = a_height
		end

	make_with_pointer_style (a_pointer_style: EV_POINTER_STYLE)
			-- Create from `a_pointer_style'.
		local
			l_temp: EV_POINTER_STYLE
		do
			default_create
			l_temp := a_pointer_style
			if l_temp = Void then
				create l_temp
			end
			implementation.init_from_pointer_style (l_temp)
		end

	make_with_pixel_buffer (a_pixel_buffer: EV_PIXEL_BUFFER)
			-- Create from `a_pixel_buffer'.
		require
			a_pixel_buffer_not_void: a_pixel_buffer /= Void
		do
			default_create
			implementation.init_from_pixel_buffer (a_pixel_buffer)
		end

feature -- Basic Operations

	flush
			-- Ensure that the appearance of `Current' is updated on screen
			-- immediately. Any changes that have not yet been reflected will
			-- become visible.
		require
			not_destroyed: not is_destroyed
		do
			implementation.flush
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
			-- Does `other' have the same appearance as `Current'.
		do
			if other /= Void then
					-- Images are proportional.
				Result := (
					width * other.height = other.width * height
				)
			end
		end

feature {EV_ANY} -- Contract support

	is_in_default_state: BOOLEAN
			-- Is `Current' in its default state?
		do
			Result := Precursor {EV_DRAWABLE} and then is_in_default_state_for_tabs
		end

	is_in_default_state_for_tabs: BOOLEAN
			-- Is `Current' in its default state with regards to tabs?
		do
			Result := not is_tabable_to and not is_tabable_from
		end

feature {EV_BUILDER} -- Access

	pixmap_path: detachable STRING_32
		-- Path of `pixmap'.

	pixmap_exists: BOOLEAN
		-- Does pixmap `pixmap_path' exist?

feature {EV_BUILDER} -- Status setting

	enable_pixmap_exists
			-- Assign `True' to `pixmap_exists'.
		do
			pixmap_exists := True
		ensure
			pixmap_exists_set: pixmap_exists
		end

	disable_pixmap_exists
			-- Assign `False' to `pixmap_exists'.
		do
			pixmap_exists := False
		ensure
			pixmap_exists_set: not pixmap_exists
		end

	set_pixmap_path (path: detachable STRING_GENERAL)
			-- Assign `path' to `pixmap_path'.
		do
			if path = Void then
				pixmap_path := Void
			else
				pixmap_path := path
			end
		ensure
			pixmap_path_set: attached path as l_path implies (attached pixmap_path as l_pixmap_path and then l_path.is_equal (l_pixmap_path))
		end

feature -- Status setting

	set_with_named_file (file_name: STRING_GENERAL)
			-- Attempt to load pixmap data from a file specified by `file_name'.
			-- May raise `Ev_unknown_image_format' or `Ev_corrupt_image_data'
			-- exceptions.
			-- See `supported_image_formats' in EV_ENVIRONMENT for valid file formats.
		require
			not_destroyed: not is_destroyed
			file_name_not_void: file_name /= Void
			file_name_not_empty: not file_name.is_empty
		do
			implementation.read_from_named_file (file_name)
		end

	set_size (a_width, a_height: INTEGER)
			-- Assign `a_width' and `a_height' to `width' and `weight'.
			-- Do not stretch image.
			-- May cause cropping.
		require
			not_destroyed: not is_destroyed
			a_width_positive: a_width > 0
			a_height_positive: a_height > 0
		do
			implementation.set_size (a_width, a_height)
		ensure
			width_assigned: width = a_width
			height_assigned: height = a_height
		end

	reset_for_buffering (a_width, a_height: INTEGER)
			-- Resets the size of the pixmap without keeping original image or clearing background.
			-- Useful when reusing `Current' as a back-buffer for blitting to other drawables.
		require
			width_valid: a_width > 0
			height_valid: a_height > 0
			not_destroyed: not is_destroyed
		do
			implementation.reset_for_buffering (a_width, a_height)
		end

	stretch (a_width, a_height: INTEGER)
			-- Assign `a_width' and `a_height' to `width' and `weight'.
			-- Stretch the image to new size.
		require
			not_destroyed: not is_destroyed
			a_width_positive: a_width > 0
			a_height_positive: a_height > 0
		do
			implementation.stretch (a_width, a_height)
		ensure
			width_assigned: width = a_width
			height_assigned: height = a_height
		end

	set_mask (a_mask: EV_BITMAP)
			-- set transparency mask of `current' to `a_mask'.
		require
			not_destroyed: not is_destroyed
			mask_not_void: a_mask /= Void
			mask_same_dimensions: a_mask.width = width and then a_mask.height = height
		do
			implementation.set_mask (a_mask)
		ensure
			mask_assigned:
		end

feature -- Duplication

	save_to_named_file (a_format: EV_GRAPHICAL_FORMAT; a_filename: FILE_NAME)
			-- Save `Current' to `a_filename' in format `a_format'.
		require
			not_destroyed: not is_destroyed
			a_format_not_void: a_format /= Void
			a_filename_not_void: a_filename /= Void
		do
			implementation.save_to_named_file (a_format, a_filename)
		end

	copy (other: like Current)
			-- Update `Current' to have same appearance as `other'.
			-- (So as to satisfy `is_equal'.)
		do
			if implementation = Void then
				default_create
			end
			if not other.is_destroyed then
				implementation.copy_pixmap (other)
			else
					-- `other' has been destroyed so we satisfy post-conditions
				implementation.set_size (other.implementation.width, other.implementation.height)
				implementation.destroy
			end
		end

feature {EV_ANY, EV_ANY_I, EV_ANY_HANDLER} -- Implementation

	implementation: EV_PIXMAP_I
			-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_PIXMAP_IMP} implementation.make
		end

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




end -- class EV_PIXMAP











