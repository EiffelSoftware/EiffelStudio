indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class WIDGET_RATIO

creation

	make, make_with_widget

feature  {NONE}

	make (a_widget: WIDGET; 
			to_foll_x, to_foll_y,
			width_res, height_res: BOOLEAN) is
		do
			widget := a_widget;
			to_follow_x := to_foll_x;
			to_follow_y := to_foll_y;
			is_width_resizeable := width_res;
			is_height_resizeable := height_res
		end;

	make_with_widget (a_widget: WIDGET) is
		do
			widget := a_widget
		end;

feature

	set_ratios (parent_width, parent_height: INTEGER) is
		require
			valid_parent_width: parent_width > 0;
			valid_parent_height: parent_height > 0;
		do
			x_ratio := widget.x / parent_width;
			y_ratio := widget.y / parent_height;
			width_ratio := widget.width / parent_width;
			height_ratio := widget.height / parent_height;
		end;

feature {NONE}

		
	is_width_resizeable: BOOLEAN;
	is_height_resizeable: BOOLEAN;
	to_follow_x: BOOLEAN;
	to_follow_y: BOOLEAN;
	
		-- Ratios
	x_ratio: REAL;
	y_ratio: REAL;
	width_ratio: REAL;
	height_ratio: REAL;

feature 

	widget: WIDGET;

	update_widget (parent_width, parent_height: INTEGER) is
		require
			widget_not_destroyed: not widget.destroyed
		do
			if widget.managed then
				if widget.managed then
					widget.unmanage
				end;
				if is_width_resizeable then
					widget.set_width (
						(parent_width * width_ratio).truncated_to_integer);
				end;
				if is_height_resizeable then
					widget.set_height (
						(parent_height * height_ratio).truncated_to_integer);
				end;
				if to_follow_x then
					widget.set_x (
						(parent_width * x_ratio).truncated_to_integer);
				end;
				if to_follow_y then
					widget.set_y (
						(parent_height * y_ratio).truncated_to_integer);
				end;
				widget.manage
			end;
		end;

feature {SCALABLE}

	useless: BOOLEAN is
		-- The widget ratio is useless in the list,
		-- i.e. the widget geometry will not be
		-- modified if the size of the parent is modified
		do
			Result := not to_follow_x and not to_follow_y and
				not is_width_resizeable and
				not is_height_resizeable
		end;

	width_resizeable (flag: BOOLEAN) is
		do
			is_width_resizeable := flag;
		end;

	height_resizeable (flag: BOOLEAN) is
		do
			is_height_resizeable := flag;
		end;

	follow_x (flag: BOOLEAN) is
		do
			to_follow_x := flag
		end;

	follow_y (flag: BOOLEAN) is
		do
			to_follow_y := flag
		end;

end

--|----------------------------------------------------------------
--| EiffelBuild library.
--| Copyright (C) 1995 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------
