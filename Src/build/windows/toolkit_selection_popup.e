class TOOLKIT_SELECTION_POPUP

inherit

	WINDOWS
	COMMAND
	CLOSEABLE
	SHARED_TOOLKIT_NAME

creation
	make

feature {NONE}

	make is

		do
			!! form_d.make (Widget_names.select_toolkit_popup, Main_panel.base)
			form_d.set_title (Widget_names.select_toolkit_popup)
			!! rb.make (Widget_names.radio_box, form_d)	
			!! bottom_form.make (Widget_names.form, form_d)
			!! focus_label.initialize (bottom_form)
			!! ok_button.make ("OK", bottom_form)
			set_values
			attach_all
		end

feature

	form_d: FORM_D

	focus_label: FOCUS_LABEL

	popup is
		do
			form_d.popup
		end

feature {NONE} -- GUI attributes

	rb: RADIO_BOX
	temp: FILE_NAME
	file: PLAIN_TEXT_FILE
	bottom_form: FORM
	toolkit_name: STRING
	toggle: TOGGLE_B
	toggle_found: BOOLEAN
	del_win: DELETE_WINDOW
	ok_button: PUSH_B
	set_win_att: SET_WINDOW_ATTRIBUTES_COM

feature {NONE}

	set_values is
		do
			rb.set_always_one (True)
			
			temp := Environment.toolkits_file
			!! file.make (temp)
			if file.exists and then 
				file.is_readable and then
				not file.empty
			then
				from
					file.open_read
					file.readline
				until
					file.end_of_file
				loop
					toolkit_name := file.laststring
					!! toggle.make (toolkit_name, rb)
					toggle.add_activate_action (Current, toggle)
					if toolkit_name.is_equal (Shared_toolkit_name) then
						toggle_found := True
						toggle.set_toggle_on
					end
					file.readline
				end
				file.close
				if not toggle_found then
					!! toggle.make (Shared_toolkit_name, rb)
					toggle.add_activate_action (Current, toggle)
					toggle.set_toggle_on
				end
			else
				!! toggle.make (Shared_toolkit_name, rb)
				toggle.set_toggle_on
				io.error.putstring ("Warning: cannot read ")
				io.error.putstring (temp)
				io.error.new_line
			end
			!! del_win.make (Current)
			form_d.set_action ("<Unmap>", del_win, Void)
			form_d.set_action ("<Key>RETURN", del_win, Void)
			form_d.add_destroy_action (del_win, Void)
			form_d.set_exclusive_grab
			!! set_win_att
			set_win_att.execute (form_d)
			form_d.set_height (60)
			form_d.forbid_resize
			ok_button.add_activate_action (del_win, Void)
		end

	attach_all is
			-- Perform attachment
		do
			bottom_form.set_fraction_base (3)
			bottom_form.attach_top (ok_button, 0)
			bottom_form.attach_left_position (ok_button, 1)
			bottom_form.attach_right_position (ok_button, 2)
			bottom_form.attach_bottom (ok_button, 0)

			form_d.attach_top (rb, 0)
			form_d.attach_right (rb, 0)
			form_d.attach_left (rb, 0)
			form_d.attach_top_widget (rb, bottom_form, 0)
			form_d.attach_left (bottom_form, 0)
			form_d.attach_right (bottom_form, 0)
			form_d.attach_bottom (bottom_form, 0)
		end

	close is
		do
			form_d.destroy
			form_d := Void
		end

	execute (arg: ANY) is
		local
			t: TOGGLE_B
		do
			t ?= arg
			if t /= Void then
				Shared_toolkit_name.wipe_out
				Shared_toolkit_name.append (t.identifier)
			end
		end

end
