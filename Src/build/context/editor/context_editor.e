
class CONTEXT_EDITOR 

inherit

	WIDGET_NAMES
	EDITOR_NAMES
	EDITOR_FORMS
	TOP_SHELL
		rename
			make as shell_make,
			realize as shell_realize,
			show as shell_show,
			hide as shell_hide
		undefine
			init_toolkit
		redefine
			delete_window_action
		end
	TOP_SHELL
		export
			{NONE} all
			{ANY} hide, raise
		undefine
			init_toolkit
		redefine
			realize, make, show, hide, 
			delete_window_action
		select
			realize, make, show, hide
		end
	WINDOWS

creation

	make
	
feature {NONE}


	context_hole: CON_EDIT_HOLE
	
feature 

	edited_context: CONTEXT
			-- Context edited in the context editor

	current_form: EDITOR_FORM

	current_form_number: INTEGER

	
feature {NONE}

	menu_button: OPTION_MENU

	
feature 
	delete_window_action is
		do
			close
			iterate
		end

	top_form: FORM

	
feature {NONE}

	first_separator: SEPARATOR_G
	second_separator: SEPARATOR_G
	formats: ROW_COLUMN
	
feature 

	form_list: ARRAY [EDITOR_FORM]

	
feature {ALIGNMENT_CMD}

	alignment_form: ALIGNMENT_FORM

	
feature {NONE}

	behavior_form: BEHAVIOR_FORM
	
feature 

	format: FORMAT

	make (a_name: STRING a_screen: SCREEN) is
		local
			i: INTEGER

			close_button: CLOSE_CONTEXT_EDITOR

			geometry_form: GEOMETRY_FORM
			label_text_form: LABEL_TEXT_FORM
			perm_wind_form: PERM_WIND_FORM
			temp_wind_form: TEMP_WIND_FORM
--form_position: FORM_POSITION
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
			!!form_list.make (1, form_number)

			shell_make (a_name, a_screen)
--set_size (260, 480)
			!!top_form.make (F_orm, Current)

			!!context_hole.make (Current)
			context_hole.make_visible (top_form)
			!!first_separator.make (S_eparator, top_form)
			first_separator.set_horizontal (True)
			!!menu_button.make (G_eometry_form_name, Current)
--menu_button.set_insensitive
			!!second_separator.make (S_eparator, top_form)
			second_separator.set_horizontal (True)
			!!close_button.make (Current, Current)
			close_button.make_visible (top_form)
			menu_button.set_text ("Options")
			!!formats.make ("formats", top_form) 
			formats.set_row_layout
			formats.set_preferred_count (1)
			formats.set_spacing (5)
			formats.set_size(50, 100)

            top_form.set_fraction_base (20)
			top_form.attach_top (close_button, 10)
			top_form.attach_top (context_hole, 10)
			top_form.attach_right (close_button, 10)
			top_form.attach_left (context_hole, 10)

			top_form.attach_top (first_separator, 60)
			top_form.attach_left (first_separator, 0)
			top_form.attach_right (first_separator, 0)
			top_form.attach_bottom (formats, 1)
			top_form.attach_left (formats, 1)
			top_form.attach_right (formats, 1)
			top_form.attach_bottom_widget (formats, second_separator, 1)

--top_form.attach_top_widget (first_separator, menu_button.option_button, 5)
--top_form.attach_left (menu_button.option_button, 10)

--top_form.attach_top_widget (menu_button.option_button, second_separator, 5)
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
--form_position.Create (Current)
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

			!!format.make (formats, Current)
		end

	realize is
		do
			menu_button.set_insensitive
			shell_realize
			
		end

	show is
		do
			if context_hole.original_stone /= Void then
				menu_button.set_sensitive
			else
				menu_button.set_insensitive
			end
			shell_show
		end

	hide is
		do
			menu_button.set_insensitive
			shell_hide
		end


	attach_attributes_form (a_form: EDITOR_FORM) is
		do
			top_form.attach_top_widget (first_separator, a_form, 1)
			top_form.attach_left (a_form, 1)
			top_form.attach_right (a_form, 1)
