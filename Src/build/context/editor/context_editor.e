class CONTEXT_EDITOR 

inherit

	EB_TOP_SHELL
		rename
			make as shell_make,
			destroy as shell_destroy
		redefine
			set_geometry
		end
	EB_TOP_SHELL
		redefine
			make, destroy, set_geometry
		select
			make, destroy
		end
	WINDOWS
		select
			init_toolkit
		end
	CLOSEABLE

creation

	make

feature -- Geometry

	set_geometry is
		do
			set_size (Resources.cont_ed_width,
					Resources.cont_ed_height)
		end;

feature {NONE}

	context_hole: CON_EDIT_HOLE
	
feature 

	-- Context edited in the context editor
	edited_context: CONTEXT

	current_form_number: INTEGER
	
	top_form: FORM
	
feature {NONE}

	first_separator: SEPARATOR
	second_separator: SEPARATOR
	
feature 

	form_list: ARRAY [EDITOR_FORM]

feature {ALIGNMENT_CMD}

	alignment_form: ALIGNMENT_FORM

	
feature {NONE}

	behavior_form: BEHAVIOR_FORM
	
	formats_rc: ROW_COLUMN

	trash_hole: CUT_HOLE

feature 

	color_form: COLOR_FORM

	format_list: FORMAT_LIST;

    --samik	focus_label: FOCUS_LABEL;

	make (a_name: STRING a_screen: SCREEN) is
		local
			i: INTEGER
			close_button: CLOSE_WINDOW_BUTTON
			geometry_form: GEOMETRY_FORM
			label_text_form: LABEL_TEXT_FORM
			perm_wind_form: PERM_WIND_FORM
			temp_wind_form: TEMP_WIND_FORM
			separator_form: SEPARATOR_FORM
			text_form: TEXT_FORM
			toggle_form: TOGGLE_FORM
			menu_form: MENU_FORM
			bar_form: BAR_FORM
			pict_color_form: PICT_COLOR_FORM
			arrow_b_form: ARROW_B_FORM
			scroll_l_form: SCROLL_L_FORM
			font_form: FONT_FORM
			scale_form: SCALE_FORM
			pulldown_form: PULLDOWN_FORM
			text_field_form: TEXT_FIELD_FORM
			drawing_box_form: DRAWING_BOX_FORM
			bull_resize_form: BULL_RESIZE_FORM
			grid_form: GRID_FORM
			del_com: DELETE_WINDOW
			focus_area_form: FORM
		do
			!!form_list.make (1, Context_const.total_nbr_of_forms);

			shell_make (a_name, a_screen);
			set_title (Widget_names.context_editor);
			set_icon_name (Widget_names.context_editor);
			if Pixmaps.context_pixmap.is_valid then
				set_icon_pixmap (Pixmaps.context_pixmap);
			end;
			!!top_form.make (Widget_names.form, Current)
			!!focus_area_form.make (Widget_names.form1, top_form);

			!! context_hole.make (Current, focus_area_form);
--samik			!! focus_label.initialize (focus_area_form);
			!! trash_hole.make (focus_area_form);
			!! close_button.make (Current, focus_area_form)
			!! first_separator.make (Widget_names.separator, top_form)
			first_separator.set_horizontal (True)
			!! second_separator.make (Widget_names.separator1, top_form)
			second_separator.set_horizontal (True)
			!! formats_rc.make (Widget_names.row_column, top_form) 
			formats_rc.set_row_layout
			formats_rc.set_preferred_count (1)
			formats_rc.set_spacing (5)

--samik			focus_area_form.attach_top (focus_label, 0)
			focus_area_form.attach_top (close_button, 0)
			focus_area_form.attach_top (context_hole, 0)
			focus_area_form.attach_top (trash_hole, 0)
			focus_area_form.attach_right (close_button, 0)
			focus_area_form.attach_left (context_hole, 0)
			focus_area_form.attach_left_widget (context_hole, trash_hole, 0)
--samik			focus_area_form.attach_left_widget (trash_hole, focus_label, 0)
	--samik		focus_area_form.attach_right_widget (close_button, focus_label, 0)
