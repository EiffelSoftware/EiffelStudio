-- Time checker

class TIME_CHECKER 

inherit

	SHARED_WORKBENCH

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
					-- Cannot remove simple classes
				check_basic_class (System.boolean_class.compiled_class);
				check_basic_class (System.character_class.compiled_class);
				check_basic_class (System.integer_class.compiled_class);
				check_basic_class (System.real_class.compiled_class);
				check_basic_class (System.double_class.compiled_class);
				check_basic_class (System.bit_class.compiled_class);
				check_basic_class (System.string_class.compiled_class);
				check_basic_class (System.array_class.compiled_class);
				check_basic_class (System.pointer_class.compiled_class);
			end;
		end;

feature {NONE}

	check_basic_class (a_class: CLASS_C) is
			-- Chech date of basic class `a_class'.
		require
			good_argument: a_class /= Void
		do
			if id_array.item (a_class.id) = Not_traversed then
				check_class (a_class);
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
			parents: FIXED_LIST [CL_TYPE_A];
			suppliers: LINKED_LIST [SUPPLIER_CLASS];
			str: ANY;
			file: UNIX_FILE;
			new_class_name: STRING;
			changed: BOOLEAN;
		do
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
						-- Check class name: if changed then recompile clients
						-- also.
					!!file.make (a_class.file_name);
					file.open_read;
					new_class_name := c_clname (file.file_pointer);
					new_class_name.to_lower;
					file.close;
					if not new_class_name.is_equal (a_class.class_name) then
							-- Update class_name
						a_class.change_name (new_class_name);
					end;
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
							-- If client file still exists and is not
							-- already changed...
						Workbench.change_class (a_class.lace_class);
					end;
				end;
				suppliers.forth;
			end;

		ensure
			consistency: id_array.item (a_class.id) /= Not_traversed
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
