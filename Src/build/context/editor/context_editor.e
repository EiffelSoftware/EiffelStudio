
class CONTEXT_EDITOR 

inherit

	WIDGET_NAMES;
	EDITOR_NAMES;
	EDITOR_FORMS;
	TOP_SHELL
		rename
			make as shell_make,
			realize as shell_realize
		export
			{NONE} all;
			{ANY} hide, raise
		undefine
			init_toolkit
		end;
	TOP_SHELL
		undefine
			init_toolkit
		redefine
			realize, make
		select
			realize, make
		end;
	WINDOWS

creation

	make
	
feature {NONE}

	icon: CON_EDIT_STONE;
	
feature 

	edited_context: CONTEXT;
			-- Context edited in the context editor

	current_form: EDITOR_FORM;

	current_form_number: INTEGER;

	
feature {NONE}

	menu_button: OPTION_MENU;

	
feature 

	top_form: FORM;

	
feature {NONE}

	second_separator: SEPARATOR_G;

	
feature 

	form_list: ARRAY [EDITOR_FORM];

	
feature {ALIGNMENT_CMD}

	alignment_form: ALIGNMENT_FORM;

	
feature {NONE}

	behavior_form: BEHAVIOR_FORM;
	
feature 

	make (a_name: STRING; a_screen: SCREEN) is
		local
			first_separator: SEPARATOR_G;
			i: INTEGER;

			close_button: CLOSE_CONTEXT_EDITOR;

			geometry_form: GEOMETRY_FORM;
			label_text_form: LABEL_TEXT_FORM;
			perm_wind_form: PERM_WIND_FORM;
			temp_wind_form: TEMP_WIND_FORM;
--			form_position: FORM_POSITION;
			separator_form: SEPARATOR_FORM;
			text_form: TEXT_FORM;
			menu_form: MENU_FORM;
			bar_form: BAR_FORM;
			pict_color_form: PICT_COLOR_FORM;
			arrow_b_form: ARROW_B_FORM;
			scroll_l_form: SCROLL_L_FORM;
			font_form: FONT_FORM;
			scale_form: SCALE_FORM;
			pulldown_form: PULLDOWN_FORM;
			text_field_form: TEXT_FIELD_FORM;
			color_form: COLOR_FORM;
			drawing_box_form: DRAWING_BOX_FORM;
			bull_resize_form: BULL_RESIZE_FORM;
			grid_form: GRID_FORM;
			context_hole: CON_EDIT_HOLE
		do
			!!form_list.make (1, form_number);

			shell_make (a_name, a_screen);
			set_size (260, 480);
			!!top_form.make (F_orm, Current);

			!!context_hole.make (Current);
			context_hole.make_visible (top_form);
			!!first_separator.make (S_eparator, top_form);
			first_separator.set_single_line;
			first_separator.set_horizontal (True);
			!!icon;
			icon.make_visible (top_form);
			!!menu_button.make (G_eometry_form_name, Current);
			!!second_separator.make (S_eparator, top_form);
			second_separator.set_single_line;
			second_separator.set_horizontal (True);
			!!close_button.make (Current, Current);
			close_button.make_visible (top_form);

			top_form.set_fraction_base (20);

			top_form.attach_top (close_button, 10);

			top_form.attach_top (context_hole, 10);
			top_form.attach_top (icon, 10);

			top_form.attach_right (close_button, 10);
			top_form.attach_left (context_hole, 10);
			top_form.attach_left_widget (context_hole, icon, 10);

			top_form.attach_top (first_separator, 60);
			top_form.attach_left (first_separator, 10);
			top_form.attach_right (first_separator, 10);

			top_form.attach_top_widget (first_separator, menu_button.option_button, 5);
			top_form.attach_left (menu_button.option_button, 10);

			top_form.attach_top_widget (menu_button.option_button, second_separator, 5);
			top_form.attach_left (second_separator, 10);
			top_form.attach_right (second_separator, 10);

				-- *************************
				-- * Creation of the forms *
				-- *************************

			!!geometry_form.make (Current);
			!!label_text_form.make (Current);
			!!perm_wind_form.make (Current);
			!!temp_wind_form.make (Current);
			!!separator_form.make (Current);
