
class NEW_CLASS_W 

inherit

	CUSTOM_INTERF;
	COMMAND_W
		redefine
			execute
		end;
	NAMER;
	FORM_D
		rename
			make as form_d_make
		end

creation

	make
	
feature 

	make (class_w: CLASS_W) is
			-- Create a file selection dialog
		do
			form_d_make (l_new_class, class_w);
			set_title (l_new_class);
			set_exclusive_grab;
			popup;
		end;

	execute (arg: ANY) is
		do
		end;

	work (arg: ANY) is
		do
		end;


end
