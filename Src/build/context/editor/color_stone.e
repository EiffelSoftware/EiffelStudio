
class COLOR_STONE 

inherit

	DATA
		rename
			label as color_name
		end;
	PICT_COLOR_B
		rename 
			make as pict_color_make
		end;
	STONE;
	DRAG_SOURCE

creation

	make
	
feature 

	color_name: STRING;

	stone_type: INTEGER is
		do
			Result := Stone_types.color_type
		end;

	help_file_name: STRING is
		do
			Result := Help_const.color_help_fn
		end;

	process (hole: HOLE) is
		do
			hole.process_color (Current)
		end;

	source: PICT_COLOR_B is
		do
			Result := Current
		end;

	data: like Current is
		do
			Result := Current
		end;

	symbol: PIXMAP is 
		do
		end;

	stone_cursor: SCREEN_CURSOR is 
		do 
			Result := Cursors.color_cursor
		end;

	make (a_color_name: STRING; a_parent: COMPOSITE) is
		require
			valid_args: a_color_name /= Void and 
						(a_parent /= Void)
		local
			a_color: COLOR;
		do
			color_name := clone (a_color_name);
			!!a_color.make;
			a_color.set_name (color_name);
			pict_color_make (color_name, a_parent);
			set_size (20, 20);
			set_background_color (a_color);
			initialize_transport;
		end;

end
