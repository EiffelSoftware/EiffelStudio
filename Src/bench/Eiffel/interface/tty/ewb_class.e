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
			e_class: E_CLASS;
			id: IDENTIFIER
		do
			class_i := Eiffel_universe.class_with_name (class_name);
			if class_i /= Void then
				if want_compiled_class then
					e_class := class_i.compiled_eclass;
					if e_class = Void then
						io.error.putstring (class_name);
						io.error.putstring (" is not in the system%N");
					else
						process_compiled_class (e_class);
					end;
				else
					process_uncompiled_class (class_i);
				end
			else
				io.error.putstring (class_name);
				!! id.make (0);
				id.append (class_name);
				if id.is_valid then
					io.error.putstring (" is not in the universe%N")
				else
					io.error.putstring (" is not a valid class name%N")
				end
			end;
			class_name := Void;
		ensure then
			name_cleared: class_name = Void
		end;

	process_compiled_class (e_class: E_CLASS) is
			-- Process compiled class `e_class'.
			-- (Do nothing by default).
		require
			want_compiled_class: want_compiled_class;
			valid_e_class: e_class /= Void
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
