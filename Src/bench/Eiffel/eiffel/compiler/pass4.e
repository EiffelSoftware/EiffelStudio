
class PASS4

inherit

	SORTED_PASS
		redefine
			changed_classes,
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
			pass4_c: PASS4_C
			pass_c: PASS_C
			deg_output: DEGREE_OUTPUT
			classes_left: INTEGER
			local_changed_classes: PART_SORTED_TWO_WAY_LIST [PASS4_C]
		do
			local_changed_classes := changed_classes
			if System.freeze then
				from
					deg_output := Degree_output
					classes_left := local_changed_classes.count
					deg_output.put_start_degree (Degree_number, classes_left)
					local_changed_classes.start
				until
					local_changed_classes.after
				loop
					pass4_c := local_changed_classes.item
					System.set_current_class (pass4_c.associated_class)
					pass4_c.update_dispatch_table (deg_output, classes_left)
					classes_left := classes_left - 1

					local_changed_classes.forth
				end

				deg_output.put_end_degree
				System.set_current_class (Void)
			else
				from
					deg_output := Degree_output
					classes_left := local_changed_classes.count
					deg_output.put_start_degree (Degree_number, classes_left)
					local_changed_classes.start
				until
					local_changed_classes.after
				loop
					pass_c := local_changed_classes.item
					System.set_current_class (pass_c.associated_class)
					pass_c.execute (deg_output, classes_left)
					classes_left := classes_left - 1

					local_changed_classes.forth
				end

				deg_output.put_end_degree
				System.set_current_class (Void)
			end

			local_changed_classes.wipe_out
		end;
	
end
