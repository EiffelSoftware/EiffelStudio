indexing

	description: 
		"Abstract notion of command using a class.";
	date: "$Date$";
	revision: "$Revision $"

deferred class EWB_CLASS 

inherit

	EWB_CMD
		redefine
			loop_action
		end

feature -- Initialization

	make (cn: STRING) is
			-- Initialize class_name to `cn'.
		do
			class_name := cn;
			class_name.to_lower;
		ensure
			set: class_name = cn
		end;

feature -- Properties

	class_name: STRING;
			-- Class name 

feature {NONE} -- Execution

	want_compiled_class (class_i: CLASS_I): BOOLEAN is
			-- Does current menu selection want `class_i' to be compiled?
			-- (False by default)
		require
			class_i_not_void: class_i /= Void
		do
		end;

	loop_action is
			-- Execute Current command from loop.
		do
			command_line_io.get_class_name;
			class_name := command_line_io.last_input;
			check_arguments_and_execute;
		end;

	execute is
			-- Execute Current command.
		local
			class_i: CLASS_I;
			e_class: CLASS_C;
			id: IDENTIFIER;
			at_pos: INTEGER;
			cluster_name: STRING;
			cluster: CLUSTER_I;
			class_list: LIST [CLASS_I]
		do
			if not class_name.is_empty then
				at_pos := class_name.index_of ('@', 1);
			end;
			if at_pos = 0 then
				class_list := Eiffel_universe.classes_with_name (class_name);
				if class_list.is_empty then
					class_name.to_upper;
					io.error.putstring (class_name);
					!! id.make (0);
					id.append (class_name);
					if id.is_valid then
						io.error.putstring (" is not in the universe%N")
					else
						io.error.putstring (" is not a valid class name%N")
					end
				elseif class_list.count = 1 then
					class_i := class_list.first
				else
					io.error.putstring ("Several classes have the same name:%N")
					class_name.to_upper;
					from class_list.start until class_list.after loop
						class_i := class_list.item;
						io.error.put_character ('%T');
						io.error.put_string (class_name);
						io.error.put_character ('@');
						io.error.put_string (class_i.cluster.cluster_name);
						io.error.new_line;
						class_list.forth
					end;
					class_i := Void
				end
			elseif at_pos = class_name.count then
				class_name.remove_tail (1);
				execute
			else
				cluster_name := class_name.substring (at_pos + 1, class_name.count);
				if at_pos > 1 then
					class_name := class_name.substring (1, at_pos - 1)
				else
					class_name := ""
				end
				cluster := Eiffel_universe.cluster_of_name (cluster_name);
				if cluster = Void then
					io.error.putstring ("Cluster ");
					io.error.put_string (cluster_name);
					io.error.putstring (" does not exist.");
					io.error.new_line
				else
					class_i := cluster.classes.item (class_name);
					if class_i = Void then
						class_name.to_upper;
						io.error.putstring (class_name);
						!! id.make (0);
						id.append (class_name);
						if id.is_valid then
							io.error.putstring (" is not in cluster ");
							io.error.put_string (cluster_name);
							io.error.new_line
						else
							io.error.putstring (" is not a valid class name%N")
						end
					end
				end
			end
			if class_i /= Void then
				if want_compiled_class (class_i) then
					e_class := class_i.compiled_class;
					if e_class = Void then
						class_name.to_upper;
						io.error.putstring (class_name);
						io.error.putstring (" is not in the system%N");
					else
						process_compiled_class (e_class);
					end;
				else
					process_uncompiled_class (class_i);
				end
			end;
			class_name := Void;
		ensure then
			name_cleared: class_name = Void
		end;

	process_compiled_class (e_class: CLASS_C) is
			-- Process compiled class `e_class'.
			-- (Do nothing by default).
		require
			valid_e_class: e_class /= Void;
			want_compiled_class: want_compiled_class (e_class.lace_class)
		do
		end;

	process_uncompiled_class (class_i: CLASS_I) is
			-- Process  uncompiled class `class_i'.
			-- (Do nothing by default).
		require
			valid_class_i: class_i /= Void;
			not_want_compiled_class: not want_compiled_class (class_i)
		do
		end;

end -- class EWB_CLASS
