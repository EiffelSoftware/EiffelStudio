--=========================== class XXXXXXXX ========================
--
-- Author: Deramat
-- Last revision: 03/30/92
--
-- Icon: Picture symbol and text label.
--
--===================================================================

class ICON 

inherit

	BULLETIN
		rename
			make as bulletin_create
		redefine
			set_managed,
			add_button_press_action
		end;

feature 

	init_y: INTEGER is 29;	

	source_button: PICT_COLOR_B is
		do
			Result := button
		end;

	symbol: PIXMAP;
			-- Icon picture

	label: STRING;
			-- Icon label

	set_symbol (s: PIXMAP) is
			-- Set icon symbol.
		require
			valid_argument: s /= Void
		do
			symbol := s;
			if widget_created and s.is_valid then
				button.unmanage;
				button.set_pixmap (s);
				button.manage
			end;
		end;

	set_label (s: STRING) is
			-- Set icon label.
		do
			label := s;
			if widget_created and not (s = Void) then
				icon_label.unmanage;
				icon_label.set_text (s);
				if not s.empty then
					icon_label.manage;
					icon_label.set_y (init_y)
				end;
			end;
		end;

	
feature {NONE}

	icon_name: STRING is
		do
			Result := "Icon"
		end;

	widget_created: BOOLEAN is
		do
			Result := not (button = Void)
		end;
	
feature 

	add_activate_action (a_command: COMMAND; an_argument: ANY) is
		do
			button.add_activate_action (a_command, an_argument)
		end;

	add_button_press_action (i: INTEGER; a_command: COMMAND; an_argument: ANY) is
		do
			button.add_button_press_action (i, a_command, an_argument)
		end;

--*********************
-- EiffelVision Section
--*********************

feature {NONE}

	button: PICT_COLOR_B;
	icon_label: LABEL_G;
	
feature 

	make_visible (a_parent: COMPOSITE) is
			-- EiffelVision widget creation.
		do
			if not widget_created then
					-- **************
					-- Create widgets
					-- **************
	
				bulletin_create ("FOO", a_parent);
				set_managed (False);
				!!button.make ("adf", Current);
				button.unmanage;
				button.set_x_y (1, 1);
				if 
					symbol /= Void and
					symbol.is_valid
				then 
					button.set_pixmap (symbol)
				end;
				!!icon_label.make ("label", Current);
				icon_label.set_left_alignment;
				icon_label.allow_recompute_size;
				icon_label.unmanage;
				if not (label = Void) then
					icon_label.set_y (init_y);
					icon_label.set_text (label);
				end;
	
					-- *******************
					-- Perform attachments
					-- *******************
	
				if (label = Void) or else label.empty then
					icon_label.unmanage;
				else
					icon_label.manage;
				end;
				button.manage;
			end;
			set_managed (True)
		end;

	
feature {NONE}

	update_label is
		do
			if label.empty then
				icon_label.unmanage;
			else
				icon_label.manage;
			end;
		end;

	select_icon is
		local
			temp: STRING;
			temp1: ANY
		do
			temp := "borderWidth";
			temp := temp.duplicate;
			temp1 := temp.to_c;
			selected := True;
			if widget_created then
				unmanage;
				set_dimension (implementation.screen_object, 1, $temp1);
				manage;
			end;
		end;

	
feature 

	deselect is
		local
			temp: STRING;
			temp1: ANY
		do
			temp := "borderWidth";
			temp := temp.duplicate;
			selected := False;	
			if widget_created then
				temp1 := temp.to_c;
				unmanage;
				set_dimension (implementation.screen_object, 0,$temp1);
				manage;
			end
		end;

feature {NONE}

	selected: BOOLEAN;

feature 

	set_managed (b: BOOLEAN) is
		local
			ext_name: POINTER;
			temp: STRING;
			temp1: ANY
		do
			temp := "borderWidth";
			temp := temp.duplicate;
			temp1 := temp.to_c;
			if selected and b then
				set_dimension (implementation.screen_object, 1, $temp1)
			elseif b then
				set_dimension (implementation.screen_object, 0, $temp1)
			end;
			if b then 
				manage
			else
				unmanage
			end
		end;

feature {NONE} -- External features

	set_dimension (scr_obj: POINTER; val: INTEGER; resource: ANY) is
		external
			"C"
		end; 

end
