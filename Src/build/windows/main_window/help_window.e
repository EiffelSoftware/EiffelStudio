
class HELP_WINDOW 

inherit

	CONSTANTS;
	TOP_SHELL
		rename
			make as top_shell_create
		end;
	CLOSEABLE

creation

	make

	
feature {NONE}

	form, form1: FORM;
	hole: HELP_HOLE;
	close_b: CLOSE_WINDOW_BUTTON;
	
feature 

	text: SCROLLED_T;

	close is 
		do
			destroy
		end;

	make (a_screen: SCREEN) is
		local
			delete_com: DELETE_WINDOW;
		do
			top_shell_create (Widget_names.help_window, a_screen);
			!!form.make (Widget_names.form, Current);
			!!form1.make (Widget_names.form1, form);
			!!text.make_word_wrapped (Widget_names.text, form);
			!!hole.make (Current, form1);
			io.error.putstring ("help_window: FIXME%N");
			!!close_b.make (Current, form1, Void);
			
			form.attach_top (form1, 2);
			form.attach_left (form1, 2);
			form.attach_right (form1, 2);
			form.attach_bottom (text, 2);
			form.attach_left (text, 2);
			form.attach_right (text, 2);
			form.attach_top_widget (form1, text, 2);
			form1.attach_top (hole, 2);
			form1.attach_left (hole, 2);
			form1.attach_bottom (hole, 2);
			form1.attach_top (close_b, 2);
			form1.attach_right (close_b, 2);
			form1.attach_bottom (close_b, 2);
			!!delete_com.make (Current);
			set_delete_command (delete_com);
		end;

end
