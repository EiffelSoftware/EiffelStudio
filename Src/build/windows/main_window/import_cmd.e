
class IMPORT_CMD 

inherit

	STORAGE_INFO
		export
			{NONE} all
		end;
	CONTEXT_SHARED
		export
			{NONE} all
		end;
	WINDOWS
		export
			{NONE} all
		end;
	UNDOABLE;
	ERROR_POPUPER;

feature {NONE}

	retrieved_contexts: LINKED_LIST [CONTEXT];
	retrieved_commands: LINKED_LIST [LINKED_LIST [USER_CMD]];
	retrieved_groups: LINKED_LIST [GROUP];
	retrieved_translations: LINKED_LIST [TRANSLATION];

	
feature 

	n_ame: STRING is "Import";

	
feature {NONE}

	work (argument: IMPORT_WINDOW) is
		do
			for_import.set_value (True);
			argument.popdown;
			import_application (argument);
		end;

feature 

	undo is
		do
		end;

	redo is
		do
		end;

	
feature {NONE}

	failed: BOOLEAN is do end;

	
feature 

	history: HISTORY_WND is
		once
			Result := history_window;
		end;

	
feature {NONE}

	rescued: BOOLEAN;

	import_application (import_window: IMPORT_WINDOW) is
		local
			import_directory: STRING;
			msg: STRING;
			import_path_name: FILE_NAME;
			mp: MOUSE_PTR;
		do
			if not rescued then
				clear_uneeded;
				import_directory := clone (import_window.file_selec.selected_file);
				if import_directory /= Void and then not import_directory.empty then
					!!import_path_name.make (import_directory.count);
					import_path_name.from_string (import_directory);
					if import_path_name.exists then
						import_from_file (import_window)
					else
						!!msg.make (0);
						msg.append ("Directory ");
						msg.append (import_directory);
						msg.append ("does not exist");
						error_box.popup (Current, msg)
					end;
				else
					!!msg.make (0);
					msg.append ("No Directory chosen!!");
					error_box.popup (Current, msg)
				end;
			else
				rescued := False;
				!!msg.make (0);
				msg.append ("Cannot retrieve from directory ");
				msg.append (import_directory);
				!!mp;
				mp.restore;
				error_box.popup (Current, msg);
			end
		rescue
			mp.restore;
			rescued := True;
			retry
		end;

	import_from_file (import_window: IMPORT_WINDOW) is
		local
			mp: MOUSE_PTR;
			fn: STRING;
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
			import_directory: STRING
		do
			!!mp;
			mp.set_watch_shape;
			import_directory := clone (import_window.file_selec.selected_file);
			import_directory.append ("/Storage");
			if import_window.groups.state then
				fn := clone (import_directory);
				fn.append ("/groups");
				!!group_storer;
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
				fn := clone (import_directory);
				fn.append ("/interface");
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
					window_list.finish;
					window_list.put_right (a_context);
					retrieved_contexts.forth
				end;
				tree.enable_drawing;
				if not window_list.empty then
					tree.display (window_list.first)
				end;
			end;
			if import_window.commands.state then
				fn := clone (import_directory);
				fn.append ("/commands");
				!!command_storer;
				command_storer.retrieve (fn);
				retrieved_commands := command_storer.retrieved_data;
				command_catalog.merge (retrieved_commands);
			end;
			if import_window.translations.state then
				fn := clone (import_directory);
				fn.append ("/translations");
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
				fn := clone (import_directory);
				fn.append ("/states");
				!!state_storer;
				state_storer.retrieve (fn);
				fn := clone (import_directory);
				fn.append ("/application");
				!!application_storer;
				application_storer.retrieve (fn);

				application_storer.rebuild_graph;
				if app_editor.realized and then
					app_editor.shown
				then
					app_editor.draw_figures;
				end;
				app_editor.display_states;
				app_editor.display_transitions;
			end;
			retrieved_contexts := Void;
			retrieved_commands := Void;
			retrieved_groups := Void;
			retrieved_translations := Void;
			clear_uneeded;
			mp.restore
		end;

end
