
class HELP_WINDOW 

inherit

	CONSTANTS;
	TOP_SHELL
		rename
			make as top_shell_create,
			destroy as old_destroy
		end;
	TOP_SHELL
		rename
			make as top_shell_create
		redefine
			destroy
		select
			destroy
		end;
	CLOSEABLE

creation

	make

feature {NONE}

	text: SCROLLED_T;

	help_hole: HELP_HOLE;

	close is 
		do
			destroy
		end;

	destroy is
		do
			old_destroy;
			help_hole.unregister
		end;

	make (a_screen: SCREEN) is
		local
			delete_com: DELETE_WINDOW;
			focus_label: FOCUS_LABEL;
			form, form1: FORM;
			close_b: CLOSE_WINDOW_BUTTON;
		do
			top_shell_create (Widget_names.help_window, a_screen);
			!! form.make (Widget_names.form, Current);
			!! text.make_word_wrapped (Widget_names.text, form);
			!! form1.make (Widget_names.form1, form);

			!! focus_label.make (form1);
			!! help_hole.make (Current, form1, focus_label);
			!! close_b.make (Current, form1, focus_label);
			
			form.attach_top (form1, 2);
			form.attach_left (form1, 2);
			form.attach_right (form1, 2);
			form.attach_bottom (text, 2);
			form.attach_left (text, 2);
			form.attach_right (text, 2);
			form.attach_top_widget (form1, text, 2);

			form1.attach_top (help_hole, 0);
			form1.attach_top (close_b, 0);
			form1.attach_top (focus_label, 0);
			form1.attach_left (help_hole, 2);
			form1.attach_left_widget (help_hole, focus_label, 0);
			form1.attach_right_widget (close_b, focus_label, 0);
			form1.attach_right (close_b, 2);
			form1.attach_bottom (focus_label, 2);
			form1.attach_bottom (help_hole, 2);
			form1.attach_bottom (close_b, 2);

			!!delete_com.make (Current);
			set_delete_command (delete_com);
		end;

feature

	set_text (txt: STRING) is
		require
			valid_txt: txt /= Void
		do
			text.set_text (txt)
		end;

end
