
class PASS4

inherit

	SORTED_PASS
		rename
			execute as old_execute
		redefine
			changed_classes
		end;

	SORTED_PASS
		redefine
			changed_classes, execute
		select
			execute
		end

creation

	make

feature

	changed_classes: PART_SORTED_TWO_WAY_LIST [PASS4_C];

	Degree_number: INTEGER is 2;

	new_controler (a_class: CLASS_C): PASS4_C is
		do
			!!Result.make (a_class)
		end;

	execute is
			-- Execution of the pass level 4.
		local
			pass_c: PASS4_C;
			deg_output: DEGREE_OUTPUT
		do
			if System.freeze then
            	deg_output := Degree_output;
            	deg_output.put_start_degree (Degree_number, changed_classes.count)
				from
				until
					changed_classes.empty
				loop
	debug ("COUNT")
		io.error.putstring ("[");
		io.error.putint (changed_classes.count);
		io.error.putstring ("] ");
	end;
					pass_c := changed_classes.first;
					System.set_current_class (pass_c.associated_class);
					pass_c.update_dispatch_table (deg_output, changed_classes.count);
					changed_classes.start;
					changed_classes.search (pass_c);
					if not changed_classes.after then
						changed_classes.remove;
					end;
				end;
				deg_output.put_end_degree;
				System.set_current_class (Void);
			else
				old_execute
			end;
		end;
	
end
