class NAMER_WINDOW

inherit

	EB_TOP_SHELL
		rename
			make as shell_make
		redefine
			set_geometry
		end

	COMMAND

	CLOSEABLE

creation

	make

feature -- Geometry

	set_geometry is
		do
			set_size (Resources.namer_wnd_width,
					Resources.namer_wnd_height)
		end

feature
	
	namable: NAMABLE


feature {NONE}

	text: TEXT_FIELD

	make (a_screen: SCREEN) is
		local
			top_form, form: FORM
			del_com: DELETE_WINDOW
			ok_b: OK_BUTTON
			namer_hole: NAMER_WIN_EDIT_HOLE
		do
			-- make the form
			shell_make (Widget_names.namer_window, a_screen)
			!! form.make (Widget_names.form, Current)
			!! top_form.make (Widget_names.form, form)
			!! namer_hole.make (top_form)
			!! ok_b.make (Current, top_form)
			!! text.make (Widget_names.textfield, form)

			top_form.attach_top (namer_hole, 0)
			top_form.attach_top (ok_b, 0)
			top_form.attach_left (namer_hole, 0)
			top_form.attach_right (ok_b, 0)
			top_form.attach_bottom (namer_hole, 0)
			top_form.attach_bottom (ok_b, 0)
			form.attach_top_widget (top_form, text, 0)
			form.attach_top (top_form, 0)
			form.attach_right (top_form, 0)
			form.attach_left (top_form, 0)
			form.attach_left(text, 2)
			form.attach_right(text, 2)
			form.attach_bottom (text, 2)

			-- add callbacks and modal behaviour
			text.add_activate_action (Current, Current)
			--++-- text.set_single_line_mode
			!! del_com.make (Current)
			set_delete_command (del_com)
			initialize_window_attributes
		end 

feature

	set_namable (nam: like namable) is
		require
			valid_nam: nam /= Void
			is_able_to_be_named: nam.is_able_to_be_named
		do
			namable := nam
			update_name
		end

	popup_with (nam: like namable) is
		require
			valid_nam: nam /= Void
			is_able_to_be_named: nam.is_able_to_be_named
		do
			set_namable (nam)
			set_x_y (screen.x, screen.y)
			if realized then
				show
				raise
			else
				realize
			end
		end

	popdown is
		do
			namable := Void
			text.clear
			set_title (Widget_names.translation_editor)
			set_icon_name (Widget_names.translation_editor)
			hide
		end

	close is
			-- close the popup
		do
			if realized then
				popdown
			end
		end

	set_name is
			-- set the name to text value
		local
			namer_cmd: NAMER_CMD
			context: CONTEXT
			tmp_width, tmp_height: INTEGER
		do
			namable.check_new_name (text.text)
			if namable.is_valid_new_name then
				!! namer_cmd
				namer_cmd.execute (text.text)
			end
		end

	update_name is
		local
			tmp: STRING
		do
			!! tmp.make (0)
			tmp.append (Widget_names.visual_name_label)
			tmp.append (namable.title_label)
			if not text.text.is_equal (namable.label) then
				text.set_text (namable.label)
			end
			set_title (tmp)
			set_icon_name (tmp)
		end

feature {NONE} -- Command Actions

	execute (arg: ANY) is
		do
			if not equal (text.text, namable.visual_name) then
				set_name
			end
			close
		end

end 
