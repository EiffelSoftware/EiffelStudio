
-- General notion of user command
-- i.e. editable command.

class USER_CMD 

inherit

	CMD
		redefine
			set_editor, data,
			set_eiffel_text
		end;
	NAMABLE;
	ERROR_POPUPER;

creation

	make, session_init, storage_init

feature -- Creation

	make is
			-- Initialize current user
			-- command.
		do
			int_generator.next;
			identifier := int_generator.value;
			!!arguments.make;
			!!labels.make;
		end;

	symbol: PIXMAP is
		do
			Result := Pixmaps.user_command_pixmap
		end;

	help_file_name: STRING is
		do
			Result := Help_const.user_command_help_fn
		end;

	session_init is
			-- Intialize current user command
			-- for a session.
		do
			!!arguments.make;
			!!labels.make;
		end;

	storage_init (a: like arguments; l: like labels;
			s: STRING; p: CMD; in,vn: STRING) is
			-- Intialize current user command
			-- for storage.
		do
			arguments := a;
			labels := l;
			eiffel_text := s;
			parent_type := p;
			set_internal_name (in);
			visual_name := clone (vn)	
		end;

feature -- Stone

	data: USER_CMD is
		do
			Result := Current
		end;

	identifier: INTEGER;
			-- Unique identifier for storage
			-- and retrieval

	eiffel_type: STRING;
			-- Name of the Eiffel class 
			-- representing Current user 
			-- command

	arguments: EB_LINKED_LIST [ARG];
			-- Arguments of Current command
			-- (Defined in current or introduced
			-- from a parent)

	labels: EB_LINKED_LIST [CMD_LABEL];
			-- Labels of Current command.
			-- (Defined in current or introduced
			-- from a parent)

	eiffel_text: STRING;
			-- Eiffel class text associated with
			-- Current user command.

	label: STRING is
		do
			if  visual_name /= Void then
				Result := visual_name
			else
				Result := eiffel_type
			end;
		end;

feature -- Namable

	visual_name: STRING;

	set_visual_name (s: STRING) is
		do
			if (s = Void) then
				visual_name := Void
			else
				visual_name := clone (s);
				if has_instances then
					update_instance_names;
				end;
			end;
			command_catalog.update_name_in_editors (Current);
		end;

	update_instance_names is
		local
			s: STATE;
			b: BEHAVIOR
		do
			from
				Shared_app_graph.start
			until
				Shared_app_graph.off
			loop
				s ?= Shared_app_graph.key_for_iteration;
				if not (s = Void) then
					from
						s.start
					until
						s.after 
					loop
						b := s.output.data;
						from
							b.start
						until
							b.after 
						loop
							if (b.output.associated_command = Current) then
								if b.output.edited then
									b.output.inst_editor.update_title;
								end;
							end;
							b.forth
						end;
						s.forth
					end;
				end;
				Shared_app_graph.forth
			end
		end;


feature -- Editor

	set_editor (ed: CMD_EDITOR) is
		do
			command_editor := ed;
			old_template := template;
		end;

