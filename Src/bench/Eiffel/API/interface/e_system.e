indexing

	description: 
		"Representation of an Eiffel system."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class E_SYSTEM

inherit
	SHARED_WORKBENCH

	COMPILER_EXPORTER

	SHARED_INST_CONTEXT

	PROJECT_CONTEXT

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize the system.
		do
			create sub_clusters.make (3);
		end;

feature -- Access

	root_class_name: STRING is
			-- Root class name
		do
			Result := System.root_class_name
		end;

	name: STRING is
			-- System name specified in Lace file
		do
			Result := System.name
		end;

	root_cluster: CLUSTER_I is
			-- Root cluster of System
		do
			Result := System.root_cluster
		end

	statistics: SYSTEM_STATISTICS is
			-- Statistics of the Eiffel System
		do
			create Result.make
		end;

	document_path: DIRECTORY_NAME is
			-- Path specified for the documents directory for classes.
			-- Void result implies no document generation
		do
			Result := System.document_path
		end;

	context_diagram_path: DIRECTORY_NAME is
			-- Path where context diagrams should be stored.
		local
			d: DIRECTORY
		do
			create Result.make_from_string (Project_directory_name)
			Result.extend ("Diagrams")
			create d.make (Result)
			if not d.exists then
				d.create_dir
			end
		end

	document_file_name: FILE_NAME is
			-- File name specified for the cluster text generation
			-- Void result implies no document generation
		do	
			Result := System.document_file_name (System.name)
		end;

	sub_clusters: ARRAYED_LIST [CLUSTER_I]
			-- List of top level clusters for Eiffel System

feature -- Access

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
			Result := System.integer_32_class
		end;

	Real_class: CLASS_I is
			-- Class REAL
		once
			Result := System.real_32_class
		end;

	Double_class: CLASS_I is
			-- Class DOUBLE
		once
			Result := System.real_64_class
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

	Bit_class: CLASS_I is
			-- Class BIT_REF
		once
			Result := System.bit_class
		end;

	number_of_classes: INTEGER is
			-- Number of compiled classes in the system
		do
			Result := System.classes.count
		end;

	class_of_id (i: INTEGER): CLASS_C is
			-- Eiffel Class of id `i'
		require
			valid_id: valid_class_id (i)
		do
			Result := System.class_of_id (i)
		end;

	valid_class_id (i: INTEGER): BOOLEAN is
			-- Is the class_type dynamic id `i' valid?
		do
			Result := System.classes.valid_index (i)
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
			tmp: STRING
		do
			if workbench_mode then
				create Result.make_from_string (Workbench_generation_path)
			else
				create Result.make_from_string (Final_generation_path)
			end
			Result.set_file_name (name)
			tmp := Platform_constants.Executable_suffix
			if not tmp.is_empty then
				Result.add_extension (Platform_constants.Executable_suffix)
			end
		end;

	is_precompiled: BOOLEAN is
			-- Is the System precompiled?
		do	
			Result := System.is_precompiled
		end;

feature {COMPILER_EXPORTER, CALL_STACK_ELEMENT, RUN_INFO, ABSTRACT_REFERENCE_VALUE, EXPANDED_VALUE, ATTR_REQUEST, APPLICATION_STATUS}

	valid_dynamic_id (i: INTEGER): BOOLEAN is
			-- Is the class_type dynamic id `i' valid?
		do
			Result := System.class_types.valid_index (i)
		end;

	class_of_dynamic_id (i: INTEGER): CLASS_C is
			-- Eiffel Class of dynamic id `i'
		require
			positive_i: i >= 0;
			valid_i: valid_dynamic_id (i)
		local
			ct: CLASS_TYPE
		do
			ct := System.class_types.item (i);
			if ct /= Void then
				Result := ct.associated_class
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

feature {COMPILER_EXPORTER} -- Element change

	add_sub_cluster (c: CLUSTER_I) is
			-- Add cluster `c' to `sub_clusters.
		require
			valid_c: c /= Void;
			not_added: sub_clusters /= Void
		do
			sub_clusters.extend (c)
		end;

feature {COMPILER_EXPORTER} -- Removal

	wipe_out_sub_clusters is
			-- Wipe out the sub_cluster list.
		do
			sub_clusters.wipe_out
		ensure
			empty_sub_clusters: sub_clusters /= Void
		end;

invariant

	sub_clusters_exists: sub_clusters /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class E_SYSTEM
