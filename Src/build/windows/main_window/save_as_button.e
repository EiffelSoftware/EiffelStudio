
class SAVE_AS_BUTTON 

inherit

	FOCUSABLE;
	EB_PICT_B
		undefine
			init_toolkit
		end;	
	WINDOWS;
	PIXMAPS;
	LICENCE_COMMAND;

creation

	make

feature -- Creation

	make (a_name: STRING; a_parent: COMPOSITE) is
		local
			Nothing: ANY
		do
			make_visible (a_parent);
			set_symbol (Save_as_pixmap);
			add_activate_action (Current, Nothing);
			initialize_focus;
		end;

feature {NONE} -- Focusable

	focus_source: WIDGET is
		do
			Result := Current
		end;

	focus_string: STRING is "Save project as...";

	focus_label: LABEL is
		do
			Result := main_panel.focus_label
		end;

feature {NONE} -- Execute


	work (argument: ANY) is
		local
			pw: SAVE_AS_PROJ_WIN	
		do
			if main_panel.project_initialized then
				!!pw.make ("Save project as...", main_panel.base);
				pw.popup
			end
		end;

	continue_after_popdown (box: MESSAGE_D; ok: BOOLEAN) is
		do
		end;

end
