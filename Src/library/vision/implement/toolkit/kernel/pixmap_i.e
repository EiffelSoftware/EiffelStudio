indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	PIXMAP_I 

inherit

	G_ANY
		export
			{NONE} all
		end

feature -- Status report

	is_valid: BOOLEAN is
			-- Is the pixmap valid and usable ?
		deferred
		end;

	last_operation_correct: BOOLEAN is
			-- Is the last operation correctly performed ?
		deferred
		end;

feature -- Measurement

	depth: INTEGER is
			-- Depth of pixmap (Number of colors)
		require
			is_valid: is_valid
		deferred
		ensure
			result_positive: Result >= 1
		end;

	height: INTEGER is
			-- Height of pixmap
		require
			is_valid: is_valid
		deferred
		ensure
			result_positive: Result >= 1
		end;

	hot_x: INTEGER is
			-- Horizontal position of "hot" point
		require
			is_valid: is_valid
		deferred
		ensure
			result_positive: Result >= 0
		end;

	hot_y : INTEGER is
			-- Vertical position of "hot" point
		require
			is_valid: is_valid
		deferred
		ensure
			result_positive: Result >= 0
		end;

	width: INTEGER is
			-- Width of pixmap
		require
			is_valid
		deferred
		ensure
			result_positive: Result >= 1
		end;

feature -- Basic operations

	copy_from (a_widget: WIDGET_I; x, y, p_width, p_height: INTEGER) is
			-- Copy the area specified by `x', `y', `p_width', `p_height' of
			-- `a_widget' into the pixmap.
			-- Set `last_operation_correct'.
		require
			a_widget_realized: a_widget.realized;
			left_edge_in_a_widget: x >= 0;
			top_edge_in_a_widget: y >= 0;
			width_positive: p_width > 0;
			height_positive: p_height > 0;
			right_edge_in_a_widget: x + p_width <= a_widget.width;
			bottom_edge_in_a_widget: y + p_height <= a_widget.height
		deferred
		ensure
			valid: last_operation_correct implies is_valid
		end;

	read_from_file (a_file_name: STRING) is
			-- Load the bitmap described in `a_file_name'.
			-- Set `last_operation_correct'.
		require
			a_file_name_exists: a_file_name /= Void
		deferred
		ensure
			valid_when_correct: last_operation_correct implies is_valid;
		end;

	store (a_file_name: STRING) is
			-- Store the pixmap into a file named `a_file_name'.
			-- Create the file if it doesn't exist and override else.
			-- Set `last_operation_correct'.
		require
			a_file_name_exists: a_file_name /= Void
			is_valid: is_valid
		deferred
		end;

invariant

	positive_width: is_valid implies (width > 0);
	positive_height: is_valid implies (height > 0);
	positive_depth: is_valid implies (depth > 0);
	valid_hot_x: is_valid implies ((hot_x >= 0) and (hot_x < width));
	valid_hot_y: is_valid implies ((hot_y >= 0) and (hot_y < height))

end -- class PIXMAP_I



--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

