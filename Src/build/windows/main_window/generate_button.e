
class GENERATE_BUTTON

inherit

	LICENCE_COMMAND
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

	focus_string: STRING is "Generate code"

	focus_label: LABEL is
		do
			Result := main_panel.focus_label
		end

	
feature 

	make (a_name: STRING a_parent: COMPOSITE) is
		local
			Nothing: ANY
		do
			make_visible (a_parent)
			set_symbol (Generate_pixmap)

	--		push_b_make (a_name, a_parent)
			initialize_focus
			add_activate_action (Current, Nothing)
	--		set_text ("Generate")
--			set_size (125, 30)
		end

	
feature {NONE}

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
