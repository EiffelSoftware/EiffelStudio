class SAVE_BUTTON 
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
            set_focus_string (Focus_labels.save_project_label)
        end
    
-- samik	focus_string: STRING is 
-- samik		do
-- samik			Result := Focus_labels.save_project_label
-- samik		end;

-- samik	focus_label: LABEL is
-- samik		do
-- samik			Result := main_panel.focus_label
-- samik		end;
 
	symbol: PIXMAP is
		do
			Result := Pixmaps.save_pixmap
		end;

	unsaved_symbol: PIXMAP is
		do
			Result := Pixmaps.unsave_pixmap
		end;

	execute (arg: ANY) is
		local
			save_proj: SAVE_PROJECT
		do
			if main_panel.project_initialized then
				!!save_proj;
				save_proj.execute (Void);
			end
		end

feature

	set_saved_symbol is
		do
			if pixmap /= symbol then
				set_symbol (symbol)
			end
		end;

	set_unsaved_symbol is
		do
			if pixmap /= unsaved_symbol then
				set_symbol (unsaved_symbol)
			end
		end;

end
