
-- Still need to save parent type!!!

class S_COMMAND 

inherit

	SHARED_STORAGE_INFO;
	CONSTANTS

creation

	make

feature 

	make (c: USER_CMD) is
		local
			args: LIST [ARG];
			labs: LIST [CMD_LABEL];
			arg: S_ARG
		do
			identifier := c.identifier;
			internal_name := c.eiffel_type;
			visual_name := c.visual_name;
			eiffel_text := c.eiffel_text;
			if c.has_parent then
				parent_type := c.parent_type.identifier
			end;
			args := c.arguments;
			from
				!!arguments.make;
				args.start
			until
				args.after
			loop
				!!arg.make (args.item);	
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
			arg: ARG;
			args: EB_LINKED_LIST [ARG];
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
			if not internal_name.is_equal (c.eiffel_type) then
				update_text (c.eiffel_type, new_text);
			end;
		end;

	update_text (s, nt: STRING) is
		local
			sub_pos: INTEGER;
			class_name: STRING;
		do
			class_name := clone (internal_name);
			class_name.prepend (" ");
			from
				sub_pos := nt.substring_index (class_name, 1)
			until
				sub_pos = 0
			loop
				nt.replace_substring (s, sub_pos+1, sub_pos + class_name.count- 1);
				sub_pos := nt.substring_index (class_name, sub_pos + s.count)
			end;

		end;

	get_new_text (fn: STRING): STRING is
		local
			cmd_file_name: FILE_NAME;
			cfile: PLAIN_TEXT_FILE;
			s: STRING;
		do
			!!cmd_file_name.make (0);
			cmd_file_name.from_string (fn);
			cmd_file_name := cmd_file_name.path_name;
			cmd_file_name.put (' ', cmd_file_name.count);
			cmd_file_name := cmd_file_name.path_name;
			cmd_file_name.append (Environment.classes_name);
			cmd_file_name.extend (Environment.directory_separator);
			cmd_file_name.append (Environment.Commands_name);
			cmd_file_name.extend (Environment.directory_separator);
			s := clone (internal_name);
			s.to_lower;
			cmd_file_name.append (s);
			cmd_file_name.append (".e");
			if cmd_file_name.exists  and then cmd_file_name.readable then
				cfile := cmd_file_name.to_file;
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

	arguments: LINKED_LIST [S_ARG];

	labels: LINKED_LIST [STRING];

	eiffel_text: STRING;

	parent_type: INTEGER;

end
