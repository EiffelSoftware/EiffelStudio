
class IMPORT_CMD 

inherit

	SHARED_STORAGE_INFO;
	SHARED_CONTEXT;
	EB_UNDOABLE;
	ERROR_POPUPER;
	CONSTANTS

feature {NONE}

	retrieved_contexts: LINKED_LIST [CONTEXT];
	retrieved_commands: LINKED_LIST [LINKED_LIST [USER_CMD]];
	retrieved_groups: LINKED_LIST [GROUP];
	retrieved_translations: LINKED_LIST [TRANSLATION];

	work (argument: IMPORT_WINDOW) is
		do
			for_import.set_item (True);
			argument.popdown;
			import_application (argument);
		end;

feature 

	name: STRING is 
		do
			Result := Command_names.import_cmd_name
		end;

	undo is
		do
		end;

	redo is
		do
		end;

	
feature {NONE}

	failed: BOOLEAN is do end;
	
feature {NONE}

	rescued: BOOLEAN;

	import_application (import_window: IMPORT_WINDOW) is
		local
			import_directory: STRING;
			import_path: PLAIN_TEXT_FILE;
			mp: MOUSE_PTR;
		do
			if not rescued then
				clear_uneeded;
				import_directory := clone (import_window.file_selec.selected_file);
				if import_directory /= Void and then not 
					import_directory.empty 
				then
					!!import_path.make (import_directory);
					if import_path.exists then
						import_from_file (import_window)
					else
						error_box.popup (Current, 	
							Messages.dir_not_exist_er, 
							import_directory)
					end;
				else
					error_box.popup (Current, Messages.dir_not_chosen_er, Void)
				end;
			else
				rescued := False;
				!!mp;
				mp.restore;
				error_box.popup (Current, Messages.cannot_ret_dir_er,
							import_directory);
			end
		rescue
			mp.restore;
			rescued := True;
			retry
		end;

	import_from_file (import_window: IMPORT_WINDOW) is
		local
			mp: MOUSE_PTR;
			fn: FILE_NAME;
			new_id: INTEGER;
			old_id: INTEGER;
			a_context: CONTEXT;
			group_table: INT_H_TABLE [INTEGER];
			context_storer: CONTEXT_STORER;
			command_storer: COMMAND_STORER;
			state_storer: S_STORER;
			application_storer: APPLICATION_STORER;
			group_storer: GROUP_STORER;
			translation_storer: TRANSL_STORER;
			import_directory: DIRECTORY_NAME
		do
			!!mp;
			mp.set_watch_shape;
			!! import_directory.make_from_string (import_window.file_selec.selected_file);
			import_directory.extend (Environment.storage_name);
			if import_window.groups.state then
				!! fn.make_from_string (import_directory);
				fn.set_file_name (Environment.groups_file_name);
				!! group_storer;
				group_storer.retrieve (fn);
				retrieved_groups := group_storer.retrieved_data;
				!!group_table.make (retrieved_groups.count);
				from
					retrieved_groups.start
				until
					retrieved_groups.after
				loop
						-- check if already in list
						-- rename if conflict
					old_id := retrieved_groups.item.identifier;
					new_id := retrieved_groups.item.new_id_after_import;
					group_table.put (new_id, old_id);
					retrieved_groups.forth;
				end;
				from
					retrieved_groups.start
				until
					retrieved_groups.after
				loop
					retrieved_groups.item.update_subgroup_id (group_table);
					retrieved_groups.forth;
				end;
				context_catalog.update_groups;
			end;
			if import_window.interface.state then
				!! fn.make_from_string (import_directory);
				fn.set_file_name (Environment.interface_file_name);
				!!context_storer;
				context_storer.retrieve (fn);
				retrieved_contexts := context_storer.retrieved_data;
				from
					retrieved_contexts.start;
					tree.disable_drawing
				until
					retrieved_contexts.after
				loop
					a_context := retrieved_contexts.item;
						-- group table : association old id new id for groups
					a_context.import_oui_widget (group_table);
					a_context.realize;
					retrieved_contexts.forth
				end;
				tree.enable_drawing;
				if not Shared_window_list.empty then
					tree.display (Shared_window_list.first)
				end;
			end;
			if import_window.commands.state then
				!! fn.make_from_string (import_directory);
				fn.set_file_name (Environment.commands_file_name);
				!! command_storer;
				command_storer.retrieve (fn);
				retrieved_commands := command_storer.retrieved_data;
				command_catalog.merge (retrieved_commands);
			end;
			if import_window.translations.state then
				!! fn.make_from_string (import_directory);
				fn.set_file_name (Environment.translations_file_name);
				!!translation_storer;
				translation_storer.retrieve (fn);
				retrieved_translations := translation_storer.retrieved_data;
				from
					retrieved_translations.start
				until
					retrieved_translations.after
				loop
					retrieved_translations.item.generate_internal_name;
					retrieved_translations.forth
				end;
			end;
			if import_window.entire_application.state then
				!! fn.make_from_string (import_directory);
				fn.set_file_name (Environment.states_file_name);
				!!state_storer;
				state_storer.retrieve (fn);
				!! fn.make_from_string (import_directory);
				fn.set_file_name (Environment.application_file_name);
				!!application_storer;
				application_storer.retrieve (fn);

				application_storer.rebuild_graph;
				app_editor.update_display;
			end;
			retrieved_contexts := Void;
			retrieved_commands := Void;
			retrieved_groups := Void;
			retrieved_translations := Void;
			clear_uneeded;
			mp.restore
		end;

end
