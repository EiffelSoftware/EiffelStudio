
class GENERATE_BUTTON

inherit

	LICENCE_COMMAND;
	EB_BUTTON_COM
		rename
			make_visible as make
		end;
	WINDOWS

creation

	make

feature {NONE}

	focus_string: STRING is 
		do
			Result := Focus_labels.generate_code_label
		end;

	focus_label: LABEL is
		do
			Result := main_panel.focus_label
		end

feature {NONE}

	symbol: PIXMAP is
		do
			Result := Pixmaps.generate_pixmap
		end;

	work (argument: ANY) is
		local
			cmd: GENERATE
		do
			if main_panel.project_initialized then
				!!cmd
				cmd.execute (argument)
			end
		end

end
