
indexing

	date: "$Date$";
	revision: "$Revision$"

class PIXMAP 

inherit

	G_ANY
		export
			{NONE} all
		end

creation

	make

feature 

	copy_from (a_widget: WIDGET; x, y, p_width, p_height: INTEGER) is
			-- Copy the area specified by `x', `y', `p_width', `p_height' of
			-- `a_widget' into the pixmap.
			-- Set `last_operation_correct'.
		require
			a_widget_realized: a_widget.realized;
			left_edge_in_a_widget: x >= 0;
			top_edge_in_a_widget: y >= 0;
			width_positive: p_width > 0;
			height_positive: p_height > 0;
			right_edge_in_a_widget: x+p_width <= a_widget.width;
			bottom_edge_in_a_widget: y+p_height <= a_widget.height
		do
			implementation.copy_from (a_widget.implementation, x, y, p_width, p_height)
		ensure
			last_operation_correct implies is_valid
		end; -- copy_from

	make is
			-- Create a bitmap.
		do
			implementation := toolkit.pixmap (Current)
		end; -- Create

	depth: INTEGER is
			-- Depth of pixmap (Number of colors)
		require
			is_valid
		do
			Result := implementation.depth
		ensure
			Result >= 1
		end; -- depth

	height: INTEGER is
			-- Height of pixmap
		require
			is_valid
		do
			Result := implementation.height
		ensure
			Result >= 1
		end; -- height

	hot_x: INTEGER is
			-- Horizontal position of "hot" point
		require
			is_valid
		do
			Result := implementation.hot_x
		ensure
			Result >= 0
		end; -- hot_x

	hot_y : INTEGER is
			-- Vertical position of "hot" point
		require
			is_valid
		do
			Result := implementation.hot_y
		ensure
			Result >= 0
		end; -- hot_y

	implementation: PIXMAP_I;
			-- Implementation of PIXMAP

	is_valid: BOOLEAN is
			-- Is the pixmap valid and usable ?
		do
			Result := implementation.is_valid
		end; -- is_valid

	last_operation_correct: BOOLEAN is
			-- Is the last operation correctly performed ?
		do
			Result := implementation.last_operation_correct
		end; -- last_operation_correct

	read_from_file (a_file_name: STRING) is
			-- Load the bitmap described in `a_file_name'.
			-- `a_file_name' must be a X11 bitmap file.
			-- Set `last_operation_correct'.
		require
			a_file_name_exists: not (a_file_name = Void)
		do
			implementation.read_from_file (a_file_name)
		ensure
			last_operation_correct implies is_valid;
			last_operation_correct implies depth <= 2
		end; -- read_from_file

	retrieve (a_file_name: STRING) is
			-- Retreive the pixmap from a file named `a_file_name'.
			-- Set `last_operation_correct'.
		require
			a_file_name_exists: not (a_file_name = Void)
		do
			implementation.retrieve (a_file_name)
		ensure
			last_operation_correct implies is_valid
		end; -- retrieve

	store (a_file_name: STRING) is
			-- Store the pixmap into a file named `a_file_name'.
			-- Create the file if it doesn't exist and override else.
			-- Set `last_operation_correct'.
		require
			a_file_name_exists: not (a_file_name = Void);
			is_valid: is_valid
		do
			implementation.store (a_file_name)
		end; -- store

	width: INTEGER is
			-- Width of pixmap
		require
			is_valid
		do
			Result := implementation.width
		ensure
			Result >= 1
		end -- width

invariant

	is_valid implies (width > 0);
	is_valid implies (height > 0);
	is_valid implies (depth > 0);
	is_valid implies ((hot_x >= 0) and (hot_x < width));
	is_valid implies ((hot_y >= 0) and (hot_x < height))

end -- class PIXMAP


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
