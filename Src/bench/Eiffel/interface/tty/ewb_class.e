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

	want_compiled_class: BOOLEAN is
			-- Does current menu selection want a
			-- compiled class (class_c)?
			-- Otherwize, it wants the uncompiled 
			-- class (ie class_i)
			-- (False by default)
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
			class_c: CLASS_C
		do
			class_i := Universe.unique_class (class_name);
			if class_i /= Void then
				if want_compiled_class then
					class_c := class_i.compiled_class;
					if class_c = Void then
						io.error.putstring (class_name);
						io.error.putstring (" is not in the system%N");
					else
						process_compiled_class (class_c);
					end;
				else
					process_uncompiled_class (class_i);
				end
			else
				io.error.putstring (class_name);
				io.error.putstring (" is not in the universe%N");
			end;
			class_name := Void;
		ensure then
			name_cleared: class_name = Void
		end;

	process_compiled_class (class_c: CLASS_C) is
			-- Process compiled class `class_c'.
			-- (Do nothing by default).
		require
			want_compiled_class: want_compiled_class;
			valid_class_c: class_c /= Void
		do
		end;

	process_uncompiled_class (class_i: CLASS_I) is
			-- Process  uncompiled class `class_i'.
			-- (Do nothing by default).
		require
			not_want_compiled_class: not want_compiled_class
			valid_class_i: class_i /= Void
		do
		end;

end -- class EWB_CLASS
