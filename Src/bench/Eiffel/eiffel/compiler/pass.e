-- Abstract notion of a compiler pass

deferred class PASS

inherit

	SHARED_WORKBENCH;
	SHARED_EIFFEL_PROJECT

feature -- Attributes

	changed_classes: LINKED_LIST [PASS_C];
			-- The current pass must be done on all the classes
			-- referenced by the PASS_C objects

feature -- Acces

	Degree_number: INTEGER is
			-- Degree number for current pass
		deferred
		end;

feature

	make is
		do
			!!changed_classes.make
			changed_classes.compare_references
		end;

	execute is
			-- Execution of the pass `level' for the entire system
		local
			pass_c: PASS_C;
			deg_output: DEGREE_OUTPUT
			local_changed_classes: LINKED_LIST [PASS_C]
		do
			from
				local_changed_classes := changed_classes
				deg_output := Degree_output;
				deg_output.put_start_degree (Degree_number, local_changed_classes.count);
			until
				local_changed_classes.empty
			loop
				pass_c := local_changed_classes.first;
				System.set_current_class (pass_c.associated_class);

				pass_c.execute (deg_output, local_changed_classes.count);

				local_changed_classes.start;
				local_changed_classes.search (pass_c);
				if not local_changed_classes.after then
					local_changed_classes.remove;
				end;

			end;

			deg_output.put_end_degree;
			System.set_current_class (Void);
		end;

	controler_of (a_class: CLASS_C): PASS_C is
			-- Find the controler of `a_class', create it if
			-- it does not exist
		require
			good_argument: a_class /= Void
		local
			found: BOOLEAN;
			pass_c: PASS_C;
			position: INTEGER;
			old_cursor: CURSOR
			local_changed_classes: LINKED_LIST [PASS_C]
		do
			from
				local_changed_classes := changed_classes
				old_cursor := local_changed_classes.cursor;
				local_changed_classes.start
			until
				local_changed_classes.after or else found
			loop
				pass_c := local_changed_classes.item;
				if pass_c.associated_class = a_class then
					found := True;
					Result := pass_c;
				end;
				local_changed_classes.forth
			end;

			if not found then
				Result := new_controler (a_class);
				check
					local_changed_classes.after
				end;
				local_changed_classes.put_left (Result);
			end;
			local_changed_classes.go_to (old_cursor);
		end;

	new_controler (a_class: CLASS_C): PASS_C is
			-- Create a controler for `a_class' in current pass
		require
			good_argument: a_class /= Void
		deferred
		end;

	insert_new_class (a_class: CLASS_C) is
			-- `a_class' must be recompiled by the current pass
		require
			good_argument: a_class /= Void
		local
			pass_c: PASS_C;
		do
			pass_c := controler_of (a_class);
			pass_c.set_new_compilation
		end;

	remove_class (a_class: CLASS_C) is
			-- Remove the controler of `a_class'
		require
			good_argument: a_class /= Void
		local
			found: BOOLEAN;
			pass_c: PASS_C;
			local_changed_classes: LINKED_LIST [PASS_C]
		do
			from
				local_changed_classes := changed_classes
				local_changed_classes.start
			until
				local_changed_classes.after or else found
			loop
				pass_c := local_changed_classes.item;
				if pass_c.associated_class = a_class then
					found := True;
					local_changed_classes.remove;
				else
					local_changed_classes.forth
				end;
			end;
		end;

	wipe_out is
			-- Clear the controler
		do
			changed_classes.wipe_out
		end;

	trace is
			-- Trace
		do
			io.error.putstring (generator);
			io.error.putstring (": trace%N");
			from
				changed_classes.start
			until
				changed_classes.after
			loop
				io.error.putstring (changed_classes.item.associated_class.name);
				io.error.new_line;
				changed_classes.forth
			end;
		end;

end
