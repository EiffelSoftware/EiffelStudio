class SAVE_BUTTON 
inherit

	FOCUSABLE
--	PUSH_B
--		rename
--			make as push_b_make
--		undefine
--			init_toolkit
--		end	

	EB_PICT_B
        export
            {NONE} all
        undefine
            init_toolkit
        end
	WINDOWS
	PIXMAPS

creation

	make

feature {NONE}

	focus_source: WIDGET is
		do
			Result := Current
		end

	focus_string: STRING is "Save project"

	focus_label: LABEL is
		do
			Result := main_panel.focus_label
		end

	
feature 

	make (a_name: STRING a_parent: COMPOSITE) is
		local
			Nothing: ANY
			save_proj: SAVE_PROJECT
		do
			make_visible (a_parent)
			set_symbol (Save_pixmap)
			--push_b_make (a_name, a_parent)
			--set_text ("Save")
			--set_size (125, 30)
			initialize_focus
			!!save_proj
			add_activate_action (save_proj, Nothing)
		end

end
