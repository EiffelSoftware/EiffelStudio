
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
	FOCUSABLE;
	STONE;
	DRAG_SOURCE

creation

	make
	
feature 

	color_name: STRING;

	editor: CONTEXT_EDITOR;

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

	make (a_color_name: STRING; a_parent: COMPOSITE; ed: CONTEXT_EDITOR) is
		require
			valid_args: a_color_name /= Void and 
				    (a_parent /= Void) and then ed /= Void
		local
			a_color: COLOR;
		do

			editor := ed;
			color_name := clone (a_color_name);
			-- added by samik
			set_focus_string (color_name)
			-- end of samik
			!!a_color.make;
			a_color.set_name (color_name);
			pict_color_make (color_name, a_parent);
			set_size (20, 20);
			set_background_color (a_color);
			initialize_transport;
			initialize_focus;
	--		reset_commands
		end;

	focus_label: FOCUS_LABEL_I is
			-- has to be redefined, so that it returns correct toolkit initializer
			-- to which object belongs for every instance of this class
                local
                        ti: TOOLTIP_INITIALIZER
                do
                        ti ?= top
                        check
                                valid_tooltip_initializer: ti/= void
                        end
                        Result := ti.label
                end

-- samik	focus_label: FOCUS_LABEL is
-- samik		do
-- samik			Result := editor.focus_label
-- samik		end;

-- samik	focus_string: STRING is
-- samik		do
-- samik			Result := color_name
-- samik		end;

	focus_source: WIDGET is
		do
			Result := Current
		end;


end
