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

	CONSTANTS;
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
			valid_argument: s /= Void;
		local
			was_managed: BOOLEAN;
		do
			symbol := s;
			if s.is_valid and then widget_created then
				button.unmanage;
				button.set_pixmap (s);
				button.manage;
			end;
		end;

	set_label (s: STRING) is
			-- Set icon label.
		require
			not_void: s /= Void;
		local
			was_managed: BOOLEAN;
		do
			label := clone (s);
			if widget_created then
				icon_label.unmanage;
				icon_label.set_y (init_y);
				icon_label.set_text (label);
				icon_label.manage;
			end;
		end;

feature {NONE} -- Interface section

	button: PICT_COLOR_B;
	icon_label: LABEL_G;
	
	widget_created: BOOLEAN is
		do
			Result := button /= Void
		end;
	
	update_label is
		do
			if label.empty then
				icon_label.unmanage;
			else
				icon_label.manage;
			end;
		end;

feature  -- Interface section

	make_visible (a_parent: COMPOSITE) is
			-- EiffelVision widget creation.
		do
			if not widget_created then
				make_unmanaged (Widget_names.bulletin, a_parent);
				!! button.make_unmanaged (Widget_names.pcbutton, Current);
				button.set_x_y (1, 1);
				if 
					symbol /= Void and
					symbol.is_valid
				then 
					button.set_pixmap (symbol)
				end;
				!!icon_label.make_unmanaged (Widget_names.label, Current);
				icon_label.set_left_alignment;
				icon_label.allow_recompute_size;
				if (label /= Void) and then not label.empty then
					icon_label.set_y (init_y);
					icon_label.set_text (label);
				else
					icon_label.set_text ("");
				end;
			end;
			set_managed (True)
		end;

	add_activate_action (a_command: COMMAND; an_argument: ANY) is
		do
			button.add_activate_action (a_command, an_argument)
		end;

	add_button_press_action (i: INTEGER; a_command: COMMAND; an_argument: ANY) is
		do
			button.add_button_press_action (i, a_command, an_argument)
		end;

	set_managed (b: BOOLEAN) is
		do
			if b then 
				manage;
				if widget_created then
					if not icon_label.text.empty then
						icon_label.manage;
					end;
					button.manage;
				end;
			elseif widget_created then
				unmanage;
				if button.managed then
					button.unmanage;
				end;
				if icon_label.managed then
					icon_label.unmanage;
				end;
			end;
		end;

end
