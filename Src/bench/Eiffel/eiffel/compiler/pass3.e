
class PASS3

inherit

	SORTED_PASS
		redefine
			changed_classes,
			execute
		end

creation

	make

feature

	changed_classes: PART_SORTED_TWO_WAY_LIST [PASS3_C];

	new_controler (a_class: CLASS_C): PASS3_C is
		do
			!! Result.make (a_class)
		end;

	Degree_number: INTEGER is 3;

feature -- Execution

	execute is
			-- Execution of the pass `level' for the entire system
		local
			pass3_c: PASS3_C;
			deg_output: DEGREE_OUTPUT
			classes_left: INTEGER
		do
			from
				deg_output := Degree_output
				classes_left := changed_classes.count
				deg_output.put_start_degree (Degree_number, classes_left)
				changed_classes.start
			until
				changed_classes.after
			loop
				pass3_c := changed_classes.item
				System.set_current_class (pass3_c.associated_class)

				pass3_c.execute (deg_output, classes_left)
				classes_left := classes_left - 1

				changed_classes.forth;
			end;

			changed_classes.wipe_out
			deg_output.put_end_degree
			System.set_current_class (Void)
		end;

end
