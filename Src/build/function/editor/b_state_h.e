
class B_STATE_H 

inherit

	EB_BUTTON;
	HOLE
		redefine
			process_state
		end;
	WINDOWS
		select
			init_toolkit
		end
	SHARED_APPLICATION;
	COMMAND

creation

	make

feature 

	make (ed: BEHAVIOR_EDITOR; a_parent: COMPOSITE) is
		do
			associated_editor := ed;
			make_visible (a_parent);
			register;
			add_button_press_action (3, Current, Void);
		end;

	symbol: PIXMAP is
		do
			Result := Pixmaps.state_pixmap
		end;

	create_focus_label is
		do
			set_focus_string (Focus_labels.state_label)
		end;

	target: WIDGET is
		do
			Result := Current
		end;

	set_state (s: STRING) is
		local
			state: BUILD_STATE
		do
			state := Shared_app_graph.state (s);		
			if state /= Void then
				update_behavior_editor (state)
			end
		end;

feature {NONE}

	associated_editor: BEHAVIOR_EDITOR;

	states_wnd: STATES_WND is
		do
			!!Result.make (associated_editor.form, Current)
		end;

	stone_type: INTEGER is
		do
			Result := Stone_types.state_type
		end;

	process_state (dropped: STATE_STONE) is
		do
			update_behavior_editor (dropped.data)
		end;

	update_behavior_editor (s: BUILD_STATE) is
		local
			prev_s: BUILD_STATE;
			prev_b, b: BEHAVIOR;
			c: CONTEXT
		do
			c := associated_editor.edited_context;
			s.find_input (c);
			if not s.after then
				b := s.output.data
			else	
				!!b.make;
				b.set_internal_name ("");
				b.set_context (c);
				s.add (c, b);
			end;
			associated_editor.set_edited_function (b);
			associated_editor.set_current_state (s);
		end;

	execute (argument: ANY) is
		do
			states_wnd.popup (Shared_app_graph.state_names);
		end;

end
	
