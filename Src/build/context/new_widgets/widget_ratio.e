
class WIDGET_RATIO 

inherit

	BASIC_ROUTINES
		export
			{NONE} all
		end


creation

	make

	
feature 

	make (a_widget: WIDGET) is
		do
			widget := a_widget;
			is_x_fixed := True;
			is_y_fixed := True;
		end;

	set_ratios (parent_width, parent_height ,x, y, w, h: INTEGER) is
		local
			width, height: REAL;
		do
			width := integer_to_real (parent_width);
			height := integer_to_real (parent_height);
			x_ratio := integer_to_real (x)/ width;
			y_ratio := integer_to_real (y)/ height;
			width_ratio := integer_to_real (w)/ width;
			height_ratio := integer_to_real (h)/ height;
			initialized := True;
		end;

	initialized: BOOLEAN;

	
feature {NONE}

	is_width_resizeable: BOOLEAN;
	is_height_resizeable: BOOLEAN;
	is_x_fixed: BOOLEAN;
	is_y_fixed: BOOLEAN;

	
feature 

	useless: BOOLEAN is
			-- The widget ratio is useless in the list,
			-- i.e. the widget geometry will not be
			-- modified if the size of the parent is modified
		do
			Result := is_x_fixed and is_y_fixed and
				not is_width_resizeable and
				not is_height_resizeable
		end;

	update_widget (parent_width, parent_height: INTEGER) is
		do
			if widget.managed then
				widget.set_managed (False);
				if is_width_resizeable then
					widget.set_width (real_to_integer (parent_width * width_ratio));
				end;
				if is_height_resizeable then
					widget.set_height (real_to_integer (parent_height * height_ratio));
				end;
				if not is_x_fixed then
					widget.set_x (real_to_integer (parent_width * x_ratio));
				end;
				if not is_y_fixed then
					widget.set_y (real_to_integer (parent_height * y_ratio));
				end;
				widget.set_managed (True);
			end;
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
			is_x_fixed := not flag
		end;

	follow_y (flag: BOOLEAN) is
		do
			is_y_fixed := not flag
		end;

	widget: WIDGET;

	
feature {NONE}

	x_ratio: REAL;

	y_ratio: REAL;

	width_ratio: REAL;

	height_ratio: REAL;

end