feature -- Undoable and non-undoable

	undoable: BOOLEAN;
			-- Is Command undoable?

	set_undoable (b: BOOLEAN) is
			-- Set undoable to `b'
		do
			undoable := b
		end

feature -- Inheritance

	has_parent: BOOLEAN is
			-- Does current command inherit
			-- from another command?
		do
			Result := parent_type /= Void
		end;

	set_parent (cmd: CMD) is 
			-- Set parent of Current
			-- user command to `cmd'.
		local
			set_parent_command: CMD_SET_PARENT
		do 
			!!set_parent_command;
			if not (parent_type = Void) then
				set_parent_command.set_previous_parent (parent_type);
			end;
			set_parent_command.set_parent_type (cmd);
			set_parent_command.execute (Current);
		end;

	remove_parent is
			-- Remove parent from Current.
		local
			cut_parent_command: CMD_CUT_PARENT
		do
			if parent_type /= Void then
				!!cut_parent_command;
				cut_parent_command.execute (Current);
			end
		end;

	refresh_parent is
			-- remove and redo parent with out recording it in the history.
		local
			refresh_parent_command: CMD_REFRESH_PARENT;
		do
			if parent_type /= Void then
				!!refresh_parent_command;
				refresh_parent_command.execute (Current);
			end;
		end;

	set_parent_type (c: CMD) is
			-- Set parent_type to `c'.
		do
			parent_type := c
		end;

	parent_type: CMD;
			-- Parent type of Current user
			-- command

feature -- Naming

	set_internal_name (s: STRING) is
			-- Set internal name of
			-- current user command.
		do
			if s.empty then
				namer.next;
				eiffel_type := namer.value;
			else
				eiffel_type := s
			end;
		end;

	reset_name is
		do
			namer.reset;
			int_generator.reset;
		end;

feature {NONE} -- Naming

	arg_entity_namer: LOCAL_NAMER is
			-- Argument entities namer
		once
			!!Result.make ("argument")
		end;

	arg_param_namer: LOCAL_NAMER is
			-- Argument parameters namer
		once
			!!Result.make ("arg")
		end;

	int_generator: INT_GENERATOR is
			-- Generator of unique integers
		once
			!!Result
		end;

	namer: NAMER is
			-- User command namer
		once
			!!Result.make ("Command");
		end;

feature -- Editing


	update_instance_editors is
			-- Update arguments in the instance 
			-- editors of Current command.
		local
			inst_editors: LINKED_LIST [CMD_INST_EDITOR];
			ed: CMD_INST_EDITOR
		do
			inst_editors := window_mgr.instance_editors;
			from
				inst_editors.start
			until
				inst_editors.after
			loop
				ed := inst_editors.item;
				if 
					(ed.command_instance.associated_command = Current)
				then
					ed.command_instance.update_arguments;
					ed.update
				end;
				inst_editors.forth
			end
		end;
 
	set_eiffel_text (s: STRING) is
			-- Set the eiffel text to
			-- `s'.
		do
			eiffel_text := s
		end;

	save is
			-- Save edited arguments, labels and
			-- eiffel text.
		require
			Editing: edited
		do
			save_arguments;
			save_labels;
			save_text;
		end;

	save_text is	
			-- Save text of Current command.
		require
			Editing: edited
		do
			if not eiffel_text.is_equal (command_editor.eiffel_text) then
				eiffel_text := clone (command_editor.eiffel_text);
				command_editor.set_unsaved_application;
			end;
		end;

	set_arguments (args: like arguments) is
			-- Set arguments to `args'.
		require
			valid_arg: args /= Void
		do
			arguments := args
		end;

	set_labels (l: like labels) is
			-- Set labels to `l'.
		require
			valid_labels: l /= Void
		do
			labels := l
		end;

feature {NONE}

	save_arguments is 
			-- Save arguments of Current command.
		require
			Editing: edited
		local
			l: EB_LINKED_LIST [ARG]
		do 
			from
				!!l.make;
				arguments.start;
			until
				arguments.after
			loop
				l.extend (arguments.item);
				arguments.forth
			end;
			arguments := l
		end;

	save_labels is 
			-- Save labels of Current command.
		require
			Editing: edited
		local
			l: EB_LINKED_LIST [CMD_LABEL]
		do 
			from
				!!l.make;
				labels.start;
			until
				labels.after
			loop
				l.extend (labels.item);
				labels.forth
			end;
			labels := l
		end;
	
