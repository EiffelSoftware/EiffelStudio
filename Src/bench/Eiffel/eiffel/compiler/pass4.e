
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
			pass4_c: PASS4_C;
			deg_output: DEGREE_OUTPUT
			classes_left: INTEGER
		do
			if System.freeze then
	      		from
      				deg_output := Degree_output
					classes_left := changed_classes.count
	      	      	deg_output.put_start_degree (Degree_number, classes_left)
					changed_classes.start
				until
					changed_classes.after
				loop
					pass4_c := changed_classes.item
					System.set_current_class (pass4_c.associated_class)
					pass4_c.update_dispatch_table (deg_output, classes_left)
					classes_left := classes_left - 1

					changed_classes.forth
				end

				deg_output.put_end_degree
				System.set_current_class (Void)
			else
				old_execute
			end

			changed_classes.wipe_out
		end;
	
end
