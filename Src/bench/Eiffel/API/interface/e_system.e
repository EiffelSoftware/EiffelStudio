indexing

	description: 
		"Representation of an Eiffel system.";
	date: "$Date$";
	revision: "$Revision $"

class E_SYSTEM

inherit

	SHARED_WORKBENCH;
	COMPILER_EXPORTER;
	SHARED_INST_CONTEXT;
	SHARED_MELT_ONLY;
	PROJECT_CONTEXT

feature -- Properties

	root_class_name: STRING is
			-- Root class name
		do
			Result := System.root_class_name
		end;

	name: STRING is
			-- System name specified in Lace file
		do
			Result := System.system_name
		end;

	root_cluster: CLUSTER_I is
			-- Root cluster of System
		do
			Result := System.root_cluster
		end

	statistics: SYSTEM_STATISTICS is
			-- Statistics of the Eiffel System
		do
			!! Result.make
		end;

	document_path: DIRECTORY_NAME is
			-- Path specified for the documents directory for classes.
			-- Void result implies no document generation
		do
			Result := System.document_path
		end;

	document_file_name: FILE_NAME is
			-- File name specified for the cluster text generation
			-- Void result implies no document generation
		do	
			Result := System.document_file_name
		end

feature -- Access

	cluster: CLUSTER_I is		
		obsolete "to be removed"
		do
			Result := Inst_context.cluster;
		end;

	Any_id: CLASS_ID is
			-- Identification for class ANY
		require
			compiled: Any_class.compiled
		once
			Result := System.any_id
		end;

	Any_class: CLASS_I is
			-- class ANY
		once
			Result := System.any_class
		end;

	Boolean_class: CLASS_I is
			-- Class BOOLEAN
		once
			Result := System.boolean_class
		end;

	Character_class: CLASS_I is
			-- Class CHARACTER
		once
			Result := System.character_class
		end;

	Integer_class: CLASS_I is
			-- Class INTEGER
		once
			Result := System.integer_class
		end;

	Real_class: CLASS_I is
			-- Class REAL
		once
			Result := System.real_class
		end;

	Double_class: CLASS_I is
			-- Class DOUBLE
		once
			Result := System.double_class
		end;

	Pointer_class: CLASS_I is
			-- Class POINTER
		once
			Result := System.pointer_class
		end;

	String_class: CLASS_I is
			-- Class STRING
		once
			Result := System.string_class
		end;

	Array_class: CLASS_I is
		once
			Result := System.array_class
		end;

	Special_class: CLASS_I is
			-- Class SPECIAL
		once
			Result := System.special_class
		end;

	To_special_class: CLASS_I is
			-- Class TO_SPECIAL
		once
			Result := System.to_special_class
		end;

	Bit_class: CLASS_I is
			-- Class BIT_REF
		once
			Result := System.bit_class
		end;

	number_of_classes: INTEGER is
			-- Number of compiled classes in the system
		do
			Result := System.nb_of_classes;
		end;

	class_of_id (i: CLASS_ID): E_CLASS is
			-- Eiffel Class of id `i'
		require
			valid_id: i /= Void
		do
			Result := System.class_of_id (i)
		end;

	root_class: CLASS_I is
			-- Root class of the system
		do
			Result := root_cluster.classes.item (root_class_name);
		end;

	application_name (workbench_mode: BOOLEAN): FILE_NAME is
			-- Get the full qualified name of the application
			-- For workbench-mode application `compile_type' is true
		require
			non_void_name: name /= Void
		local
			temp: STRING
		do
			if melt_only then
				Result := (Precompilation_driver)
			else
				!! temp.make (0);
				temp.append (name);
				temp.append (Executable_suffix);
				if workbench_mode then
					!! Result.make_from_string (Workbench_generation_path);
				else
					!! Result.make_from_string (Final_generation_path);
				end;
				Result.set_file_name (temp);
			end;
		end;

	is_precompiled: BOOLEAN is
			-- Is the System precompiled?
		do	
			Result := System.is_precompiled
		end;

feature {COMPILER_EXPORTER, CALL_STACK_ELEMENT, RUN_INFO, REFERENCE_VALUE, EXPANDED_VALUE, ATTR_REQUEST, APPLICATION_STATUS}

	valid_dynamic_id (i: INTEGER): BOOLEAN is
			-- Is the class_type dynamic id `i' valid?
		do
			Result := System.class_types.valid_index (i)
		end;

	class_of_dynamic_id (i: INTEGER): E_CLASS is
			-- Eiffel Class of dynamic id `i'
		require
			positive_i: i >= 0;
			valid_i: valid_dynamic_id (i)
		local
			ct: CLASS_TYPE
		do
			ct := System.class_types.item (i);
			if ct /= Void then
				Result := ct.associated_eclass
			end
		end;

	type_of_dynamic_id (i: INTEGER): CLASS_TYPE is
			-- Class type of dynamic id `id'
		require
			positive_i: i >= 0;
			valid_i: valid_dynamic_id (i)
		do
			Result := System.class_types.item (i)
		end

end -- class E_SYSTEM
