

class STORER 

inherit

	STORAGE_INFO
		export
			{NONE} all
		end;

	WINDOWS
		export
			{NONE} all
		end;

	CONTEXT_SHARED
		export
			{NONE} all
		end;

	GROUP_SHARED
		export
			{NONE} all
		end;

	NAMER_SHARED
		export
			{NONE} all
		end;

	APP_SHARED
		export
			{NONE} all
		end;

	TRANSL_SHARED
		export
			{NONE} all
		end;


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
				fn := clone (file_name);
				fn.append ("/interface");
			context_storer.store (fn);
				fn := clone (file_name);
				fn.append ("/groups");
			group_storer.store (fn);
				fn := clone (file_name);
				fn.append ("/translations");
			translation_storer.store (fn);
				fn := clone (file_name);
				fn.append ("/commands");
			command_storer.store (fn);
				fn := clone (file_name);
				fn.append ("/states");
			state_storer.store (fn);
				fn := clone (file_name);
				fn.append ("/application");
			application_storer.store (fn);
				fn := clone (file_name);
				fn.append ("/namer");
			namer_storer.store (fn);
		end;

	retrieve (file_name: STRING) is
		local
			fn: STRING;	
			c: STATE_CIRCLE;
			a_context: CONTEXT;
		do
			for_save.set_value (True);
			clear_all;
				fn := clone (file_name);
				fn.append ("/groups");
			group_storer.retrieve (fn);
			group_list.wipe_out;
			group_list.merge_right (group_storer.retrieved_data);
			context_catalog.update_groups;
				fn := clone (file_name);
				fn.append ("/interface");
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
				window_list.finish;
				window_list.put_right (a_context);
				contexts.forth
			end;
			tree.enable_drawing;
				fn := clone (file_name);
				fn.append ("/translations");
			translation_storer.retrieve (fn);
			translation_list.merge_right (translation_storer.retrieved_data);
				fn := clone (file_name);
				fn.append ("/commands");
			command_storer.retrieve (fn);
			commands := command_storer.retrieved_data;
			command_catalog.merge (commands);
			--	fn := clone (file_name);
			--	fn.append ("/behaviors");
			--behavior_storer.retrieve (fn);
			--behaviors := behavior_storer.retrieved_data;
				fn := clone (file_name);
				fn.append ("/states");
			state_storer.retrieve (fn);
			states := state_storer.retrieved_data;
				fn := clone (file_name);
				fn.append ("/application");
			application_storer.retrieve (fn);
				fn := clone (file_name);
				fn.append ("/namer");
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
			for_save.set_value (False);
		end;

	display_retrieved_windows is
		do
			if not window_list.empty then
				tree.display (window_list.first)
			end;
			from
				window_list.start;
			until
				window_list.after
			loop
				window_list.item.realize;
				window_list.forth
			end;
		end;

end
