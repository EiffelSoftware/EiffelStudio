-- Time checker

class TIME_CHECKER 

inherit

	SHARED_WORKBENCH;
	SHARED_ERROR_HANDLER;
	COMPILER_EXPORTER

feature

	time_check is
			-- Check time stamps of compiled classes of the system
		require
			System.root_class.compiled_class /= Void
		do
			if System.any_class.compiled_class.parents /= Void then
				check_suppliers_of_unchanged_classes;
			end;
		end;

	check_suppliers_of_unchanged_classes is
			-- Check if there is no conflicts for the suppliers
			-- of the `old' classes but only if the system is moved
			-- i.e. if a class has been added or removed
		local
			new_classes: LINKED_LIST [CLASS_I]
			old_classes: HASH_TABLE [BOOLEAN, INTEGER]
			clusters: LINKED_LIST [CLUSTER_I]
			class_name: STRING
			class_c: CLASS_C
			class_i: CLASS_I
			checked_classes: HASH_TABLE [BOOLEAN, INTEGER]
			clients: LINKED_LIST [CLASS_C]
			check_clients: BOOLEAN
			class_id: INTEGER
		do
			new_classes := System.new_classes;
			if not new_classes.is_empty then
debug ("ACTIVITY")
io.error.putstring ("TIME_CHECK check_suppliers_of_unchanged_classes%N");
end;
				!!old_classes.make (500);
				clusters := Universe.clusters;
				from
					new_classes.start
				until
					new_classes.after
				loop
					class_name := new_classes.item.name;
debug ("ACTIVITY")
io.error.putstring ("%Tfind classes of name ");
io.error.putstring (class_name);
io.error.putstring ("%N");
end;
						-- Find the classes with this name that can be
						-- reached from one of the clusters
-- FIXME renaming ...
					from
						clusters.start
					until
						clusters.after
					loop
						class_i := clusters.item.classes.item (class_name);
						if class_i /= Void then
							class_c := class_i.compiled_class;
							if class_c /= Void then
									-- A compiled class has been found
									-- Insert it in the list
								old_classes.put (True, class_c.class_id);
								check_clients := True;
							end;
						end;
						clusters.forth;
					end;
					new_classes.forth
				end;
				if check_clients then
						-- Some classes may have the same visiblity
						-- Check all the clients because there is maybe a conflict
						-- 'classes_to_recompile' is updated and the check is done only once
					!!checked_classes.make (old_classes.count);
					from
						old_classes.start
					until
						old_classes.after
					loop
						if old_classes.item_for_iteration = True then
								-- Valid clients must be checked
							class_id := old_classes.key_for_iteration;
debug ("ACTIVITY")
io.error.putstring ("%T%Tcheck clients of ");
io.error.putstring (System.class_of_id (class_id).name);
io.error.putstring ("%N");
end;
							clients := System.class_of_id (class_id).syntactical_clients;
							from
								clients.start
							until
								clients.after
							loop
								class_c := clients.item;
								if
									not class_c.changed
										-- Pass1 will be done entirely on the class
								and then
									checked_classes.item (class_c.class_id) = False
								then
									checked_classes.put (True, class_c.class_id);
debug ("ACTIVITY")
io.error.putstring ("%T%Tcheck: ");
io.error.putstring (class_c.name);
io.error.putstring ("%N");
end;
									class_c.check_suppliers_and_parents
								end;
								clients.forth
							end;
						end;
						old_classes.forth
					end;
				end;
			end;
				-- Display the errors if any
			Error_handler.checksum
		end;

end
