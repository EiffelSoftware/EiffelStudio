

class STORER 

inherit

	MEMORY;
	CONSTANTS;
	SHARED_STORAGE_INFO;
	WINDOWS;
	SHARED_CONTEXT;
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

	store (dir_name: STRING) is
			-- Store eiffelbuild application to
			-- directory `dir_name'.
		require
			valid_dir_name: dir_name /= Void
		do
				-- Save storer temporarily
			context_storer.tmp_store (dir_name);
			group_storer.tmp_store (dir_name);
			translation_storer.tmp_store (dir_name);
			command_storer.tmp_store (dir_name);
			state_storer.tmp_store (dir_name);
			application_storer.tmp_store (dir_name);
			namer_storer.tmp_store (dir_name);

				-- Move tmp file to saved file name
			context_storer.save_stored_information (dir_name);
			group_storer.save_stored_information (dir_name);
			translation_storer.save_stored_information (dir_name);
			command_storer.save_stored_information (dir_name);
			state_storer.save_stored_information (dir_name);
			application_storer.save_stored_information (dir_name);
			namer_storer.save_stored_information (dir_name);
		end;

	retrieve (dir_name: STRING) is
		require
			valid_dir_name: dir_name /= Void
		local
			c: STATE_CIRCLE;
			a_context: CONTEXT;
			old_gc_status: BOOLEAN;
		do
			old_gc_status := collecting;
			collection_off;
			for_save.set_item (True);
			clear_all;
			group_storer.retrieve (dir_name);
			Shared_group_list.wipe_out;
			Shared_group_list.merge_right (group_storer.retrieved_data);
			context_catalog.update_groups;
			context_storer.retrieve (dir_name);
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
			translation_storer.retrieve (dir_name);
			Shared_translation_list.merge_right (translation_storer.retrieved_data);
			command_storer.retrieve (dir_name);
			commands := command_storer.retrieved_data;
			command_catalog.merge (commands);
			state_storer.retrieve (dir_name);
			states := state_storer.retrieved_data;
			application_storer.retrieve (dir_name);
			namer_storer.retrieve (dir_name);
			application_storer.rebuild_graph;
			if (application_storer.has_initial_circle) then
				c := circle_table.item (application_storer.initial_circle);
				app_editor.set_initial_state_circle (c);
				c.set_double_thickness;
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
