-- Abstract notion of a compiler pass

deferred class PASS

feature -- Attributes

	changed_classes: LINKED_LIST [PASS_C];
			-- The current pass must be done on all the classes
			-- referenced by the PASS_C objects

feature

	level: INTEGER is
			-- Compilation level
		deferred
		end;

	make is
		do
			!!changed_classes.make
		end;

	execute is
			-- Execution of the pass `level' for the entire system
		local
			pass_c: PASS_C
		do
			from
			until
				changed_classes.empty
			loop
debug ("COUNT")
	io.error.putstring ("(");
	io.error.putint (changed_classes.count);
	io.error.putstring (") ");
end;
				changed_classes.start;
				pass_c := changed_classes.first;
				pass_c.execute;
				changed_classes.remove;
			end;
		end;

	controler_of (a_class: CLASS_C): PASS_C is
			-- Find the controler of `a_class', create it if
			-- it does not exist
		local
			found: BOOLEAN;
			pass_c: PASS_C;
			position: INTEGER;
		do
			from
				position := changed_classes.position;
				changed_classes.start
			until
				changed_classes.after or else found
			loop
				pass_c := changed_classes.item;
				if pass_c.associated_class = a_class then
					found := True;
					Result := pass_c;
				end;
				changed_classes.forth
			end;
			if not found then
				Result := new_controler (a_class);
				changed_classes.add_left (Result);
			end;
			changed_classes.go (position);
		end;

	new_controler (a_class: CLASS_C): PASS_C is
			-- Create a controler for `a_class' in current pass
		deferred
		end;

	insert_new_class (a_class: CLASS_C) is
			-- `a_class' must be recompiled by the current pass
		local
			pass_c: PASS_C;
		do
			pass_c := controler_of (a_class);
			pass_c.set_new_compilation
		end;

	remove_class (a_class: CLASS_C) is
			-- Remove the controler of `a_class'
		local
			found: BOOLEAN;
			pass_c: PASS_C;
			position: INTEGER;
		do
			from
				position := changed_classes.position;
				changed_classes.start
			until
				changed_classes.after or else found
			loop
				pass_c := changed_classes.item;
				if pass_c.associated_class = a_class then
					found := True;
					changed_classes.remove;
				end;
				changed_classes.forth
			end;
			changed_classes.go (position);
		end;

	wipe_out is
			-- Clear the controler
		do
			changed_classes.wipe_out
		end;

	trace is
			-- Trace
		do
			io.error.putstring ("PASS_CONTROLER: trace%N");
			from
				changed_classes.start
			until
				changed_classes.after
			loop
				io.error.putstring (changed_classes.item.associated_class.class_name);
				io.error.new_line;
				changed_classes.forth
			end;
		end;

end
