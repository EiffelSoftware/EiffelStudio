
class BEHAVIOR_FORM 

inherit

	CONTEXT_CMDS
		export
			{NONE} all
		end;
	EDITOR_FORM
		rename
			show as form_show
		undefine
			init_toolkit
		redefine
			form_name		
		end;

	EDITOR_FORM
		undefine
			init_toolkit
		redefine
			show, form_name
		select
			show
		end;
	APP_SHARED
		export
			{NONE} all
		end;
	WINDOWS
		export
			{NONE} all
		end


creation

	make

    
feature 

	form_name: STRING is
        do
            Result := B_ehavior_form_name
        end;

	make (a_parent: CONTEXT_EDITOR) is
		do
			a_parent.form_list.put (Current, behavior_form_number);
		end;

	
feature {NONE}

	event_catalog: EVENT_CATALOG;

	behavior_editor: BEHAVIOR_EDITOR;

	
feature 

	make_visible (a_parent: CONTEXT_EDITOR) is
		do
			initialize ("Behavior_form", a_parent);
			!!event_catalog.make ("Event Catalog", Current);
			!!behavior_editor.make ("Behavior Editor", Current);

			set_fraction_base (5);
			attach_top (event_catalog, 0);
			attach_left (event_catalog, 0);
			attach_right (event_catalog, 0);
			attach_left (behavior_editor.form, 0);
			attach_right (behavior_editor.form, 0);
			attach_bottom (behavior_editor.form, 0);
			attach_top_widget (event_catalog, behavior_editor.form, 5);
			attach_bottom_position (event_catalog, 2);
			attach_top_position (behavior_editor.form, 2);
		end;

	reset_editor is
			-- Reset the edited_function of Current. 
		do
			behavior_editor.clear
		end;

	update_translation_page is
		do
			if event_catalog.translation_page_shown then
				event_catalog.update_translations
			end;
		end;

	
feature {NONE}

	reset is
		local
			behavior: BEHAVIOR;
			previous_behavior: BEHAVIOR;
			current_state: STATE;
		do
			event_catalog.update_pages (context);
			current_state := behavior_editor.current_state;
			if (current_state = Void) then
				current_state := app_editor.initial_state_circle.original_stone;
			end;
			current_state.find_input (context);
			if not current_state.after then
				behavior := current_state.output.original_stone;
			else
				!!behavior.make;
				behavior.set_internal_name ("");
				behavior.set_context (context);
				current_state.add (context, behavior);
			end;
			behavior_editor.set_edited_function (behavior);
			behavior_editor.set_edited_context (context);
			behavior_editor.set_current_state (current_state);
		end;

	
feature 

	show is
		do
			form_show;
			behavior_editor.hide_stones
		end;

	apply is do end;

end
