
class PERM_WIND_FORM 

inherit

	COMMAND
	EDITOR_FORM
		redefine
			context
		end

creation

	make

feature {NONE}

	pixmap_name: EB_TEXT_FIELD

	pixmap_selection_box: PIXMAP_FILE_BOX

	title: EB_TEXT_FIELD
			-- Title of the perm_wind

	forbid_recomp: EB_TOGGLE_B 
								
	set_hidden: EB_TOGGLE_B

	set_default_position_t: EB_TOGGLE_B

	icon_name: EB_TEXT_FIELD

	iconic_state: EB_TOGGLE_B

	context: PERM_WIND_C is
		do
			Result ?= editor.edited_context
		end

	form_number: INTEGER is
		do
			Result := Context_const.perm_wind_att_form_nbr
		end

	format_number: INTEGER is
		do
			Result := Context_const.attribute_format_nbr
		end

	Win_set_default_position_cmd: WIN_SET_DEFAULT_POS_CMD is
		once
			!! Result
		end

	Perm_icon_name_cmd: PERM_ICON_NAME_CMD is
		once
			!! Result
		end

	Perm_icon_cmd: PERM_ICON_CMD is
		once
			!! Result
		end

	Perm_iconic_cmd: PERM_ICONIC_CMD is
		once
			!! Result
		end

	Perm_hidden_cmd: PERM_SHOWN_CMD is
		once
			!! Result
		end

--	Perm_resize_cmd: PERM_RESIZE_CMD is
--		once
--			!! Result
--		end

	Perm_resize_cmd: WINDOW_RESIZE_CMD is
		once
			!! Result
		end

    Perm_title_cmd: PERM_TITLE_CMD is
        once
            !! Result
        end

feature 

	make_visible (a_parent: COMPOSITE) is
		local
			pixmap_open_b: PUSH_B
			title_label: LABEL
			icon_label: LABEL
			icon_pixmap_label: LABEL
			combo_box: CHECK_BOX
		do	
			initialize (Widget_names.perm_wind_form_name, a_parent)

			!! title_label.make (Widget_names.title_name, Current)
			!! title.make (Widget_names.textfield, Current, Perm_title_cmd, editor)
			!! icon_label.make (Widget_names.label_name, Current)
			!! icon_name.make (Widget_names.textfield, Current,
					Perm_icon_name_cmd, editor)
			!! icon_pixmap_label.make (Widget_names.icon_pix_name, Current)
			!! pixmap_name.make (Widget_names.textfield, Current, 
					Perm_icon_cmd, editor)
			!! pixmap_open_b.make (Widget_names.open_pixmap_name, Current)
			!! combo_box.make ("", Current)
			!! forbid_recomp.make (Widget_names.forbid_recomp_size_name, 
					combo_box, Perm_resize_cmd, editor)
			!! set_default_position_t.make 
					(Widget_names.set_default_position_name, 	
					combo_box, Win_set_default_position_cmd, editor)
			!! set_hidden.make (Widget_names.set_shown_name, 
					combo_box, Perm_hidden_cmd, editor)
			!! iconic_state.make (Widget_names.iconic_state_name, 
					combo_box, Perm_iconic_cmd, editor)

				--| Perform attachments
			set_size (200, 200)
			attach_left (title_label, 10)
			attach_left (title, 100)
			attach_left (icon_label, 10)
			attach_left (icon_name, 100)
			attach_left (icon_pixmap_label, 10)
			attach_left (pixmap_name, 100)
			attach_left (pixmap_open_b, 100)
			attach_left (combo_box, 10)

			attach_right (title, 10)
			attach_right (pixmap_name, 10)
			attach_right (icon_name, 10)
--			attach_right (combo_box, 10)
			
			attach_top (title, 10)
			attach_top (title_label, 15)
			attach_top_widget (title, icon_label, 15)
			attach_top_widget (title, icon_name, 10)
			attach_top_widget (title_label, icon_label, 15)
			attach_top_widget (title_label, icon_name, 10)
			attach_top_widget (icon_name, icon_pixmap_label, 15)
			attach_top_widget (icon_name, pixmap_name, 10)
			attach_top_widget (icon_label, icon_pixmap_label, 15)
			attach_top_widget (icon_label, pixmap_name, 10)
			attach_top_widget (pixmap_name, pixmap_open_b, 10)
			attach_top_widget (icon_pixmap_label, pixmap_open_b, 10)
			attach_top_widget (pixmap_open_b, combo_box, 10)
			
			attach_bottom (combo_box, 0)
			
				--| Add callbacks
			pixmap_open_b.add_activate_action (Current, Void)
			
			show_current
		end

	
feature {NONE}

	execute (argument: ANY) is
		do
			if (pixmap_selection_box = Void) then
				!! pixmap_selection_box.make 
					(pixmap_name, Current, Perm_icon_cmd, editor)
			end
			pixmap_selection_box.popup
		end

	reset is
		do
			if not (context.title = Void) then
				title.set_text (context.title)
			else
				title.set_text ("")
			end
			forbid_recomp.set_state (context.resize_policy_disabled)
			if not (context.icon_name = Void) then
				icon_name.set_text (context.icon_name)
			else
				icon_name.set_text ("")
			end
			if not (context.icon_pixmap_name = Void) then
				pixmap_name.set_text (context.icon_pixmap_name)
			else
				pixmap_name.set_text ("")
			end
			set_default_position_t.set_state (context.default_position)
			set_hidden.set_state (context.start_hidden)
			iconic_state.set_state (context.is_iconic_state)
		end

	
feature 

	apply is
		do
			if (context.title = Void) then
				if (not title.text.empty) then
					context.set_title (title.text)
				end
			elseif not title.text.is_equal (context.title) then
				if context.title.count < title.text.count then
					parent.unmanage
				end
				context.set_title (title.text)
				if not parent.managed then
					parent.manage
				end
			end
			if (context.icon_name = Void) then
				if (not icon_name.text.empty) then
					context.set_icon_name (icon_name.text)
				end
			elseif not icon_name.text.is_equal (context.icon_name) then
				context.set_icon_name (icon_name.text)
			end
			if (context.icon_pixmap_name = Void) then
				if (not pixmap_name.text.empty) then
					context.set_icon_pixmap (pixmap_name.text)
				end
			elseif not pixmap_name.text.is_equal (context.icon_pixmap_name) then
				context.set_icon_pixmap (pixmap_name.text)
			end
			if context.resize_policy_disabled /= forbid_recomp.state then
				context.disable_resize_policy (forbid_recomp.state)
			end
			if context.default_position /= set_default_position_t.state then
				context.set_default_position (set_default_position_t.state)
			end
			if set_hidden.state /= context.start_hidden then
				context.set_start_hidden (set_hidden.state)
			end
			if iconic_state.state /= context.is_iconic_state then
				context.set_iconic_state (iconic_state.state)
			end
		end

end
