class SAVE_AS_BUTTON 
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
	LICENCE_COMMAND

creation

	make

feature -- Creation

	make (a_name: STRING a_parent: COMPOSITE) is
		local
			Nothing: ANY
		do
			make_visible (a_parent)
			set_symbol (Save_as_pixmap)
	--		push_b_make (a_name, a_parent)
	--		set_text ("Save As")
	--		set_size (125, 30)
			add_activate_action (Current, Nothing)
			initialize_focus
		end

feature {NONE} -- Focusable

	focus_source: WIDGET is
		do
			Result := Current
		end

	focus_string: STRING is "Save project as..."

	focus_label: LABEL is
		do
			Result := main_panel.focus_label
		end

feature {NONE} -- Execute

	work (argument: ANY) is
		local
			pw: SAVE_AS_PROJ_WIN	
		do
			if main_panel.project_initialized then
				!!pw.make ("Save project as...", main_panel.base)
				pw.popup
			end
		end

end
