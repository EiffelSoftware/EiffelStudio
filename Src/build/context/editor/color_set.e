
class COLOR_SET 

inherit

	CONSTANTS;
	FORM
		rename
			make as form_create
		end

creation

	make

feature 

	make (a_name: STRING; a_parent: COMPOSITE) is
		do
			form_create (a_name, a_parent);
			load_colors;
		end;

feature {NONE}

	number_by_line: INTEGER is 8;

	load_colors is
		local
			eb_color: COLOR_STONE;
			position: INTEGER;
			color_name_file: PLAIN_TEXT_FILE;
			file: PLAIN_TEXT_FILE;
			temp: STRING;
			top_widget, left_widget: COLOR_STONE;
		do
			temp := Environment.color_names_file;
			!! file.make (temp);
			if file.exists and file.is_readable then
				from
					!!color_name_file.make_open_read (temp);
					color_name_file.readline;
				until
					color_name_file.end_of_file
				loop
					!!eb_color.make (color_name_file.laststring, Current);
					if (top_widget = Void) then
						attach_top (eb_color, 2);
					else
						attach_top_widget (top_widget, eb_color, 0);
					end;
					if (left_widget = Void) then
						attach_left (eb_color, 2);
					else
						attach_left_widget (left_widget, eb_color, 0);
					end;
					position := position + 1;
					if position = number_by_line then
						top_widget := eb_color;
						left_widget := Void;
						position := 0;
					else
						left_widget := eb_color;
					end;
					color_name_file.readline;
				end;
				color_name_file.close;
			else
				io.error.putstring ("Warning: can not read ");
				io.error.putstring (temp);
				io.error.new_line;
			end
		end;

end

