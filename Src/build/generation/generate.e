

class GENERATE 

inherit

	CONTEXT_SHARED
		export
			{NONE} all
		end;
	GROUP_SHARED
		export
			{NONE} all
		end;
	APP_SHARED
		export
			{NONE} all
		end;
	COMMAND;
	CALLBACK_GENE
		export
			{NONE} all
		end;
	UNIX_ENV
		export
			{NONE} all
		end;
	WINDOWS
		export
			{NONE} all
		end;
	ERROR_POPUPER

feature {NONE}

	Windows_directory: STRING is
		once
			Result := Generated_directory;
			Result.append ("/Windows");
		end;

	States_directory: STRING is
		once
			Result := Generated_directory;
			Result.append ("/State");
		end;

	Context_directory: STRING is 
		once
			Result := Generated_directory;
			Result.append ("/Widgets");
		end;

	Group_directory: STRING is 
		once
			Result := Generated_directory;
			Result.append ("/Groups");
		end;

	Command_directory: STRING is
		once
			Result := Generated_directory;
			Result.append ("/Commands");
		end;

	Application_directory: STRING is
		once
			Result := Generated_directory;
			Result.append ("/Application");
		end;

feature 

	rescued: BOOLEAN;

	execute (argument: ANY) is
			-- Generate command
		local
			msg: STRING;
			mp: MOUSE_PTR
		do
			if not rescued then
				!!mp;
				mp.set_watch_shape;
				generate_files;	
				mp.restore
			else
				rescued := False;
				!!msg.make (0);
				msg.append ("Cannot generate files to directory%N");
				msg.append (Generated_directory);
				error_box.popup (Current, msg)
			end
		rescue
			mp.restore;
			rescued := True;
			retry
		end;

	generate_files is
		local
			old_pos: INTEGER;
			temp: STRING;
			doc: EB_DOCUMENT;
			cmd: USER_CMD;
			group: GROUP;
			user_cmds: LINKED_LIST [LINKED_LIST [USER_CMD]];
			cmd_list: LINKED_LIST [USER_CMD];
			current_position: INTEGER;
		do
				-- ==========================
				-- Widget classes generation.
				-- ==========================
			callback_generator.update;
			from
				old_pos := window_list.index;
				window_list.start
			until
				window_list.after
			loop
				current_position := window_list.index;
				!!doc;
				doc.set_directory_name (Context_directory);
				doc.set_document_name (window_list.item.entity_name);
					temp := window_list.item.eiffel_text;
				doc.update (temp);
				doc := Void;
				window_list.go_i_th (current_position);
				window_list.forth
			end;
			window_list.go_i_th (old_pos);
			callback_generator.clear_all;

				-- ===========================
				-- Group classes generation.
				-- ===========================
			from
				old_pos := group_list.index;
				group_list.start
			until
				group_list.after
			loop
				group := group_list.item;
				if not (group.eiffel_text = Void) then
					current_position := group_list.index;
					!!doc;
					doc.set_directory_name (Group_directory);
					doc.set_document_name (group.entity_name);
					temp := group.eiffel_text;
					doc.update (temp);
					doc := Void;
					group_list.go_i_th (current_position);
				end;
				group_list.forth;
			end;
			group_list.go_i_th (old_pos);
				
				-- ===========================
				-- Command classes generation.
				-- ===========================
			from
				user_cmds := command_catalog.user_commands;
				user_cmds.start
			until
				user_cmds.after
			loop
				cmd_list := user_cmds.item;
				from
					cmd_list.start
				until
					cmd_list.after
				loop
					cmd := cmd_list.item;
					!!doc;
					doc.set_directory_name (Command_directory);
					doc.set_document_name (cmd.eiffel_type);
					temp := clone (cmd.eiffel_text);
					if temp.item (1) /= '-' and cmd.label /= Void 
					  and then not cmd.label.empty then
						temp.prepend ("%N");
						temp.prepend (cmd.label);
						temp.prepend ("-- ");
					end;
					doc.update (temp);
					doc := Void;
					cmd_list.forth
				end;
				user_cmds.forth;
			end;
				
				-- =========================
				-- Windows class generation.
				-- =========================
			!!doc;
			doc.set_directory_name (Windows_directory);
			doc.set_document_name ("windows");
			temp := windows_text;
			doc.update (temp);
			doc := Void;

				-- =========================
				-- States class generation.
				-- =========================
			!!doc;
			doc.set_directory_name (States_directory);
			doc.set_document_name ("states");
			temp := states_text;
			doc.update (temp);
			doc := Void;

				-- ============================
				-- Application class generation
				-- ============================
			!!doc;
			doc.set_directory_name (Application_directory);
			doc.set_document_name ("application");
			temp := graph.eiffel_text;
			if temp.item (temp.count) /= '%N' then
				temp.append ("%N");
			end;
			doc.update (temp);
			doc := Void;

				-- ===============================
				-- Shared control class generation
				-- ===============================

			!!doc;
			doc.set_directory_name (Application_directory);
			doc.set_document_name ("shared_control");
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
				state_list := graph.states;
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
			old_pos: INTEGER;
			temp_w_context: TEMP_WIND_C;
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
				old_pos := window_list.index;
				window_list.start;
			until
				window_list.after
			loop
				window_context ?= window_list.item;
				if window_context = Void then
					Result.append ("%T%T%T");
					Result.append (window_list.item.entity_name);
					Result.append (".realize;%N");
				elseif  not window_context.start_hidden then
					Result.append ("%T%T%T");
					Result.append (window_list.item.entity_name);
					Result.append (".realize;%N");
				end;
				window_list.forth;
			end;
			window_list.go_i_th (old_pos);
			Result.append ("%T%T%Titerate%N%T%Tend;%N%N");
			Result.append ("%TNothing: ANY is do end;%N%N");
			from
				old_pos := window_list.index;
				window_list.start;
			until
				window_list.after
			loop
				Result.append ("%T");
				Result.append (window_list.item.entity_name);
				Result.append (": ");
					!!class_name.make (10);
					class_name := window_list.item.entity_name;
					class_name := clone (class_name);
					class_name.to_upper;
				Result.append (class_name);
				Result.append (" is%N%T%Tonce%N%T%T%T!!Result.make (%"");
				Result.append (window_list.item.entity_name);
				temp_w_context ?= window_list.item;
				Result.append ("%", "); 
				if temp_w_context = Void then
					Result.append ("application_screen"); 
				else
					Result.append (temp_w_context.popup_parent.entity_name);
				end;
				Result.append (");%N%T%Tend;%N%N"); 
				window_list.forth;
			end;
			window_list.go_i_th (old_pos);
			Result.append ("end%N")
		end;	

	shared_control_text: STRING is
		do
			!!Result.make (0);
			Result.append ("class SHARED_CONTROL%N%Nfeature%N%N");
			Result.append ("%Tcontrol: CONTROL is%N%T%Tonce%N%T%T%T!!Result.make (");
			Result.append_integer (graph.count);
			Result.append (")%N%T%Tend%N%Nend%N");
		end;

end
