

class GENERATE 

inherit

	SHARED_CONTEXT;
	SHARED_APPLICATION;
	COMMAND;
	CALLBACK_GENE;
	CONSTANTS;
	WINDOWS;
	ERROR_POPUPER

feature 

	rescued: BOOLEAN;

	execute (argument: ANY) is
			-- Generate command
		local
			mp: MOUSE_PTR
		do
			if not rescued then
				!!mp;
				mp.set_watch_shape;
				generate_files;	
				mp.restore
			else
				rescued := False;
				error_box.popup (Current, 
					Messages.generate_er, Environment.classes_directory)
			end
		rescue
			mp.restore;
			rescued := True;
			retry
		end;

	generate_files is
		local
			current_cursor, old_cursor: CURSOR;
			temp: STRING;
			doc: EB_DOCUMENT;
			cmd: USER_CMD;
			group: GROUP;
			user_cmds: LINKED_LIST [LINKED_LIST [USER_CMD]];
			cmd_list: LINKED_LIST [USER_CMD];
		do
				-- ==========================
				-- Widget classes generation.
				-- ==========================
			callback_generator.update;
			from
				old_cursor := Shared_window_list.cursor;
				Shared_window_list.start
			until
				Shared_window_list.after
			loop
				current_cursor := Shared_window_list.cursor;
				!!doc;
				doc.set_directory_name (Environment.context_directory);
				doc.set_document_name (Shared_window_list.item.entity_name);
					temp := Shared_window_list.item.eiffel_text;
				doc.update (temp);
				doc := Void;
				Shared_window_list.go_to (current_cursor);
				Shared_window_list.forth
			end;
			Shared_window_list.go_to (old_cursor);
			callback_generator.clear_all;

				-- ===========================
				-- Group classes generation.
				-- ===========================
			from
				old_cursor := Shared_group_list.cursor;
				Shared_group_list.start
			until
				Shared_group_list.after
			loop
				group := Shared_group_list.item;
				if group.eiffel_text /= Void then
					current_cursor := Shared_group_list.cursor;
					!!doc;
					doc.set_directory_name (Environment.groups_directory);
					doc.set_document_name (group.entity_name);
					temp := group.eiffel_text;
					doc.update (temp);
					doc := Void;
					Shared_group_list.go_to (current_cursor);
				end;
				Shared_group_list.forth;
			end;
			Shared_group_list.go_to (old_cursor);
				
				-- ===========================
				-- Command classes generation.
				-- ===========================
				--now done from command editor
				-- every time the command is changed
			--from
				--user_cmds := command_catalog.user_commands;
			--	user_cmds.start
			--until
			--	user_cmds.after
			--loop
			--	cmd_list := user_cmds.item;
			--	from
			--		cmd_list.start
			--	until
			--		cmd_list.after
			--	loop
			----		cmd := cmd_list.item;
			--		!!doc;
			--		doc.set_directory_name (Command_directory);
			--		doc.set_document_name (cmd.eiffel_type);
			--		temp := clone (cmd.eiffel_text);
			--		if temp.item (1) /= '-' and cmd.label /= Void 
			--		  and then not cmd.label.empty then
			----			temp.prepend ("%N");
			--			temp.prepend (cmd.label);
			--			temp.prepend ("-- ");
			--		end;
			--		doc.update (temp);
			--		doc := Void;
			--		cmd_list.forth
			--	end;
			--	user_cmds.forth;
			--end;
				
				-- =========================
				-- Windows class generation.
				-- =========================
			!!doc;
			doc.set_directory_name (Environment.windows_directory);
			doc.set_document_name (Environment.windows_file_name);
			temp := windows_text;
			doc.update (temp);
			doc := Void;

				-- =========================
				-- States class generation.
				-- =========================
			!!doc;
			doc.set_directory_name (Environment.state_directory);
			doc.set_document_name (Environment.states_file_name);
			temp := states_text;
			doc.update (temp);
			doc := Void;

				-- ============================
				-- Application class generation
				-- ============================
			!!doc;
			doc.set_directory_name (Environment.application_directory);
			doc.set_document_name (Environment.application_file_name);
			temp := Shared_app_graph.eiffel_text;
			if temp.item (temp.count) /= '%N' then
				temp.append ("%N");
			end;
			doc.update (temp);
			doc := Void;

				-- ===============================
				-- Shared control class generation
				-- ===============================

			!!doc;
			doc.set_directory_name (Environment.application_directory);
			doc.set_document_name (Environment.shared_control_file_name);
			temp := shared_control_text;
			doc.update (temp);
			doc := Void;
		end;

	
