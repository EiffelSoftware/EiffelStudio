
class SHOW 

inherit

	WINDOWS;
	PAINTER
        undefine
            init_toolkit
        end
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

	showable: BOOLEAN;
	
feature 

	execute (argument: ANY) is
		local
			temp: WIDGET;
			ds: DRAG_SOURCE;
			context: CONTEXT
		do
			ds ?= argument;
			if ds /= Void then
				showable := False;
					-- Button press.
				context ?= ds.stone.data;
				if context /= Void then
					showable := True;
					temp := context.widget;
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
			else
					-- Button release.
				if showable then
					draw_segment (x1, y1, x1 + width, y1);
					draw_segment (x1, y1, x1, y1 + height);
					draw_segment (x1 + width, y1, x1 + width, y1 + height);
					draw_segment (x1, y1 + height, x1 + width, y1 + height);
					draw_segment (x0, y0, x1 + (width // 2), y1 + (height // 2));
					showable := False;
				end;
			end;	
		end;

feature {NONE}

	x0, y0, x1, y1, width, height: INTEGER;

end
