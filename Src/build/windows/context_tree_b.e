class CONTEXT_TREE_B 
inherit

	FOCUSABLE
	PUSH_B_TOGGLE
		rename
			make as push_b_toggle_make
		undefine
			init_toolkit
		end	
	WINDOWS
	LICENCE_COMMAND

creation
	make
	
feature {NONE}

	focus_source: WIDGET is
		do
			Result := Current
		end

	focus_string: STRING is "Show/hide context tree"

	focus_label: LABEL is
		do
			Result := main_panel.focus_label
		end

feature 

	make (a_name: STRING a_parent: COMPOSITE) is
		local
			Nothing: ANY
		do
			push_b_toggle_make (a_name, a_parent)
			set_text ("Context tree")
			set_size (132, 36)
			initialize_focus
			add_activate_action (Current, Void)
		end
	
feature {NONE}

	work (argument: ANY) is
		do
			if main_panel.project_initialized then
                if armed then
                    main_panel.tree.show
                else
                    main_panel.tree.hide
                end
			end
		end

end
