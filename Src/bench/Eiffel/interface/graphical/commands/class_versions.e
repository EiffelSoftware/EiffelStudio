indexing

	description:	
		"Command that displays all the class versions";
	date: "$Date$";
	revision: "$Revision$"

class CLASS_VERSIONS

inherit

	PROJECT_CONTEXT;
	TOOL_COMMAND
		rename
			init as make
		redefine
			tool, execute
		end

creation
	make

feature -- Properties

	tool: CLASS_W;
			-- Class tool

	name: STRING is "Versions"

feature -- Closure

	close_choice_window is
		do
			if choice /= Void then	
				choice.popdown
			end
		end

feature {NONE} -- Implementation

	choice: CHOICE_W;
			-- Window for user choices.

	version_list: ARRAYED_LIST [STRING];

feature {NONE} -- Execution

	execute (arg: ANY) is
			-- Execute the command.
		local
			classi: CLASSI_STONE;
			classc: CLASSC_STONE;
			choice_position: INTEGER
		do
			if (choice /= Void) and then (arg = choice) then
				choice_position := choice.position;
				if choice_position /= 0 then
					--class_i := version_list.i_th (choice_position);
					-- update text
					--execute (class_i)
				else
					close_choice_window
				end
				version_list := Void
			else
				classi ?= tool.stone;
				classc ?= tool.stone;
				if classi /= Void then
					display_choice (classi.class_i);
				elseif classc /= Void then
					display_choice (classc.e_class.lace_class);
				end
			end
		end;

feature {NONE} -- Implementation

	work (any: ANY) is
		do
		end;

	display_choice (classi: CLASS_I) is
				-- Display class names from `class_list' to `choice'.
		require
			classi_not_void: classi /= Void
		local
			stats: SYSTEM_STATISTICS;
			i, comp_nbr: INTEGER;
			cluster_name: STRING;
			base_name: STRING;
			fname: FILE_NAME;
			temp: STRING
		do
			base_name := classi.base_name;
			cluster_name := classi.cluster.cluster_name;
			!! version_list.make (1);
			!! stats.make_compilation_stat;
			from
				i := 1
			until
				i > comp_nbr
			loop
				!! fname.make_from_string (Backup_path);
				!! temp.make (9);
				temp.append (Comp);
				temp.append_integer (i);
				fname.extend (temp);
				fname.extend (cluster_name);
				fname.extend (base_name);
			end
			if choice = Void then
				!! choice.make (popup_parent)
			end;
			choice.popup (Current, version_list)
		end

end -- class CLASS_TEXT_FIELD
