class SAVE_BUTTON 
inherit

	EB_BUTTON_COM

	WINDOWS
		select
			init_toolkit
		end

	COMMAND_ARGS

creation

	make

feature {NONE}

    make (a_parent: COMPOSITE) is
        do
            make_visible (a_parent)
        end
    
	create_focus_label is 
		do
			set_focus_string (Focus_labels.save_project_label)
		end;

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
			generate: GENERATE
		do
			if arg = First then
				!! generate
				generate.execute (arg)
			elseif main_panel.project_initialized then
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
