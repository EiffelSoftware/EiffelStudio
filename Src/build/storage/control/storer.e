

class STORER 

inherit

	MEMORY;
	CONSTANTS;
	SHARED_STORAGE_INFO;
	WINDOWS;
	SHARED_CONTEXT;
	SHARED_NAMER;
	SHARED_APPLICATION;
	SHARED_TRANSLATIONS

creation

	make

	
feature 

	make is
		do
			!!context_storer;
			!!command_storer;
			!!state_storer;
			!!namer_storer;
			!!application_storer;
			!!group_storer;
			!!translation_storer;
		end;

-- **************
-- Retrieved data
-- **************

	contexts: LINKED_LIST [CONTEXT];

	commands: LINKED_LIST [LINKED_LIST [USER_CMD]];

	behaviors: LINKED_LIST [BEHAVIOR];

	
feature {NONE}

	states: LINKED_LIST [STATE];

-- *******
-- Storers
-- *******

	context_storer: CONTEXT_STORER;

	command_storer: COMMAND_STORER;

	state_storer: S_STORER;

	application_storer: APPLICATION_STORER;

	group_storer: GROUP_STORER;

	translation_storer: TRANSL_STORER;

	namer_storer: NAMER_STORER;

	
feature 

	store (file_name: STRING) is
		local
			fn: STRING;	
		do
			file_name.extend (Environment.directory_separator);

				fn := clone (file_name);
				fn.append (Environment.interface_file_name);
			context_storer.store (fn);
				fn := clone (file_name);
				fn.append (Environment.groups_file_name);
			group_storer.store (fn);
				fn := clone (file_name);
				fn.append (Environment.translations_file_name);
			translation_storer.store (fn);
				fn := clone (file_name);
				fn.append (Environment.commands_file_name);
			command_storer.store (fn);
				fn := clone (file_name);
				fn.append (Environment.states_file_name);
			state_storer.store (fn);
				fn := clone (file_name);
				fn.append (Environment.application_file_name);
			application_storer.store (fn);
				fn := clone (file_name);
				fn.append (Environment.namer_file_name);
			namer_storer.store (fn);
		end;

	retrieve (file_name: STRING) is
		local
			fn: STRING;	
			c: STATE_CIRCLE;
			a_context: CONTEXT;
			old_gc_status: BOOLEAN;
		do
			old_gc_status := collecting;
			collection_off;
			for_save.set_item (True);
			clear_all;
			file_name.extend (Environment.directory_separator);

				fn := clone (file_name);
				fn.append (Environment.groups_file_name);
			group_storer.retrieve (fn);
			Shared_group_list.wipe_out;
			Shared_group_list.merge_right (group_storer.retrieved_data);
			context_catalog.update_groups;
				fn := clone (file_name);
				fn.append (Environment.interface_file_name);
			context_storer.retrieve (fn);
			contexts := context_storer.retrieved_data;
			from
				contexts.start;
				tree.disable_drawing;
			until
				contexts.after
			loop
				a_context := contexts.item;
				a_context.retrieve_oui_widget;
				contexts.forth
			end;
			tree.enable_drawing;
				fn := clone (file_name);
				fn.append (Environment.translations_file_name);
			translation_storer.retrieve (fn);
			Shared_translation_list.merge_right (translation_storer.retrieved_data);
				fn := clone (file_name);
				fn.append (Environment.commands_file_name);
			command_storer.retrieve (fn);
			commands := command_storer.retrieved_data;
			command_catalog.merge (commands);
				fn := clone (file_name);
				fn.append (Environment.states_file_name);
			state_storer.retrieve (fn);
			states := state_storer.retrieved_data;
				fn := clone (file_name);
				fn.append (Environment.application_file_name);
			application_storer.retrieve (fn);
				fn := clone (file_name);
				fn.append (Environment.namer_file_name);
			namer_storer.retrieve (fn);
			application_storer.rebuild_graph;
			if (application_storer.has_initial_circle) then
				c := circle_table.item (application_storer.initial_circle);
				app_editor.set_initial_state_circle (c);
				c.set_double_thickness;
			end;
			app_editor.display_states;
			if app_editor.realized and app_editor.shown then
				app_editor.set_default_selected;
			end;
			clear_uneeded;
			for_save.set_item (False);
			if old_gc_status then
				collection_on;
			end;
		end;

	display_retrieved_windows is
		local
			window_c: WINDOW_C
		do
			if not Shared_window_list.empty then
				tree.display (Shared_window_list.first)
			end;
			from
				Shared_window_list.start;
			until
				Shared_window_list.after
			loop
				window_c := Shared_window_list.item;
				window_c.realize;
				if not window_c.is_perm_window then
					window_c.show
				end;
				Shared_window_list.forth
			end;
		end;

end
