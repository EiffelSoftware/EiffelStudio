
class WINDOW_CMDS 

inherit

	COMMAND_PAGE
		rename 
			make as page_create, 
			make_visible as make_page_visible 
		end;

	COMMAND_PAGE
		redefine
			make_visible, make
		select
			make_visible, make
		end


creation

	make

	
feature {NONE}

	popup_command: POPUP_CMD;

	popdown_command: POPDOWN_CMD;

	
feature 

	make (page_n: STRING; a_symbol: PIXMAP; cat: CMD_CATALOG) is
		do
			page_create (page_n, a_symbol, cat);
			!!popup_command.make;
			!!popdown_command.make;
			add (popup_command);
			add (popdown_command);
		end;

	
feature {CATALOG}

	make_visible (a_name: STRING; a_parent: COMPOSITE) is
		do
			make_page_visible (a_name, a_parent);
		end;

end -- class WINDOW_CMDS