feature  -- Generation 

	template: STRING is
			-- Template of the Eiffel
			-- command.
		local
			parent_name, temp: STRING;
			inherited_args: LINKED_LIST [STRING];
			found: BOOLEAN;
		do
			!!Result.make (0);
			Result.append ("class ");
			temp := clone (eiffel_type);
			temp.to_upper;
			Result.append (temp);
			if visual_name /= Void and then not visual_name.empty then
				Result.append ("%T%T-- ");
				Result.append (visual_name);
			end;
			Result.append ("%N%Ninherit%N%N%T");
			if (parent_type = Void) then
				if undoable then
					Result.append ("UNDOABLE_CMD");
				else
					Result.append ("NON_UNDOABLE_CMD");
				end
			else
				Result.append (parent_type.eiffel_inherit_text (renamed_labels));
			end;
			Result.append ("%N%Ncreation%N%N%Tmake");
			Result.append ("%N%Nfeature%N%N");
			from
				labels.start
			until
				labels.after
			loop
				if (labels.item.parent_type = Void) then
					Result.append ("%T");
					Result.append (labels.item.label);
					Result.append ("_label: STRING is %"");
					Result.append (labels.item.label);
					Result.append ("%";%N%N");
				end;
				labels.forth
			end;
			from
				arg_entity_namer.reset;
				arguments.start
			until
				arguments.after
			loop
				if (arguments.item.parent_type = Void) then
					Result.append ("%T");
					arg_entity_namer.next;
					Result.append (arg_entity_namer.value);
					Result.append (": ");
					Result.append (arguments.item.data.eiffel_type);
					Result.append (";%N%N");
				end;
				arguments.forth
			end;
			if (parent_type = Void) then
				Result.append ("%Texecute is%N%T%Tdo%N");
				if not labels.empty then
					from
						labels.start
					until
						labels.after or found
					loop
						if (labels.item.parent_type = Void) then
							Result.append ("%T%T%Tset_transition_label (");
							Result.append (labels.item.label);
							Result.append ("_label);%N");
							found := True;
						end;
					end;
				end;
				Result.append ("%T%Tend;%N%N");
			else
				Result.append (parent_type.eiffel_body_text);
			end;
			Result.append ("%Tmake");
			if
				not arguments.empty
			then
				Result.append (" (");
				from
					arguments.start;
					arg_param_namer.reset;
				until
					arguments.after
				loop
					arg_param_namer.next;
					Result.append (arg_param_namer.value);
					Result.append (": ");
					Result.append (arguments.item.data.eiffel_type);
					arguments.forth;
					if not arguments.after then
						Result.append (";%N%T%T")
					end;
				end;
				Result.append (")");
			end;
			Result.append (" is%N%T%Tdo");
			from
				arguments.start;
				arg_param_namer.reset;
				arg_entity_namer.reset;
				!!inherited_args.make;
			until
				arguments.after
			loop
				arg_param_namer.next;
				if (arguments.item.parent_type = Void) then
					arg_entity_namer.next;
					Result.append ("%N%T%T%T");
					Result.append (arg_entity_namer.value);
					Result.append (" := ");
					Result.append (arg_param_namer.value);	
					Result.append (";");
				else
					inherited_args.extend (arg_param_namer.value);
				end;
				arguments.forth
			end;
			Result.append ("%N");
			if not (parent_type = Void) then
				Result.append (parent_type.eiffel_creation_text (inherited_args));
			end;
			Result.append ("%T%Tend;%N%N");
			if undoable then
				Result.append ("%Tundo is%N%T%Tdo%N%T%Tend;%N%N");
				Result.append ("%Tredo is%N%T%Tdo%N%T%Tend;%N%N");
			end;
			Result.append ("end%N");
		end;

feature -- Arguments 

	add_argument (ts: TYPE_STONE) is
			-- Add an argument to Current command.
		require
			Edited: edited
		local
			new_argument: ARG;
			add_argument_cmd: CMD_ADD_ARGUMENT
		do
			!!new_argument.session_init (ts);
			!!add_argument_cmd;
			add_argument_cmd.set_element (new_argument);
			add_argument_cmd.execute (Current);
		end;
 
	remove_argument (a: ARG) is
			-- Remove `a' from the list of arguments
			-- from current command.
		require
			Edited: edited
		local
			remove_argument_cmd: CMD_CUT_ARGUMENT
		do
			arguments.start;
			arguments.search (a);
			if
				(not arguments.after) and then
				(not arguments.item.inherited)
			then
				!!remove_argument_cmd;
				remove_argument_cmd.set_index (arguments.index);
				remove_argument_cmd.execute (Current);
				update_instance_editors
			end
		end;

feature -- labels {CMD_EDITOR}

	add_label (l: STRING) is
			-- Add a label to current command.
		require
			Edited: edited
		local
			lab: CMD_LABEL;
			add_label_cmd: CMD_ADD_LABEL
		do
			if not label_exist (l) then
				!!lab.make (l);
				!!add_label_cmd;
				add_label_cmd.set_element (lab);
				add_label_cmd.execute (Current);
			end;
		end;

	label_exist (l: STRING): BOOLEAN is
		require
			lable_not_void: l /= Void;
		local
			temp_label: STRING;
			exist_label: STRING;
		do
			temp_label := clone (l);
			temp_label.to_lower;
			from 
				labels.start
			until
				labels.after
			loop
				exist_label := clone (labels.item.label);
				exist_label.to_lower;
				Result := temp_label.is_equal (exist_label);
				if Result then
					labels.finish;
				end;
				labels.forth;
			end;
		end;

 

	renamed_labels: LINKED_LIST [STRING] is
		do
			!!Result.make;
			from 
				labels.start
			until
				labels.after
			loop
				if labels.item.inh_renamed then
					Result.extend (clone (labels.item.label));
				end;
				labels.forth;
			end;
		end;

	remove_label (l: CMD_LABEL) is
			-- Remove `l' from the list of labels
			-- from current command.
		require
			Edited: edited
		local
			remove_label_cmd: CMD_CUT_LABEL
		do
			labels.start;
			labels.search (l);
			if
				(not labels.after) and then
				(not labels.item.inherited)
			then
				!!remove_label_cmd;
				remove_label_cmd.set_index (labels.index);
				remove_label_cmd.execute (Current);
			end
		end;

feature -- Text generation

	old_template: STRING;

	rescued: BOOLEAN;

	update_text is
			-- Update edited eiffel text by applying
			-- a `diff3' between the current edited text
			-- the previous template and the new template.
			-- Then update class text
		local
			doc: EB_DOCUMENT;
			merger: MERGER;
			temp: STRING;
			mp: MOUSE_PTR;
		do
			if not rescued then
				!!mp;
				mp.set_watch_shape;
				if edited then
					temp := command_editor.text_editor.text
				else
					temp := eiffel_text;
				end;
				!!merger;
				temp := merger.integrate (temp, old_template, template);
				if temp = Void then
					error_box.popup (Current, Messages.update_text_er, label)
				else
					if edited then
						command_editor.text_editor.set_text ("");
						command_editor.text_editor.append (temp);
					end;
					old_template := Void;
					eiffel_text := temp;
					!!doc;
					doc.set_directory_name (Environment.commands_directory);
					doc.set_document_name (eiffel_type);
					temp := clone (eiffel_text);
					if temp.item (1) /= '-' and label /= Void 
					  and then not label.empty then
						temp.prepend ("%N");
						temp.prepend (label);
						temp.prepend ("-- ");
					end;
					doc.update (temp);
					doc := Void;
				end;
				mp.restore;
			else
				rescued := False;
				error_box.popup (Current, Messages.update_text_er, label)
			end
		rescue
			mp.restore;
			rescued := True;
			retry
		end;

	save_old_template is
			-- Set old_template to template.
		do
			old_template := template
		end;


	remove_class is	
		local
			class_file: PLAIN_TEXT_FILE;
			file_name, temp: STRING;
		do
			!!file_name.make(50);
			file_name.append (Environment.commands_directory);
			file_name.append ("/");
			temp := clone (eiffel_type);
			temp.to_lower;
			file_name.append (temp);
			file_name.append (".e");
			!!class_file.make (file_name);
			if class_file.exists then
				class_file.delete;
			end;
		end;

	recreate_class is		
		local
			class_file: PLAIN_TEXT_FILE;
			file_name, temp: STRING;
		do
			!!file_name.make(50);
			file_name.append (Environment.commands_directory);
			file_name.append ("/");
			temp := clone (eiffel_type);
			temp.to_lower;
			file_name.append (temp);
			file_name.append (".e");
			!!class_file.make (file_name);
			if not class_file.exists then
				class_file.open_write;
				class_file.putstring (eiffel_text);
				class_file.close;
			end;
		end;




end -- class USER_CMD
