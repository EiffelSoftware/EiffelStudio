
class GENERATE_BUTTON

inherit

	LICENCE_COMMAND;
	FOCUSABLE;
	EB_PICT_B
		export
			{NONE} all
		undefine
			init_toolkit
		end;	
	WINDOWS;
	PIXMAPS;
	UNIX_ENV

creation

	make

feature {NONE}

	focus_source: WIDGET is
		do
			Result := Current
		end;

	focus_string: STRING is "Generate code";

	focus_label: LABEL is
		do
			Result := main_panel.focus_label
		end;

	
feature 

	make (a_name: STRING; a_parent: COMPOSITE) is
		local
			Nothing: ANY
		do
			make_visible (a_parent);
			set_symbol (Generate_pixmap);
			initialize_focus;
			add_activate_action (Current, Nothing);
		end;

	
feature {NONE}

	work (argument: ANY) is
		local
			cmd: GENERATE;
		do
			if main_panel.project_initialized then
				!!cmd;
				cmd.execute (argument);
			end;
		end;
	
	continue_after_popdown (box: MESSAGE_D; ok: BOOLEAN) is
		do
		end;


end