--samik			focus_area_form.attach_bottom (focus_label, 0)
			focus_area_form.attach_bottom (context_hole, 0)
			focus_area_form.attach_bottom (trash_hole, 0)
			focus_area_form.attach_bottom (close_button, 0)

			top_form.attach_top (focus_area_form, 0);
			top_form.attach_left (focus_area_form, 0);
			top_form.attach_right (focus_area_form, 0);
			top_form.attach_top_widget (focus_area_form, first_separator, 2)
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
			!!toggle_form.make (Current)

			!! format_list.make (formats_rc, Current)

			current_form_number := 0;
			!! del_com.make (Current);
			set_delete_command (del_com);
			initialize_window_attributes;
		end

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
					count := option_list.count;
					if current_form_number = 0 then
						i := count + 1
					else
							-- Test if the current form 
							-- is defined for the context
						from
							i := 1;
						until
							i > count or else
							option_list @ i = current_form_number
						loop
							i := i + 1
						end
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
								if formats_rc.realized then
									formats_rc.hide;
								end;
								format_list.update_buttons (option_list);
								if formats_rc.realized then
									formats_rc.show;
								end;
							end;
							context_hole.set_full_symbol;
							edited_context := new_context;
							update_title;
							set_form (edited_context.default_option_number)
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
						context_hole.set_full_symbol;
						edited_context := new_context;
						update_title;
						format_list.update_buttons (option_list);
						set_form (current_form_number)
					end
				end
			else
				other_editor.raise
			end
		end;

	update_title is
		local
			tmp: STRING
		do
			!! tmp.make (0);
			tmp.append (Widget_names.Context_name);
			tmp.append (": ");
			tmp.append (edited_context.title_label)
			set_title (tmp);
			set_icon_name (tmp);
		end;
	
	set_form (a_form_number: INTEGER) is
			-- Display 'a_form' in the context editor window
		local
			prev_form, new_form: EDITOR_FORM;
			mp: MOUSE_PTR;
			msg: STRING;
			prev_form_number: INTEGER;
			format: FORMAT_BUTTON
		do
			prev_form_number := current_form_number;
			if prev_form_number /= 0 then
				prev_form := form_list @ (prev_form_number);
			end;
			current_form_number := a_form_number;
			new_form := form_list @ (current_form_number);
			if not new_form.is_initialized then
				if prev_form /= Void then
					-- This is done here since it
					-- looks better under X
					prev_form.hide;
				end;
				!!mp;
				mp.set_watch_shape;
				new_form.make_visible (top_form);
				mp.restore;
				if prev_form /= Void then
					format := prev_form.associated_format_button;
					format.unselect_symbol
				end;
			elseif prev_form /= Void and then
				prev_form /= new_form
			then
				prev_form.hide;
				format := prev_form.associated_format_button;
				format.unselect_symbol
			end;
			format := new_form.associated_format_button;
			format.set_selected_symbol;
			new_form.show;
			new_form.reset;
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

	destroy is
		do
			behavior_form.unregister_holes;
			alignment_form.unregister_holes;
			color_form.unregister_holes;
			context_hole.unregister;
			trash_hole.unregister;
			shell_destroy
		end;

	close is
			-- Close current editor
		do
			clear;
			window_mgr.close (Current)
		end

	clear_behavior_editor is
		do
			if behavior_form /= Void and then
				behavior_form.is_initialized 
			then
				behavior_form.clear_editor
			end
		end

	clear is
			-- Reset the hole of the context editor
		local
			current_form: EDITOR_FORM
		do
			if current_form_number /= 0 then
				current_form := form_list @ (current_form_number);
				current_form.hide;
				current_form.associated_format_button.unselect_symbol
			end;
			edited_context := Void;
			current_form_number := 0;
			set_title (Widget_names.context_editor);
			set_icon_name (Widget_names.context_editor);
			context_hole.set_empty_symbol;
			clear_behavior_editor;
		end;

	apply_current_form is
		require
			valid_form_number: current_form_number /= 0
		local
			current_form: EDITOR_FORM
		do
			current_form := form_list @ (current_form_number);
			current_form.apply;
		end;

	reset_current_form is
		require
			valid_form_number: current_form_number /= 0
		local
			current_form: EDITOR_FORM
		do
			current_form := form_list @ (current_form_number);
			current_form.reset;
		end;

	reset_behavior_editor is
		do
			if behavior_form /= Void and then
				behavior_form.is_initialized 
			then
				behavior_form.reset_editor
			end
		end;

	update_state_name_in_behavior_page (s: STATE) is
			-- Update the state name in behavior page
			-- that displays `state'.
		do
			if behavior_form_shown then
				behavior_form.update_state_name (s)
			end
		end;

	reset_geometry_form is
		local
			geo_form: GEOMETRY_FORM
		do
			if current_form_number /= 0 then
				geo_form ?= form_list @ (current_form_number);
				if geo_form /= Void then
					geo_form.reset;
				end;
			end;
		end;

	update_translation_page is
		require
			behaviour_form_shown: behavior_form_shown 
		local
			beh_form: BEHAVIOR_FORM
		do
			beh_form ?= form_list @ (current_form_number);
			beh_form.update_translation_page;
		end;

end
