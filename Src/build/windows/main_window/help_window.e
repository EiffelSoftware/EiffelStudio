
class HELP_WINDOW 

inherit

	TOP_SHELL
		rename
			make as top_shell_create
		end;

	WIDGET_NAMES
		export
			{NONE} all
		end


creation

	make

	
feature {NONE}

	form, form1: FORM;
	hole: HELP_HOLE;
	close_b: CLOSE_BUTTON;
	
feature 

	text: SCROLLED_T;

	make (a_name: STRING; a_screen: SCREEN) is
		local
			contin_command: ITER_COMMAND;
		do
			top_shell_create (a_name, a_screen);
			!!form.make (F_orm, Current);
			!!form1.make (F_orm1, form);
			!!text.make (T_ext, form);
			!!hole.make (Current, form1);
			!!close_b.make (Current);
			close_b.make_visible (form1);
			
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
			text.enable_word_wrap;
			!!contin_command;
			set_delete_command (contin_command);
		end;

end
