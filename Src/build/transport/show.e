
class SHOW 

inherit

	WINDOWS;
	PAINTER;
	COMMAND;

creation

	make
	
feature 

	make is
		do	
			set_drawing (eb_screen);
			set_logical_mode (10);
			set_subwindow_mode (1);
		end;
	
feature {NONE}

	is_original: BOOLEAN;

	showable: BOOLEAN;
	
feature 

	execute (argument: STONE) is
		local
			temp: WIDGET
		do
			if argument /= Void then
					-- Button press.
				showable := argument.transportable;
				if showable then
					is_original := (argument.original_stone = argument);
					if not is_original then
						temp := argument.original_stone.source;
						x0 := eb_screen.x;
						y0 := eb_screen.y;
						x1 := temp.real_x;
						y1 := temp.real_y;
						width := temp.width;
						height := temp.height;
						draw_segment (x1, y1, x1 + width, y1);
						draw_segment (x1, y1, x1, y1 + height);
						draw_segment (x1 + width, y1, x1 + width, y1 + height);
						draw_segment (x1, y1 + height, x1 + width, y1 + height);
						draw_segment (x0, y0, x1 + (width // 2), y1 + (height // 2));
					end;
				end;
			else
					-- Button release.
				if not is_original and showable then
					draw_segment (x1, y1, x1 + width, y1);
					draw_segment (x1, y1, x1, y1 + height);
					draw_segment (x1 + width, y1, x1 + width, y1 + height);
					draw_segment (x1, y1 + height, x1 + width, y1 + height);
					draw_segment (x0, y0, x1 + (width // 2), y1 + (height // 2));
				end;
			end;	
		end;

feature {NONE}

	x0, y0, x1, y1, width, height: INTEGER;

end
