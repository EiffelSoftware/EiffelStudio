-- Time checker

class TIME_CHECKER 

inherit

	SHARED_WORKBENCH;
	SHARED_ERROR_HANDLER

feature

	id_array: ARRAY [INTEGER];
			-- Array of informations for traversal
			--| inspect id_array.item (a_class.id)
			--| when Not_traversed then class has no been traversed yes.
			--| when Traversed then class has been aldready traversed.
			--| when Removed then class has been traversed but class file doen't
			--| exist anymore. 

	time_check is
			-- Check time stamps of compiled classes of the system
		require
			System.root_class.compiled_class /= Void
		local
			system_array: ARRAY [CLASS_C];
			root_class, a_class: CLASS_C;
		do
				-- Initialization of structure `id_array'
			system_array := System.id_array;
			!!id_array.make (1, system_array.count);

				-- Check system form root class
			root_class := System.root_class.compiled_class;
			if root_class.parents /= Void then
					-- A compilation has been done already
					-- Cannot remove root class
				check_class (root_class);
			end;
				-- Two checks because the first one may fail if the
				-- root class has changed between two compilations
			if System.any_class.compiled_class.parents /= Void then
					-- Cannot remove simple classes
				check_basic_class (System.boolean_class);
				check_basic_class (System.character_class);
				check_basic_class (System.integer_class);
				check_basic_class (System.real_class);
				check_basic_class (System.double_class);
				check_basic_class (System.bit_class);
				check_basic_class (System.string_class);
				check_basic_class (System.array_class);
				check_basic_class (System.pointer_class);
				check_suppliers_of_unchanged_classes;
			end;
		end;

feature {NONE}

	check_basic_class (a_class: CLASS_I) is
			-- Chech date of basic class `a_class'.
		local
			a_class_c: CLASS_C
		do
			a_class_c := a_class.compiled_class;
			if a_class_c = Void then
				Workbench.change_class (universe.class_named (a_class.class_name, System.root_cluster))
			elseif id_array.item (a_class_c.id) = Not_traversed then
				check_class (a_class_c);
			end;
		end;
	
	check_class (a_class: CLASS_C) is
			-- Check date of associated class of `a_class'.
		require
			good_argument: a_class /= Void;
			consistency: id_array.item (a_class.id) = Not_traversed;
		
		local
			new_date: INTEGER;
			dependant: CLASS_C;
			suppliers: LINKED_LIST [SUPPLIER_CLASS];
			str: ANY;
			file: UNIX_FILE;
			changed: BOOLEAN;
		do
				-- Time check only the valid classes
			if System.class_of_id (a_class.id) /= Void then

					-- Check the date of the associated file of class
					-- `a_class'.
				str := a_class.file_name.to_c;
				new_date := eif_date ($str);
				if new_date = 0 then
						-- File has been removed
					id_array.put (Removed, a_class.id);
				else
					id_array.put (Traversed, a_class.id);
					if new_date /= a_class.date then
						changed := True;
						Workbench.change_class (a_class.lace_class);
					end;
				end;

					-- Recursive check on suppliers
				from
					suppliers := a_class.syntactical_suppliers;
					suppliers.start
				until
					suppliers.offright
				loop
					dependant := suppliers.item.supplier;
					if id_array.item (dependant.id) = Not_traversed then
						check_class (dependant);
					end;
					if id_array.item (dependant.id) = Removed then
						-- Supplier file has been removed
debug ("ACTIVITY")
	io.error.putstring ("file of ");
	io.error.putstring (dependant.class_name);
	io.error.putstring (" has been removed%N");
end;
						if not (new_date = 0 or changed) then
								-- If client file (current class) still exists and is not
								-- already changed...
							Workbench.add_class_to_recompile (a_class.lace_class);
						end;
					end;
					suppliers.forth;
				end;
			end;
		ensure
			consistency: id_array.item (a_class.id) /= Not_traversed
		end;

	check_suppliers_of_unchanged_classes is
			-- Check if there is no conflicts for the suppliers
			-- of the `old' classes but only if the system is moved
			-- i.e. if a class has been added or removed
		local
			new_classes: LINKED_LIST [CLASS_I];
			old_classes: ARRAY [BOOLEAN];
			clusters: LINKED_LIST [CLUSTER_I];
			class_name: STRING;
			cluster: CLUSTER_I;
			class_c: CLASS_C;
			class_i: CLASS_I;
			checked_classes: ARRAY [BOOLEAN];
			clients: LINKED_LIST [CLASS_C];
			check_clients: BOOLEAN;
			i, nb: INTEGER
		do
			new_classes := System.new_classes;
			if not new_classes.empty then
debug ("ACTIVITY")
io.error.putstring ("TIME_CHECK check_suppliers_of_unchanged_classes%N");
end;
				!!old_classes.make (1, System.id_array.count);
				clusters := Universe.clusters;
				from
					new_classes.start
				until
					new_classes.after
				loop
					class_name := new_classes.item.class_name;
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
								old_classes.put (True, class_c.id);
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
					!!checked_classes.make (1, System.id_array.count);
					from
						i := 1;
						nb := old_classes.count
					until
						i > nb
					loop
						if old_classes.item (i) = True then
								-- Valid clients must be checked
debug ("ACTIVITY")
io.error.putstring ("%T%Tcheck clients of ");
io.error.putstring (System.class_of_id (i).class_name);
io.error.putstring ("%N");
end;
							clients := System.class_of_id (i).syntactical_clients;
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
									checked_classes.item (class_c.id) = False
								then
									checked_classes.put (True, class_c.id);
debug ("ACTIVITY")
io.error.putstring ("%T%Tcheck: ");
io.error.putstring (class_c.class_name);
io.error.putstring ("%N");
end;
									class_c.check_suppliers_and_parents
								end;
								clients.forth
							end;
						end;
						i := i + 1;
					end;
				end;
			end;
				-- Display the errors if any
			Error_handler.checksum
		end;

	Not_traversed: 	INTEGER is 0;
	Traversed:		INTEGER is 1;
	Removed:		INTEGER is -1;

feature {NONE} -- Externals

	eif_date (s: ANY): INTEGER is
		external
			"C"
		end;

	c_clname (file_pointer: POINTER): STRING is
		external
			"C"
		end;

end
