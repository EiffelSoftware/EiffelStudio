
-- Still need to save parent type!!!

class S_COMMAND 

inherit

	STORAGE_INFO
		export
			{NONE} all
		end;

	GROUP_SHARED
		export
			{NONE} all
		end


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
				arguments.add (arg);
				args.forth
			end;
			labs := c.labels;
			from
				labs.start;
				!!labels.make
			until
				labs.after
			loop
				labels.add (labs.item.label);
				labs.forth
			end;
		end;

	command: USER_CMD is
		do
			!!Result.make;
		end;

	update (c: USER_CMD) is
		local
			arg: ARG;
			args: EB_LINKED_LIST [ARG];
			lab: CMD_LABEL;
			labs: EB_LINKED_LIST [CMD_LABEL];
			p: CMD;
			in: STRING
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
				args.add (arg);
				arguments.forth
			end;
			from
				!!labs.make;
				labels.start
			until
				labels.after
			loop
				!!lab.make (labels.item);
				labs.add (lab);
				labels.forth
			end;
			if for_import.value then
				in := ""
			else
				in := internal_name
			end;
			c.storage_init (args, labs, eiffel_text, p, in, visual_name);
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
