
class BEHAVIOR_FORM 

inherit

	EDITOR_FORM
		rename
			show as form_show
		end;
	EDITOR_FORM
		redefine
			show
		select
			show
		end;
	WINDOWS

creation

	make
    
feature -- Interface

	make_visible (a_parent: COMPOSITE) is
		do
			initialize (Widget_names.behavior_form_name, a_parent);
			!!event_catalog.make (Widget_names.event_catalog_name, Current);
			!!behavior_editor.make (Widget_names.behaviour_editor_name, Current);

			set_fraction_base(5);
			attach_top (event_catalog, 0);
			attach_left (event_catalog, 0);
			attach_right (event_catalog, 0);
			attach_left (behavior_editor.form, 0);
			attach_right (behavior_editor.form, 0);
			attach_bottom (behavior_editor.form, 0);
			attach_bottom_position (event_catalog, 2);
			attach_top_position (behavior_editor.form, 2);
			show_current
		end;

	update_translation_page is
		do
			if event_catalog.translation_page_shown then
				event_catalog.update_translations
			end;
		end;

	reset_editor is
			-- Reset the edited_function of Current. 
		do
			behavior_editor.clear
		end;

	unregister_holes is
		do
			if is_initialized then
				behavior_editor.unregister_holes
			end;
		end;

feature {NONE}

	event_catalog: EVENT_CATALOG;

	behavior_editor: BEHAVIOR_EDITOR;

	form_number: INTEGER is
		do
			Result := Context_const.behavior_form_nbr
		end;

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
			behavior_editor.set_context_editor (editor);
			behavior_editor.set_current_state (current_state);
		end;

	show is
		do
			form_show;
			behavior_editor.hide_stones
		end;

	apply is 
		do 
			-- Do nothing
		end;

end
