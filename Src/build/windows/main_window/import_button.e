
class IMPORT_BUTTON 

inherit

	FOCUSABLE
		export
			{NONE} all
		end;
	EB_PICT_B
		export
			{NONE} all
		undefine
			init_toolkit
		end;	
	WINDOWS
		export
			{NONE} all
		end;
	PIXMAPS
		export
			{NONE} all
		end;
	LICENCE_COMMAND
		export
			{NONE} all
		end;
	UNIX_ENV
		export
			{NONE} all
		end


creation

	make

	
feature {NONE}

	focus_source: WIDGET is
		do
			Result := Current
		end;

	focus_string: STRING is "Import";

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
			set_symbol (Import_pixmap);
			initialize_focus;
			add_activate_action (Current, Nothing);
		end;

	
feature {NONE}

	work (argument: ANY) is
			-- popup a window to specify what
			-- and where to import,
		local
			iw: IMPORT_WINDOW;
		do
			if main_panel.project_initialized then
				!!iw.make ("Import project", main_panel.base);
				iw.popup;
			end
		end;

	continue_after_popdown (box: MESSAGE_D; ok: BOOLEAN) is
		do
		end;

end
