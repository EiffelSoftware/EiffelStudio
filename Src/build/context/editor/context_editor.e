class CONTEXT_EDITOR 

inherit

	TOP_SHELL
		rename
			make as shell_make,
			realize as shell_realize,
			show as shell_show,
			hide as shell_hide
		redefine
			delete_window_action
		end
	TOP_SHELL
		export
			{NONE} all
			{ANY} hide, raise
		redefine
			realize, make, show, hide, 
			delete_window_action
		select
			realize, make, show, hide
		end
	WINDOWS
	CONSTANTS

creation

	make
	
feature {NONE}


	context_hole: CON_EDIT_HOLE
	
feature 

	-- Context edited in the context editor
	edited_context: CONTEXT
	current_form: EDITOR_FORM
	current_form_number: INTEGER

	
feature 
	delete_window_action is
		do
			close
		end

	top_form: FORM

	
feature {NONE}

	first_separator: SEPARATOR_G
	second_separator: SEPARATOR_G
	
feature 

	form_list: ARRAY [EDITOR_FORM]

feature {ALIGNMENT_CMD}

	alignment_form: ALIGNMENT_FORM

	
feature {NONE}

	behavior_form: BEHAVIOR_FORM
	
	formats_rc: ROW_COLUMN

feature 

	format_list: FORMAT_LIST;

	focus_label: FOCUS_LABEL;

	make (a_name: STRING a_screen: SCREEN) is
		local
			i: INTEGER
			close_button: CLOSE_CONTEXT_EDITOR
			geometry_form: GEOMETRY_FORM
			label_text_form: LABEL_TEXT_FORM
			perm_wind_form: PERM_WIND_FORM
			temp_wind_form: TEMP_WIND_FORM
			separator_form: SEPARATOR_FORM
			text_form: TEXT_FORM
			menu_form: MENU_FORM
			bar_form: BAR_FORM
			pict_color_form: PICT_COLOR_FORM
			arrow_b_form: ARROW_B_FORM
			scroll_l_form: SCROLL_L_FORM
			font_form: FONT_FORM
			scale_form: SCALE_FORM
			pulldown_form: PULLDOWN_FORM
			text_field_form: TEXT_FIELD_FORM
			color_form: COLOR_FORM
			drawing_box_form: DRAWING_BOX_FORM
			bull_resize_form: BULL_RESIZE_FORM
			grid_form: GRID_FORM
		do
			!!form_list.make (1, Context_const.total_nbr_of_forms);

			shell_make (a_name, a_screen)
			!!top_form.make (Widget_names.form, Current)

			!!context_hole.make (Current)
			context_hole.make_visible (top_form)
			!!first_separator.make (Widget_names.separator, top_form)
			first_separator.set_horizontal (True)
			!!second_separator.make (Widget_names.separator1, top_form)
			second_separator.set_horizontal (True)
			!!close_button.make (Current, Current)
			!!formats_rc.make (Widget_names.row_column, top_form) 
			formats_rc.set_row_layout
			formats_rc.set_preferred_count (1)
			formats_rc.set_spacing (5)
			!! focus_label.make (top_form);

			top_form.set_fraction_base (20)
			top_form.attach_top (focus_label, 10)
			top_form.attach_top (close_button, 10)
			top_form.attach_top (context_hole, 10)
			top_form.attach_right (close_button, 10)
			top_form.attach_left (context_hole, 10)
			top_form.attach_top_widget (focus_label, first_separator, 10)

			top_form.attach_top (first_separator, 60)
			top_form.attach_left (first_separator, 0)
			top_form.attach_right (first_separator, 0)
			top_form.attach_bottom (formats_rc, 1)
			top_form.attach_left (formats_rc, 1)
			top_form.attach_right (formats_rc, 1)
			top_form.attach_bottom_widget (formats_rc, second_separator, 1)

			top_form.attach_left (second_separator, 0)
			top_form.attach_right (second_separator, 0)

				-- *************************
				-- * Creation of the forms *
				-- *************************

			!!geometry_form.make (Current)
			!!label_text_form.make (Current)
			!!perm_wind_form.make (Current)
			!!temp_wind_form.make (Current)
			!!separator_form.make (Current)
			!!text_form.make (Current)
			!!menu_form.make (Current)
			!!bar_form.make (Current)
			!!pict_color_form.make (Current)
			!!arrow_b_form.make (Current)
			!!scroll_l_form.make (Current)
			!!font_form.make (Current)
			!!alignment_form.make (Current)
			!!scale_form.make (Current)
			!!pulldown_form.make (Current)
			!!text_field_form.make (Current)
			!!color_form.make (Current)
			!!drawing_box_form.make (Current)
			!!behavior_form.make (Current)
			!!bull_resize_form.make (Current)
			!!grid_form.make (Current)

			!! format_list.make (formats_rc, Current)

			current_form_number := 1;
		end

	realize is
		do
			shell_realize
		end;

	show is
		do
			shell_show
		end;

	hide is
		do
			shell_hide
		end;

	attach_attributes_form (a_form: EDITOR_FORM) is
		do
			top_form.attach_top_widget (first_separator, a_form, 1)
			top_form.attach_left (a_form, 1)
			top_form.attach_right (a_form, 1)
			top_form.attach_bottom_widget (second_separator, a_form, 1)
		end

	set_edited_context (new_context: CONTEXT) is
			-- Set `edited_context' to `new_context'
		local
			option_list: ARRAY [INTEGER];
			count, i: INTEGER;
			other_editor: like Current;
		do
				-- See if editor exists for current_form_number
			other_editor := context_catalog.editor 
				(new_context, current_form_number)
			if other_editor = Void then
				if new_context /= edited_context then
					option_list := new_context.option_list

						-- Test if the current form is defined for the context
					from
						i := 1;
						count := option_list.count;
					until
						i > count or else
						option_list @ i = current_form_number
					loop
						i := i + 1
					end
					if i > count then
							-- Could not find. Check to see if the first
							-- form number is being used
						other_editor :=	context_catalog.editor (new_context, 
											option_list @ 1)
						if other_editor = Void then
							if edited_context = Void or else
								not edited_context.eiffel_type.is_equal 
									(new_context.eiffel_type)
							then
								formats_rc.unmanage;
								format_list.update_buttons (option_list);
								formats_rc.manage;
							end;
							edited_context := new_context;
							context_hole.set_context (edited_context);
							set_form (option_list @ 1)
						else
							other_editor.raise
						end
					else
						if edited_context = Void or else
							not edited_context.eiffel_type.is_equal 
								(new_context.eiffel_type)
						then
							formats_rc.unmanage;
							format_list.update_buttons (option_list);
							formats_rc.manage;
						end;	
						edited_context := new_context;
						context_hole.set_context (edited_context);
						format_list.update_buttons (option_list);
						set_form (current_form_number)
					end
				end
			else
				other_editor.raise
			end
		end;
	
	set_form (a_form_number: INTEGER) is
			-- Display 'a_form' in the context editor window
		local
			new_form: EDITOR_FORM
			mp: MOUSE_PTR
			msg: STRING
		do
			current_form_number := a_form_number;
			new_form := form_list @ (current_form_number);
			if not new_form.is_initialized then
				if current_form /= void then
					current_form.hide
				end;
				!!mp;
				mp.set_watch_shape;
				new_form.make_visible (top_form);
				mp.restore
			elseif current_form /= Void and then
				current_form /= new_form
			then
				current_form.hide;
			end;
			if not new_form.shown then
				new_form.show
			end;
			current_form := new_form;
			current_form.reset;
		end

	behavior_form_shown: BOOLEAN is
			-- Is current_form a behavior_form?
		do
			Result := (current_form_number = Context_const.behavior_form_nbr)
		end

feature {FORMAT_BUTTON}

	update_form (form_nbr: INTEGER) is
			-- Update current form number to	
			-- `form_nbr' and display the 
			-- corresponding form page if
			-- necessary
		local
			other_editor: like Current	
		do
			if edited_context /= Void and then
				form_nbr /= current_form_number 
			then
				other_editor := context_catalog.editor 
					(edited_context, form_nbr)
				if other_editor = Void then
					set_form (form_nbr)
				else
					other_editor.raise
				end
			end
		end;

feature -- Reseting

	close is
			-- Close current editor
		do
			clear
			window_mgr.close (Current)
		end

	reset_behavior_editor is
		do
			if behavior_form /= Void and then
				behavior_form.is_initialized 
			then
				behavior_form.reset_editor
			end
		end

	clear is
			-- Reset the hole of the context editor
		do
			if current_form /= Void then
				reset_behavior_editor
				edited_context := Void
				current_form.hide
				current_form := Void
				current_form_number := 1
				context_hole.reset
			end
		end

	update_icon_name is
		do
			context_hole.update_name
		end
end
