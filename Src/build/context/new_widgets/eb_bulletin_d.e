
class EB_BULLETIN_D 

inherit

	BULLETIN_D
		rename
			make as bulletin_d_create,
			set_width as old_set_width,
			set_height as old_set_height,
			set_size as old_set_size
		end;

	BULLETIN_D
		rename
			make as bulletin_d_create
		redefine
			set_size, set_height, set_width
		select
			set_size, set_height, set_width
		end;

	COMMAND
		export
			{NONE} all
		end;

	SCALABLE;


creation

	make

	
feature 

	make (a_name: STRING; a_parent: COMPOSITE) is
		local
			temp: STRING;
			temp1: ANY		
		do
			bulletin_d_create (a_name, a_parent);
			!!widget_coordinates.make;
			temp := "resizePolicy";
			temp1 := temp.to_c;
			eb_bulletin_set_int (implementation.screen_object, 0, $temp1);

				-- Callback
			set_action ("<Configure>", Current, Current);
		end;

	update_ratios (a_widget: WIDGET) is
		do
			search_widget (a_widget);
			widget_coordinates.item.set_ratios (old_width, old_height,
			a_widget.x, a_widget.y,
			a_widget.width, a_widget.height);
		end;

	width_resizeable (a_widget: WIDGET; flag: BOOLEAN) is
		require else
			valid_widget: a_widget.parent = Current
		do
			search_widget (a_widget);
			widget_coordinates.item.width_resizeable (flag);
			clean_list
		end;

	height_resizeable (a_widget: WIDGET; flag: BOOLEAN) is
		require else
			valid_widget: a_widget.parent = Current
		do
			search_widget (a_widget);
			widget_coordinates.item.height_resizeable (flag);
			clean_list
		end;

	follow_x (a_widget: WIDGET; flag: BOOLEAN) is
		require else
			valid_widget: a_widget.parent = Current
		do
			search_widget (a_widget);
			widget_coordinates.item.follow_x (flag);
			clean_list
		end;

	follow_y (a_widget: WIDGET; flag: BOOLEAN) is
		require else
			valid_widget: a_widget.parent = Current
		do
			search_widget (a_widget);
			widget_coordinates.item.follow_y (flag);
			clean_list
		end;

	
feature {PERM_WIND_C} -- only exported for ebuild. Not needed for generated application

	clean_list is
		do
			if widget_coordinates.item.useless then
				widget_coordinates.remove;
			end;
		end;

	search_widget (a_widget: WIDGET) is
		local
			widget_ratio: WIDGET_RATIO
		do
			old_width := width;
			old_height := height;
			from
				widget_coordinates.start
			until
				widget_coordinates.after or else widget_coordinates.item.widget = a_widget
			loop
				widget_coordinates.forth
			end;
			if widget_coordinates.after then
				!!widget_ratio.make (a_widget);
				widget_coordinates.put_left (widget_ratio);
				widget_coordinates.back;
			end;
			if not widget_coordinates.item.initialized and then
				(old_width /= 0 and old_height /= 0) then
					widget_coordinates.item.set_ratios (old_width, old_height,
									a_widget.x, a_widget.y,
									a_widget.width, a_widget.height);
			end;
		end;

	old_width, old_height: INTEGER;

	execute (argument: ANY) is
		do
			if argument = Current then
				if old_width /= width or old_height /= height then
					if (old_width /= 0 and old_height /= 0) then
						from
							widget_coordinates.start
						until
							widget_coordinates.after
						loop
							widget_coordinates.item.update_widget (width, height);
							widget_coordinates.forth
						end;
					end;
					old_width := width;
					old_height := height;
				end;
			end;
		end;

	widget_coordinates: LINKED_LIST [WIDGET_RATIO];

	
feature 

	set_width (new_width: INTEGER) is
		do	
			old_set_width (new_width);
			if old_width = 0 then
				old_width := width
			end;
		end;

	set_height (new_height: INTEGER) is
		do	
			old_set_height (new_height);
			if old_height = 0 then
				old_height := height
			end;
		end;

	set_size (new_width, new_height: INTEGER) is
		do	
			old_set_size (new_width, new_height);
			if old_width = 0 then
				old_width := width
			end;
			if old_height = 0 then
				old_height := height
			end;
		end;

feature {NONE} -- External features

	eb_bulletin_set_int (a_w: POINTER; a_val: INTEGER; a_res: POINTER)  is
		external
			"C"
		alias
			"set_int"
		end; -- eb_bulletin_set_int

end

