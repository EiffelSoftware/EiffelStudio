class CONTEXT_CAT_B 
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

	focus_string: STRING is "Hide/Show context catalog"

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
			set_text ("Context catalog")
			set_size (132, 36)
			initialize_focus
			add_activate_action (Current, Void)
			add_enter_action (focus_command, Current)
		end
	
feature {NONE}

	work (argument: ANY) is
		do
			if main_panel.project_initialized then
                if armed then
                    main_panel.context_catalog.show
                else
                    main_panel.context_catalog.hide
                end
			end
		end

feature
    continue_after_popdown (box: MESSAGE_D; ok: BOOLEAN) is
        do
        end
end
