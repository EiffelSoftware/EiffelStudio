class TOOLKIT_SELECTION_POPUP

inherit

	WINDOWS;
	COMMAND;
	CLOSEABLE;
	SHARED_TOOLKIT_NAME

creation
	make

feature {NONE}

	make is
		local
			rb: RADIO_BOX;
			temp: FILE_NAME;
			file: PLAIN_TEXT_FILE;
			top_form: FORM;
			toolkit_name: STRING;
			toggle: TOGGLE_B;
			toggle_found: BOOLEAN;
			del_win: DELETE_WINDOW;
			close_button: CLOSE_WINDOW_BUTTON;
			set_win_att: SET_WINDOW_ATTRIBUTES_COM
		do
			!! form_d.make (Widget_names.select_toolkit_popup,
				Main_panel.base);
			form_d.set_title (Widget_names.select_toolkit_popup);
			!! rb.make (Widget_names.radio_box, form_d);	
			!! top_form.make (Widget_names.form, form_d);
			!! focus_label.initialize (top_form);
			!! close_button.make (Current, top_form);
			top_form.attach_left (focus_label, 0);
			top_form.attach_bottom (focus_label, 0);
			top_form.attach_top (focus_label, 0);
			top_form.attach_right (close_button, 0);
			top_form.attach_bottom (close_button, 0);
			top_form.attach_top (close_button, 0);
			top_form.attach_right_widget (close_button, focus_label, 0)
			form_d.attach_top (top_form, 0);
			form_d.attach_left (top_form, 0);
			form_d.attach_right (top_form, 0);
			form_d.attach_top_widget (top_form, rb, 0);
			form_d.attach_right (rb, 0);
			form_d.attach_left (rb, 0);
			form_d.attach_bottom (rb, 0);
			rb.set_always_one (True);
			
			temp := Environment.toolkits_file;
			!! file.make (temp);
			if file.exists and then 
				file.is_readable and then
				not file.empty
			then
				from
					file.open_read;
					file.readline;
				until
					file.end_of_file
				loop
					toolkit_name := file.laststring;
					!! toggle.make (toolkit_name, rb);
					toggle.add_activate_action (Current, toggle);
					if toolkit_name.is_equal (Shared_toolkit_name) then
						toggle_found := True
						toggle.set_toggle_on
					end;
					file.readline
				end;
				file.close;
				if not toggle_found then
					!! toggle.make (Shared_toolkit_name, rb);
					toggle.add_activate_action (Current, toggle);
					toggle.set_toggle_on
				end;
			else
				!! toggle.make (Shared_toolkit_name, rb);
				toggle.set_toggle_on;
				io.error.putstring ("Warning: cannot read ");
				io.error.putstring (temp);
				io.error.new_line;
			end;
			!! del_win.make (Current);
			form_d.set_action ("<Unmap>", del_win, Void);
			!! set_win_att;
			set_win_att.execute (form_d);
		end;

feature

	form_d: FORM_D;

	focus_label: FOCUS_LABEL;

	popup is
		do
			form_d.popup
		end

feature {NONE}

	close is
		do
			form_d.destroy;
			form_d := Void
		end;

	execute (arg: ANY) is
		local
			t: TOGGLE_B
		do
			t ?= arg;
			if t /= Void then
				Shared_toolkit_name.wipe_out;
				Shared_toolkit_name.append (t.identifier)
			end;
		end;

end
