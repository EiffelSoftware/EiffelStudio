
-- General notion of user command
-- i.e. editable command.

class USER_CMD 

inherit

	CMD
		redefine
			original_stone
		end;
	PIXMAPS
		export
			{NONE} all
		end;
	NAMABLE

creation

	make, session_init, storage_init

feature -- Creation

	make is
			-- Initialize current user
			-- command.
		do
			set_symbol (Command_pixmap);
			int_generator.next;
			identifier := int_generator.value;
			!!arguments.make;
			!!labels.make;
		end;

	session_init is
		do
			!!arguments.make;
			!!labels.make;
		end;

	storage_init (a: like arguments; l: like labels;
			s: STRING; p: CMD; in,vn: STRING) is
		do
			arguments := a;
			labels := l;
			eiffel_text := s;
			parent_type := p;
			set_internal_name (in);
			set_visual_name (vn)	
		end;

feature -- Stone

	original_stone: USER_CMD is
		do
			Result := Current
		end;

	label: STRING is
		do
			if not (visual_name = Void) then
				Result := visual_name
			else
				Result := eiffel_type
			end;
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

feature -- Namable

	visual_name: STRING;

	set_visual_name (s: STRING) is
		do
			if (s = Void) then
				visual_name := Void
			else
				visual_name := s.duplicate
			end	;
			command_catalog.update_name_in_editors (Current)
		end;

feature -- Inherentance

	has_parent: BOOLEAN is
			-- Does current command inherit
			-- from another command?
		do
			Result := not (parent_type = Void)
		end;


	set_parent (cmd: CMD) is 
			-- Set parent type of Current
			-- user command to `cmd'.
		local
			a: ARG;
			l: CMD_LABEL;
			oal, nal: like arguments;
			oll, nll: like labels
		do 
			if not (parent_type = Void) then
				remove_parent
			end;
			parent_type := cmd;
			from
				oal := cmd.arguments;
				oal.start;
				!!nal.make
			until
				oal.after
			loop
				!!a.set (oal.item.type, parent_type);
				nal.add (a);
				oal.forth;
			end;		
			from
				oll := cmd.labels;
				oll.start;
				!!nll.make
			until
				oll.after
			loop
				!!l.make (oll.item.label);
				l.set_parent (parent_type);
				nll.add (l);
				oll.forth;
			end;		
		end;

	remove_parent is
		do
			from
				arguments.start
			until
				arguments.after
			loop
				if 
					arguments.item.parent_type = parent_type 
				then
					arguments.remove
				else
					arguments.forth	
				end;
			end;
			from
				labels.start
			until
				labels.after
			loop
				if 
					labels.item.parent_type = parent_type 
				then
					labels.remove
				else
					labels.forth	
				end;
			end;
			parent_type := Void;
		end;

	parent_type: CMD;
			-- Parent type of Current user
			-- command

feature -- Editing

	save_text is	
		require
			Editing: edited
		do
			eiffel_text := command_editor.eiffel_text
		end;

	set_arguments (args: like arguments) is
		do
			arguments := args
		end;

	set_labels (l: like labels) is
		do
			labels := l
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

	update_instance_editors is
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
	
feature {NONE} -- Editing

	save_arguments is 
			-- Save arguments.
		require
			Editing: edited
		local
			l: like arguments
		do 
			from
				!!l.make;
				arguments.start;
			until
				arguments.after
			loop
				l.add (arguments.item);
				arguments.forth
			end;
			arguments := l
		end;

	save_labels is 
			-- Save labels.
		require
			Editing: edited
		local
			l: like labels
		do 
			from
				!!l.make;
				labels.start;
			until
				labels.after
			loop
				l.add (labels.item);
				labels.forth
			end;
			labels := l
		end;

feature {NONE} -- Naming

	arg_entity_namer: LOCAL_NAMER is
		once
			!!Result.make ("argument")
		end;

	arg_param_namer: LOCAL_NAMER is
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

feature -- Code generation

	template: STRING is
			-- Template of the Eiffel
			-- command.
		local
			parent_name: STRING;
			inherited_args: LINKED_LIST [STRING]
		do
			!!Result.make (0);
			Result.append ("class ");
			Result.append (eiffel_type);
			Result.append ("%N%Ninherit%N%N%T");
			if (parent_type = Void) then
				Result.append ("CMD");
			else
				Result.append (parent_type.eiffel_inherit_text);
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
					Result.append (arguments.item.eiffel_type);
					Result.append (";%N%N");
				end;
				arguments.forth
			end;
			if (parent_type = Void) then
				Result.append ("%Texecute is%N%T%Tdo%N%T%Tend; -- execute%N%N");
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
					Result.append (arguments.item.eiffel_type);
					arguments.forth;
					if not arguments.after then
						Result.append ("; ")
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
					inherited_args.add (arg_param_namer.value);
				end;
				arguments.forth
			end;
			Result.append ("%N");
			if not (parent_type = Void) then
				Result.append (parent_type.eiffel_creation_text (inherited_args));
			end;
			Result.append ("%T%Tend; -- make%N%N");
			Result.append ("end -- class ");
			Result.append (eiffel_type);
			Result.append ("%N")
		end;

end 
