
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

	make (a_name: STRING; a_parent: COMPOSITE; ed: CONTEXT_EDITOR) is
		do
			form_create (a_name, a_parent);
			load_colors (ed);
		end;

feature {NONE}

	number_by_line: INTEGER is 8;

	load_colors (ed: CONTEXT_EDITOR) is
		local
			eb_color: COLOR_STONE;
			position: INTEGER;
			file: PLAIN_TEXT_FILE;
			temp: FILE_NAME;
			top_widget, left_widget: COLOR_STONE;
		do
			temp := Environment.color_names_file;
			!! file.make (temp);
			if file.exists and then 
				file.is_readable and then
				not file.empty 
			then
				! DEFAULT_VALUE ! eb_color.make (Current, ed);
				attach_top (eb_color, 2);
				attach_left (eb_color, 2);
				position := position + 1;
				left_widget := eb_color;
				from
					file.open_read;
					file.readline;
				until
					file.end_of_file
				loop
					!!eb_color.make (file.laststring, Current, ed);
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
					file.readline;
				end;
				file.close;
			else
				io.error.putstring ("Warning: cannot read ");
				io.error.putstring (temp);
				io.error.new_line;
			end
		end;

end

