
class IMPORT_CMD 

inherit

	SHARED_STORAGE_INFO;
	SHARED_CONTEXT;
	COMMAND;
	ERROR_POPUPER;
	CONSTANTS;
	WINDOWS

feature {NONE}

	retrieved_contexts: LINKED_LIST [CONTEXT];
	retrieved_commands: LINKED_LIST [LINKED_LIST [USER_CMD]];
	retrieved_groups: LINKED_LIST [GROUP];
	retrieved_translations: LINKED_LIST [TRANSLATION];

	execute (argument: IMPORT_WINDOW) is
		do
			for_import.set_item (True);
			argument.popdown;
			import_application (argument);
				-- Do no record
		end;

feature {NONE}

	rescued: BOOLEAN;

	import_application (import_window: IMPORT_WINDOW) is
		local
			import_directory: STRING;
			import_path: PLAIN_TEXT_FILE;
			mp: MOUSE_PTR;
		do
			if not rescued then
				clear_shared_storage_info;
				import_directory := clone (import_window.file_selec.selected_file);
				if import_directory /= Void and then not 
					import_directory.empty 
				then
					!! import_path.make (import_directory);
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
				error_box.popup (Current, Messages.cannot_ret_dir_er,
							import_directory);
			end
		rescue
			!! mp;
			mp.restore;
			rescued := True;
			retry
		end;

	import_from_file (import_window: IMPORT_WINDOW) is
		local
			mp: MOUSE_PTR;
			dir_name: DIRECTORY_NAME;
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
			import_directory.extend (Environment.Buildgen_name);
			import_directory.extend (Environment.Storage_name);
			!! dir_name.make_from_string (import_directory);
			if import_window.groups.state then
				!! group_storer;
				group_storer.retrieve (dir_name);
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
				!!context_storer;
				context_storer.retrieve (dir_name);
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
				!! command_storer;
				command_storer.retrieve (dir_name);
				retrieved_commands := command_storer.retrieved_data;
				command_catalog.merge (retrieved_commands);
			end;
			if import_window.translations.state then
				!!translation_storer;
				translation_storer.retrieve (dir_name);
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
				!!state_storer;
				state_storer.retrieve (dir_name);
				!!application_storer;
				application_storer.retrieve (dir_name);

				application_storer.rebuild_graph;
				app_editor.update_display;
			end;
			retrieved_contexts := Void;
			retrieved_commands := Void;
			retrieved_groups := Void;
			retrieved_translations := Void;
			clear_shared_storage_info;
			mp.restore
		end;

	popuper_parent: COMPOSITE is
		do
			Result := main_panel.base
		end

end
