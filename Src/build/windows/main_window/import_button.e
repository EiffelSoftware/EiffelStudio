
class IMPORT_BUTTON 

inherit

	EB_BUTTON_COM
	WINDOWS
		select
			init_toolkit
		end

creation

	make
	
feature {NONE}

    make (a_parent: COMPOSITE) is
        do
            make_visible (a_parent)
        end

	create_focus_label is 
		do
			set_focus_string (Focus_labels.import_code_label)
		end;

-- samik	focus_label: LABEL is
-- samik		do
-- samik			Result := main_panel.focus_label
-- samik		end;

	symbol: PIXMAP is
		do
			Result := Pixmaps.import_pixmap
		end;

feature {NONE}

	work (argument: ANY) is
			-- popup a window to specify what
			-- and where to import,
		local
			iw: IMPORT_WINDOW
		do
			if main_panel.project_initialized then
				!!iw.make (main_panel.base)
				iw.popup
			end
		end

	execute (a: ANY) is
		do
			work (a)
		end

end
