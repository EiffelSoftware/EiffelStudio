
class SCROLL_PAGE 

inherit

	CONTEXT_CAT_PAGE;
	COMMAND;

creation

	make

feature 

	text_type: CONTEXT_TYPE;
	drawing_area_type: CONTEXT_TYPE;
	scroll_list_type: CONTEXT_TYPE;
	drawing_area: DRAWING_BOX;

feature {NONE}

	create_figures is
			-- Create the figures associated with the drawing area
		local
			rectangle: RECTANGLE;
			circle: CIRCLE;
			interior: INTERIOR;
			path: PATH;
			rect_coord: COORD_XY_FIG;
			circle_coord: COORD_XY_FIG;
		do
			!!rect_coord;
			!!rectangle.make;
			rectangle.set_upper_left (rect_coord);
			!!circle_coord;
			!!circle.make;
			circle.set_center (circle_coord);

			!!interior.make;
			interior.set_foreground_color (Resources.background_figure_color);
			!!path.make;
			path.set_foreground_color (Resources.foreground_figure_color);
			path.set_line_width(2);

			rectangle.set_path (path);
			rectangle.set_interior (interior);
			circle.set_path (path);
			circle.set_interior (interior);

			rectangle.attach_drawing (drawing_area);
			circle.attach_drawing (drawing_area);

			drawing_area.add_figure (rectangle);
			drawing_area.add_figure (circle);

			rect_coord.set (2, 2);
			rectangle.set_width (55);
			rectangle.set_height (55);
			circle_coord.set (40, 35);
			circle.set_radius (10);
		end;

	build_interface is
		local
			text_c: TEXT_C;
			drawing_area_c: DR_AREA_C;
			scroll_list_c: SCROLL_LIST_C;

			text: SCROLLED_T;
			scroll_list: SCROLL_LIST;

			text_item: STRING;
			i: INTEGER;
		do
			set_fraction_base (2);
			!!text_c;
			!!text.make (text_c.eiffel_type, Current);
			text.set_size (80, 80);
			!!text_type.make (Widget_names.text_name, text_c);
			text_type.initialize_callbacks (text);

			!!scroll_list_c;
			!!scroll_list.make (scroll_list_c.eiffel_type, Current);
			scroll_list.set_visible_item_count (3);
			from
				i := 1;
			until
				i > 5
			loop
				!!text_item.make (0);
				text_item.append (Widget_names.item_name);
				text_item.append_integer (i);
				scroll_list.put_right (text_item);
				scroll_list.forth;
				i := i + 1
			end;
			scroll_list.set_size (80, 80);
			!!scroll_list_type.make (Widget_names.scroll_list_name, scroll_list_c);
			scroll_list_type.initialize_callbacks (scroll_list);

			!!drawing_area_c;
			!!drawing_area.make (drawing_area_c.eiffel_type, Current);
			drawing_area.add_expose_action (Current, Void); 
			drawing_area.set_drawing_area_size (80, 80);
			drawing_area.set_size (80, 80);
			create_figures;
			!!drawing_area_type.make (Widget_names.drawing_area_name, 
					drawing_area_c);
			drawing_area_type.initialize_callbacks (drawing_area);

			-- ***************
			-- * Attachments *
			-- ***************

			attach_left (text, 1);
			attach_left_widget (text, scroll_list, 10);
			--attach_right (scroll_list, 1);

			attach_left (drawing_area.scrolled_window, 1);

			attach_top (text, 1);
			attach_top (scroll_list, 1);
			attach_top_widget (text, drawing_area.scrolled_window, 10);
		
            button.set_focus_string (Focus_labels.scroll_label)
    	end;

	execute (argument: ANY) is
		do
			drawing_area.world.draw
		end;

	symbol: PIXMAP is
		do
			Result := Pixmaps.scrolled_w_pixmap
		end;

	selected_symbol: PIXMAP is
		do
			Result := Pixmaps.selected_scrolled_w_pixmap
		end;


end