feature {NONE}

	states_text: STRING is
		local
			state_list: LINKED_LIST [STATE];
			counter: INTEGER;
		do
			!!Result.make (0);
			Result.append ("class STATES%N%Nfeature%N");
			Result.append ("%N%TExit_from_application: INTEGER is -2;%N");
			Result.append ("%N%TReturn_to_previous: INTEGER is -1;%N");
			from
				state_list := Shared_app_graph.states;
				state_list.start;
				counter := 1;
			until
				state_list.after
			loop
				Result.append ("%N%T");
				Result.append (state_list.item.label);
				Result.append (": INTEGER is ");
				Result.append (counter.out);
				Result.append (";");
				if not (state_list.item.visual_name = Void) then
					Result.append ("%T-- ");
					Result.append (state_list.item.visual_name);
				end;
				Result.append ("%N");		
				state_list.forth;
				counter := counter + 1;
			end;
			Result.append ("%Nend%N");
		end;

	windows_text: STRING is
		local
			class_name: STRING;
			old_cursor: CURSOR;
			window_context: WINDOW_C;
		do
			!!Result.make (3000);	
			Result.append ("class WINDOWS%N%N");
			Result.append ("inherit%N%N%TGRAPHICS%N%T%Tredefine%N%T%T%Tinit_toolkit%N%T%Tend%N%N");
			Result.append ("feature%N%N");	
			Result.append ("%Tapplication_screen: SCREEN is%N%T%Tonce%N%T%T%T!!Result.make (%"%")%N%T%Tend;%N%N");
			Result.append ("%Tinit_toolkit: MOTIF is%N%T%Tonce%N%T%T%T!!Result.make (%"%")%N%T%Tend;%N%N");
			Result.append ("%Tinit_windowing is%N%T%Tdo%N%
					%%T%T%Tif (init_toolkit = Void) then end;%N%
					%%T%T%Tif (toolkit = Void) then end;%N");
			from
				old_cursor := Shared_window_list.cursor;
				Shared_window_list.start;
			until
				Shared_window_list.after
			loop
				window_context := Shared_window_list.item;
				if not window_context.start_hidden then
					Result.append ("%T%T%T");
					Result.append (window_context.entity_name);
					Result.append (".realize;%N");
					if not window_context.is_perm_window then
						Result.append ("%T%T%T");
						Result.append (window_context.entity_name);
						Result.append (".popup;%N");
					end;
				elseif not window_context.is_perm_window then
					Result.append ("%T%T%T");
					Result.append (window_context.entity_name);
					Result.append (".realize;%N");
				end;
				Shared_window_list.forth;
			end;
			Shared_window_list.go_to (old_cursor);
			Result.append ("%T%T%Titerate%N%T%Tend;%N%N");
			from
				old_cursor := Shared_window_list.cursor;
				Shared_window_list.start;
			until
				Shared_window_list.after
			loop
				window_context := Shared_window_list.item;
				Result.append ("%T");
				Result.append (window_context.entity_name);
				Result.append (": ");
					!!class_name.make (10);
					class_name := window_context.entity_name;
					class_name := clone (class_name);
					class_name.to_upper;
				Result.append (class_name);
				Result.append (" is%N%T%Tonce%N%T%T%T!!Result.make (%"");
				Result.append (window_context.entity_name);
				Result.append ("%", "); 
				if window_context.is_perm_window then
					Result.append ("application_screen"); 
				else
					Result.append (window_context.parent.entity_name);
				end;
				Result.append (");%N%T%Tend;%N%N"); 
				Shared_window_list.forth;
			end;
			Shared_window_list.go_to (old_cursor);
			Result.append ("end%N")
		end;	

	shared_control_text: STRING is
		do
			!!Result.make (0);
			Result.append ("class SHARED_CONTROL%N%Nfeature%N%N");
			Result.append ("%Tcontrol: CONTROL is%N%T%Tonce%N%T%T%T!!Result.make (");
			Result.append_integer (Shared_app_graph.count);
			Result.append (")%N%T%Tend%N%Nend%N");
		end;

end
