class APP_EDITOR_B 
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

	focus_string: STRING is "Show hide app editor"

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
			set_text ("App Editor")
			set_size (132, 36)
			initialize_focus
			add_activate_action (Current, Void)
		end
	
feature {NONE}

	work (argument: ANY) is
		do
			if main_panel.project_initialized then
				toggle
				if main_panel.app_editor.realized then
					main_panel.app_editor.show
				else
					main_panel.app_editor.realize
				end
				if main_panel.app_editor.selected_figure = Void then
					main_panel.app_editor.set_default_selected
				else
					main_panel.app_editor.display_transitions
				end
			end
		end

feature

	continue_after_popdown (box: MESSAGE_D; ok: BOOLEAN) is
		do
		end
end
