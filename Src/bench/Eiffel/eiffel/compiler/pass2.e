
class PASS2

inherit
	SHARED_TMP_SERVER

	SHARED_ERROR_HANDLER

	SORTED_PASS
		redefine
			changed_classes, execute, make, remove_class
		end

	COMPILER_EXPORTER

creation

	make

feature

	changed_classes: PART_SORTED_TWO_WAY_LIST [PASS2_C];

	extra_check_list: PART_SORTED_TWO_WAY_LIST [CLASS_C];
			-- List of classes that needs to be processed
			-- at the end of pass 2 (expandeds and 
			-- replication)

	changed_status: TWO_WAY_SORTED_SET [CLASS_ID];
			-- Sorted set of all the classes for which the expanded
			-- or deferred status has changed

	Degree_number: INTEGER is 4;
		
	make is
		do
			!!changed_classes.make;
			!!changed_status.make;
			changed_status.compare_objects;
			!!extra_check_list.make;
		end;

	new_controler (a_class: CLASS_C): PASS2_C is
		do
			!!Result.make (a_class)
		end;

	execute is
			-- Inheritance anlysis on the changed classes. Since the
			-- classes contained in `changed_classes' are sorted by class
			-- id's, it ensures that a class will be treated here once
			-- the treatment of its parents is completed. That's why
			-- we re-sort the list `changed_class' after the topological
			-- sort in order to take advantage of it.
		local
			pass2_c: PASS2_C;
			current_class: CLASS_C;
			id: CLASS_ID;
			deg_output: DEGREE_OUTPUT
			local_changed_classes: PART_SORTED_TWO_WAY_LIST [PASS2_C];
			local_extra_check_list: PART_SORTED_TWO_WAY_LIST [CLASS_C];
		do
			local_changed_classes := changed_classes
			deg_output := Degree_output;
			deg_output.put_start_degree (Degree_number, local_changed_classes.count)

			from
				local_changed_classes.start
			until
				local_changed_classes.after
			loop
				current_class := local_changed_classes.item.associated_class;
				if current_class.changed and then current_class.generics /= Void	then
					System.set_current_class (current_class);
					current_class.check_constraint_genericity;
				end;
				local_changed_classes.forth
			end;
				-- Cannot continue if there is an error in the
				-- constraint genericity clause of a class
			Error_handler.checksum;

			from
				local_extra_check_list := extra_check_list
			until
				local_changed_classes.empty
			loop
				pass2_c := local_changed_classes.first;
				current_class := pass2_c.associated_class;
				System.set_current_class (current_class)

				pass2_c.execute (deg_output, local_changed_classes.count)

				if not local_extra_check_list.has (current_class) then
					local_extra_check_list.extend (current_class)
				end

				local_changed_classes.start;
				local_changed_classes.search (pass2_c);
				if not local_changed_classes.after then
					local_changed_classes.remove;
				end
			end
			deg_output.put_end_degree;

			if System.has_expanded and then not local_extra_check_list.empty then
				System.check_vtec;
			end;

			if not System.code_replication_off then
				from
					local_extra_check_list.start;
				until
					local_extra_check_list.empty
				loop
					current_class := local_extra_check_list.first;
					System.set_current_class (current_class);
					id := current_class.id;
					if Tmp_rep_info_server.has (id) then
						current_class.process_replicated_features;
					elseif Tmp_rep_server.has (id) then
						Tmp_rep_server.remove (id)
					end;
					local_extra_check_list.remove;
				end;
			end;

			System.set_current_class (Void);

			changed_status.wipe_out;
		end;

	remove_class (a_class: CLASS_C) is
		local
			found: BOOLEAN
			local_extra_check_list: PART_SORTED_TWO_WAY_LIST [CLASS_C]
		do	
			{SORTED_PASS} Precursor (a_class);
			from
				local_extra_check_list := extra_check_list
				local_extra_check_list.start
			until
				local_extra_check_list.after or else found
			loop
				if local_extra_check_list.item = a_class then
					found := True;
					local_extra_check_list.remove;
				else
					local_extra_check_list.forth
				end;
			end;
		end;

	set_expanded_modified (a_class: CLASS_C) is
			-- The expanded status of `a_class' has been modified
		require
			good_argument: a_class /= Void
		local
			pass2_c: PASS2_C;
		do
			pass2_c ?= controler_of (a_class);
			pass2_c.set_expanded_modified
		end;

	set_deferred_modified (a_class: CLASS_C) is
			-- The deferred status of `a_class' has been modified
		require
			good_argument: a_class /= Void
		local
			pass2_c: PASS2_C;
		do
			pass2_c ?= controler_of (a_class);
			pass2_c.set_deferred_modified
		end;

	set_separate_modified (a_class: CLASS_C) is
				-- The separate status of `a_class' has been modified
		require
			good_argument: a_class /= Void
		local
			pass2_c: PASS2_C;
		do
			pass2_c ?= controler_of (a_class);
			pass2_c.set_separate_modified
		end;

	set_supplier_status_modified (a_class: CLASS_C) is
			-- The status of a supplier has changed
		require
			good_argument: a_class /= Void
		local
			pass2_c: PASS2_C
		do
			pass2_c ?= controler_of (a_class);
			pass2_c.set_supplier_status_modified;
			pass2_c.set_new_compilation;
		end;

	add_changed_status (a_class: CLASS_C) is
			-- Record `a_class.id' in `changed_status'
		require
			good_argument: a_class /= Void
		do
			set_supplier_status_modified (a_class);
			changed_status.extend (a_class.id)
		end;

feature -- Dino stuff

	set_assertion_prop_list (a_class: CLASS_C; l: LINKED_LIST [ROUTINE_ID]) is
		local
			pass2_c: PASS2_C
		do
			pass2_c ?= controler_of (a_class);
			pass2_c.set_assertion_prop_list (l);
		end;

end