--			form_position.Create (Current);
			!!text_form.make (Current);
			!!menu_form.make (Current);
			!!bar_form.make (Current);
			!!pict_color_form.make (Current);
			!!arrow_b_form.make (Current);
			!!scroll_l_form.make (Current);
			!!font_form.make (Current);
			!!alignment_form.make (Current);
			!!scale_form.make (Current);
			!!pulldown_form.make (Current);
			!!text_field_form.make (Current);
			!!color_form.make (Current);
			!!drawing_box_form.make (Current);
			!!behavior_form.make (Current);
			!!bull_resize_form.make (Current);
			!!grid_form.make (Current);
		end;

	realize is
		do
			shell_realize;
			menu_button.option_button.hide;
			if icon.original_stone = Void then
				icon.hide
			end
		end;

	attach_attributes_form (a_form: EDITOR_FORM) is
		do
			top_form.attach_top_widget (second_separator, a_form, 1);
			top_form.attach_left (a_form, 1);
			top_form.attach_right (a_form, 1);
			top_form.attach_bottom (a_form, 1);
		end;

	set_edited_context (new_context: CONTEXT) is
			-- Set `edited_context' to `new_context'
		local
			option_list: ARRAY [INTEGER];
			list: LINKED_LIST [INTEGER];
			current_form_found: BOOLEAN;
			context_form_found: BOOLEAN;
			i: INTEGER;
		do
			if new_context /= edited_context then
				edited_context := new_context;
				icon.set_context (edited_context);
				option_list := edited_context.option_list;
				menu_button.option_button.set_managed (False);
				menu_button.update (option_list);
				if edited_context.is_bulletin then
					menu_button.add_button (alignment_form_number);
					menu_button.add_button (grid_form_number);
				end;
				if not (edited_context.resize_policy = Void) then
					menu_button.add_button (bulletin_resize_form_number);
				end;
				menu_button.add_button (color_form_number);
				if edited_context.is_fontable then
					menu_button.add_button (font_form_number);
				end;
				menu_button.add_button (behavior_form_number);
				if edited_context.editor_form = 0 then
					edited_context.set_editor_form (option_list.item (1));
				end;
					-- Test if the current form is defined for the context
					-- ie is not a special form not valid for the new context
				from
					i := 1
				until
					i > option_list.count or 
					(option_list.item (i) = -1) or
					current_form_found
					loop
					if option_list.item (i) = edited_context.editor_form then	
						context_form_found := True;
					end;
						if option_list.item (i) = current_form_number then	
						current_form_found := True;
					end;
						i := i + 1;
				end;
				list := menu_button.additionnal_list;
				from
					list.start
				until
					list.offright or current_form_found
				loop
					if list.item = edited_context.editor_form then	
						context_form_found := True;
					end;
					if list.item = current_form_number then	
						current_form_found := True;
					end;
					list.forth
				end;
				if current_form_found then
					edited_context.set_editor_form (current_form_number)
				elseif not context_form_found then
					edited_context.set_editor_form (edited_context.option_list.item (1))
					end;
				menu_button.option_button.set_managed (True);
				set_form (edited_context.editor_form);
			end;
		end;
	
	update_form (a_form_number: INTEGER) is\
			-- Update the form according to `a_form_number'.
		local
			other_editor: like Current
		do
			other_editor :=	context_catalog.editor (edited_context, a_form_number);
			if other_editor = Void then
				set_form (a_form_number)
			else
				menu_button.set_previous_selected_button;	
				other_editor.raise
			end
		end;

	set_form (a_form_number: INTEGER) is
			-- Display 'a_form' in the context editor window
		local
			new_form: EDITOR_FORM;
			mp: MOUSE_PTR;
			msg: STRING;
		do
			current_form_number := a_form_number;
			edited_context.set_editor_form (a_form_number);
			menu_button.option_button.set_managed (False);
			menu_button.set_form (edited_context.editor_form);
			new_form := form_list.item (edited_context.editor_form);
			if not new_form.is_initialized then
				!!mp;
				mp.set_watch_shape;
				top_form.set_managed (False);
				new_form.make_visible (Current);
				top_form.set_managed (True);
				mp.restore
			end;
			if not (current_form = Void) then
				current_form.hide;
			end;
			current_form := new_form;
			current_form.reset_form;
			current_form.show;
			menu_button.option_button.show;
			menu_button.option_button.set_managed (True);
		end;

	behavior_form_shown: BOOLEAN is
			-- Is current_form a behavior_form?
		do
			Result := (current_form_number = behavior_form_number)
		end

feature -- Reseting

	close is
			-- Close current editor
		do
			clear;
			window_mgr.close (Current)
		end;

	reset_behavior_editor is
		do
			if	 
				(not (behavior_form = Void)) and then
				behavior_form.is_initialized 
			then
				behavior_form.reset_editor
			end;
		end;

	clear is
			-- Reset the hole of the context editor
		do
			if not (current_form = Void) then
				reset_behavior_editor;
				edited_context.set_editor_form (current_form_number);
				edited_context := Void;
				menu_button.option_button.hide;
				current_form.hide;
				current_form := Void;
				current_form_number := 0;
				icon.reset;
			end;
		end;

	update_icon_name is
		do
			icon.update_name
		end;



end
