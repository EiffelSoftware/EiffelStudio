
-- Still need to save parent type!!!

class S_COMMAND 

inherit

	SHARED_STORAGE_INFO;
	CONSTANTS
	SHARED_INSTANTIATOR

creation

	make

feature 

	make (c: USER_CMD) is
		local
			args: LIST [ARG];
			labs: LIST [CMD_LABEL];
			arg: S_ARG
		do
			identifier := c.data.identifier;
			internal_name := c.eiffel_type;
			visual_name := c.visual_name;
			eiffel_text := c.eiffel_text;
			if c.has_parent then
				parent_type := c.parent_type.identifier
			end;
			args := c.arguments;
			from
				!! arguments.make
				args.start
			until
				args.after
			loop
				!! arg.make (args.item);
				arguments.extend (arg);
				args.forth
			end;
			labs := c.labels;
			from
				labs.start;
				!!labels.make
			until
				labs.after
			loop
				labels.extend (labs.item.label);
				labs.forth
			end;
		end;

	command: USER_CMD is
		do
			!!Result.make;
		end;

	update (c: USER_CMD; dir_name: STRING) is
		local
			arg: ARG
			args: EB_LINKED_LIST [ARG]
			lab: CMD_LABEL;
			labs: EB_LINKED_LIST [CMD_LABEL];
			p: CMD;
			in: STRING;
			new_text: STRING;
		do
			if parent_type > 0 then
				p := command_table.item (parent_type)
			elseif parent_type < 0 then
				p := predefined_command_table.item (- parent_type)
			end;
			from
				!!args.make;
				arguments.start;
			until
				arguments.after	
			loop
				arg := arguments.item.argument;
				args.extend (arg);
				arguments.forth
			end;
			from
				!!labs.make;
				labels.start
			until
				labels.after
			loop
				!!lab.make (labels.item);
				labs.extend (lab);
				labels.forth
			end;
			if for_import.item then
				in := "";
			else
				in := internal_name;
			end;
			new_text := get_new_text (dir_name);
			if new_text = Void or else new_text.empty then
				new_text := eiffel_text;
			end;
			c.storage_init (args, labs, new_text, p, in, visual_name);
			if p /= Void then
				c.update_inherited_label
			end;	
			if not internal_name.is_equal (c.eiffel_type) then
				update_text (c.eiffel_type, new_text);
			end;
			command_instantiator_generator.add_command (c)
		end;

	update_text (s, nt: STRING) is
		local
			sub_pos: INTEGER;
			class_name: STRING;
			new_class_name: STRING
		do
			new_class_name := clone (s);
			new_class_name.to_upper;
			class_name := clone (internal_name);
			class_name.to_upper;
			sub_pos := nt.substring_index (class_name, 1)
			if sub_pos /= 0 then
				nt.replace_substring (new_class_name, 
						sub_pos, 
						sub_pos + class_name.count - 1);
			end;
		end;

	get_new_text (dir_name: STRING): STRING is
		local
			cmd_file_name: FILE_NAME;
			cfile: PLAIN_TEXT_FILE;
			s: STRING;
		do
			!! cmd_file_name.make_from_string (dir_name);
			cmd_file_name.extend (Environment.classes_name);
			cmd_file_name.extend (Environment.Commands_name);
			s := clone (internal_name);
			s.to_lower;
			cmd_file_name.set_file_name (s);
			cmd_file_name.add_extension ("e");
			!! cfile.make (cmd_file_name);
			if cfile.exists and then 
				cfile.is_readable 
			then
				!!Result.make (0);
				from
					cfile.open_read;
					cfile.readline
				until
					cfile.end_of_file
				loop
					Result.append (cfile.laststring);
					Result.append ("%N");
					cfile.readline;
				end;
				cfile.close;
			end;
		end;

-- ***********
-- Stored data
-- ***********

	identifier: INTEGER;

	
feature {NONE}

	internal_name: STRING;

	visual_name: STRING;

	arguments: LINKED_LIST [S_ARG]

	labels: LINKED_LIST [STRING];

	eiffel_text: STRING;

	parent_type: INTEGER;

end
