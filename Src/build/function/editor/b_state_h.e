
class B_STATE_H 

inherit

	ICON_HOLE
		rename
			make_visible as make_icon_visible
		redefine
			stone, compatible
		end;
	ICON_HOLE
		redefine
			stone, make_visible, compatible
		select
			make_visible
		end;
	PIXMAPS
		export
			{NONE} all
		end;
	WINDOWS;
	APP_SHARED;
	COMMAND

creation

	make

	
feature 

	make (ed: BEHAVIOR_EDITOR) is
		do
			associated_editor := ed;
			set_symbol (State_pixmap);
		end;

	make_visible (a_parent: COMPOSITE) is
		local
			Nothing: ANY
		do
			make_icon_visible (a_parent);
			button.add_button_press_action (2, Current, Nothing);
		end;

	set_state (s: STRING) is
		local
			state: STATE
		do
			state := graph.state (s);		
			if state /= Void then
				update_behavior_editor (state)
			end
		end;

feature {STATES_WND}

	reset_callback is
		local
			Nothing: ANY;
		do
			button.add_button_press_action (2, Current, Nothing);
		end;

feature {NONE}

	associated_editor: BEHAVIOR_EDITOR;

	stone: STATE_STONE;
	
	compatible (s: STATE_STONE): BOOLEAN is
		do
			stone ?= s;
			Result := stone /= Void;
		end;

	states_wnd: STATES_WND is
		do
			!!Result.make (associated_editor.form, Current)
		end;

	process_stone is
		do
			update_behavior_editor (stone.original_stone)
		end;

	update_behavior_editor (s: STATE) is
		local
			prev_s: STATE;
			prev_b, b: BEHAVIOR;
			c: CONTEXT
		do
			c := associated_editor.edited_context;
			s.find_input (c);
			if not s.after then
				b := s.output.original_stone
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
		local
			Nothing: ANY;
		do
			button.remove_button_press_action (2, Current, Nothing);
			states_wnd.popup (graph.state_names);
		end;

end
	