--top_form.attach_bottom (a_form, 1)
			top_form.attach_bottom_widget (second_separator, a_form, 1)
		end

	set_edited_context (new_context: CONTEXT) is
			-- Set `edited_context' to `new_context'
		local
			option_list: ARRAY [INTEGER]
			list: LINKED_LIST [INTEGER]
			current_form_found: BOOLEAN
			context_form_found: BOOLEAN
			i: INTEGER
			other_editor: like Current
			old_edited_context: CONTEXT
			button_list: BUTTON_LIST
		do
			if new_context.editor_form /= Void then
				other_editor :=	context_catalog.editor (new_context, new_context.editor_form)
				other_editor := Void
			end
			if other_editor = Void then
				if new_context /= edited_context then
					menu_button.set_insensitive
					old_edited_context := edited_context
					edited_context := new_context
					context_hole.set_context (edited_context)
					option_list := edited_context.option_list
					menu_button.update (option_list)
					if edited_context.is_bulletin then
						menu_button.add_button (alignment_form_number)
						menu_button.add_button (grid_form_number)
					end
					if not (edited_context.resize_policy = Void) then
						menu_button.add_button (bulletin_resize_form_number)
					end
					menu_button.add_button (color_form_number)
					if edited_context.is_fontable then
						menu_button.add_button (font_form_number)
					end
						menu_button.add_button (behavior_form_number)
					if edited_context.editor_form = 0 then
						edited_context.set_editor_form (option_list.item (1))
					end

					!!button_list.make (new_context)
					format.add_button (button_list.menu_string)

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
							context_form_found := True
						end
						if option_list.item (i) = current_form_number then	
							current_form_found := True
						end
						i := i + 1
					end
					list := menu_button.additionnal_list
					from
						list.start
					until
						list.after or current_form_found
					loop
						if list.item = edited_context.editor_form then	
							context_form_found := True
			
						end
						if list.item = current_form_number then	
							current_form_found := True
						end
						list.forth
					end
					if current_form_found then
						edited_context.set_editor_form (current_form_number)
						set_form (edited_context.editor_form)
					elseif not context_form_found then
						other_editor :=	context_catalog.editor (new_context, 1)
						if other_editor = Void then
							edited_context.set_editor_form (edited_context.option_list.item (1))
							set_form (edited_context.editor_form)
						else
							other_editor.raise
							set_edited_context (old_edited_context)
						end
					else
						set_form (edited_context.editor_form)
					end
				end
				menu_button.set_sensitive
			else
				other_editor.raise
			end
		end
	
	update_form (a_form_number: INTEGER) is
			-- Update the form according to `a_form_number'.
		local
			other_editor: like Current
		do
			other_editor :=	context_catalog.editor (edited_context, a_form_number)
			if other_editor = Void then
				set_form (a_form_number)
			else
				menu_button.set_previous_selected_button	
				other_editor.raise
			end
		end

	set_form (a_form_number: INTEGER) is
			-- Display 'a_form' in the context editor window
		local
			new_form: EDITOR_FORM
			mp: MOUSE_PTR
			msg: STRING
		do
			unmanage
			current_form_number := a_form_number
			edited_context.set_editor_form (a_form_number)
			menu_button.set_form (edited_context.editor_form)
			new_form := form_list.item (edited_context.editor_form)
			if not new_form.is_initialized then
				!!mp
				mp.set_watch_shape
				top_form.set_managed (False)
				new_form.make_visible (Current)
				top_form.set_managed (True)
				mp.restore
			end
			if not (current_form = Void) then
				current_form.hide
				current_form.set_managed (False)
			end
			current_form := new_form
			current_form.reset_form
			current_form.show
			current_form.set_managed (True)
			manage
		end

	behavior_form_shown: BOOLEAN is
			-- Is current_form a behavior_form?
		do
			Result := (current_form_number = behavior_form_number)
		end

feature -- Reseting

	close is
			-- Close current editor
		do
			clear
			window_mgr.close (Current)
		end

	reset_behavior_editor is
		do
			if	 
				(not (behavior_form = Void)) and then
				behavior_form.is_initialized 
			then
				behavior_form.reset_editor
			end
		end

	clear is
			-- Reset the hole of the context editor
		do
			if not (current_form = Void) then
				reset_behavior_editor
				edited_context.set_editor_form (current_form_number)
				edited_context := Void
				menu_button.option_button.set_insensitive
				current_form.hide
				current_form := Void
				current_form_number := 0
				context_hole.reset
			end
		end

	update_icon_name is
		do
			context_hole.update_name
		end
end
