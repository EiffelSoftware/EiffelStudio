note

	description: "Representation of an Eiffel system."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class E_SYSTEM

inherit
	SHARED_WORKBENCH

	COMPILER_EXPORTER

	SHARED_INST_CONTEXT

	PROJECT_CONTEXT

	SYSTEM_CONSTANTS

	EIFFEL_LAYOUT
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize the system.
		do
			create sub_clusters.make (3);
		end;

feature -- Access

	name: STRING
			-- System name specified in Lace file
		do
			Result := System.name
		end;

	document_path: PATH
			-- Path specified for the documents directory for classes.
			-- Void result implies no document generation
		do
			Result := System.document_path
		end;

	context_diagram_path: like {PROJECT_DIRECTORY}.path
			-- Path where context diagrams should be stored.
		local
			u: GOBO_FILE_UTILITIES
		do
			Result := project_location.target_path.extended ("Diagrams")
			u.create_directory_path (Result)
		end

	document_file_name: PATH
			-- File name specified for the cluster text generation
			-- Void result implies no document generation
		do
			Result := System.document_file_name (System.name)
		end;

	sub_clusters: ARRAYED_LIST [CLUSTER_I]
			-- List of top level clusters for Eiffel System

feature -- Access

	Any_class: CLASS_I
			-- class ANY
		once
			Result := System.any_class
		end;

	Boolean_class: CLASS_I
			-- Class BOOLEAN
		once
			Result := System.boolean_class
		end;

	Character_class: CLASS_I
			-- Class CHARACTER
		once
			Result := System.character_8_class
		end;

	Integer_class: CLASS_I
			-- Class INTEGER
		once
			Result := System.integer_32_class
		end;

	Real_class: CLASS_I
			-- Class REAL
		once
			Result := System.real_32_class
		end;

	Double_class: CLASS_I
			-- Class DOUBLE
		once
			Result := System.real_64_class
		end;

	Pointer_class: CLASS_I
			-- Class POINTER
		once
			Result := System.pointer_class
		end;

	String_class: CLASS_I
			-- Class STRING
		once
			Result := System.string_8_class
		end;

	Array_class: CLASS_I
		once
			Result := System.array_class
		end;

	Special_class: CLASS_I
			-- Class SPECIAL
		once
			Result := System.special_class
		end;

	number_of_classes: INTEGER
			-- Number of compiled classes in the system
		do
			Result := System.classes.count
		end;

	class_of_id (i: INTEGER): detachable CLASS_C
			-- Eiffel Class of id `i'
		require
			valid_id: valid_class_id (i)
		do
			Result := System.class_of_id (i)
		end

	valid_class_id (i: INTEGER): BOOLEAN
			-- Is the class_type dynamic id `i' valid?
		do
			Result := System.has_class_of_id (i)
		end;

	application_name (workbench_mode: BOOLEAN): PATH
			-- Get the full qualified name of the application
			-- For workbench-mode application `compile_type' is true
		require
			non_void_name: name /= Void
		do
			if workbench_mode then
				Result := project_location.workbench_path
			else
				Result := project_location.final_path
			end
			Result := Result.extended (name + eiffel_layout.executable_suffix)
		end;

	is_precompiled: BOOLEAN
			-- Is the System precompiled?
		do
			Result := workbench.system /= Void and then workbench.System.is_precompiled
		end;

feature {COMPILER_EXPORTER}

	valid_dynamic_id (i: INTEGER): BOOLEAN
			-- Is the class_type dynamic id `i' valid?
		do
			Result := System.class_types.valid_index (i)
		end;

	class_of_dynamic_id (i: INTEGER; a_is_final: BOOLEAN): CLASS_C
			-- Eiffel Class of dynamic id `i'
		require
			positive_i: i >= 0;
			valid_i: valid_dynamic_id (i)
		local
			ct: CLASS_TYPE
		do
			ct := type_of_dynamic_id (i, a_is_final)
			if ct /= Void then
				Result := ct.associated_class
			end
		end;

	type_of_dynamic_id (i: INTEGER; a_is_final: BOOLEAN): CLASS_TYPE
			-- Class type of dynamic id `id'
		require
			positive_i: i >= 0;
			valid_i: valid_dynamic_id (i)
		local
			l_mapping: ARRAY [INTEGER]
		do
			if a_is_final then
				l_mapping := system.retrieved_finalized_type_mapping
				if l_mapping /= Void then
					Result := system.class_types.item (l_mapping.item (i))
				end
			else
				Result := System.class_types.item (i)
			end
		end

feature {COMPILER_EXPORTER} -- Element change

	add_sub_cluster (c: CLUSTER_I)
			-- Add cluster `c' to `sub_clusters.
		require
			valid_c: c /= Void;
			not_added: sub_clusters /= Void
		do
			sub_clusters.extend (c)
		end;

feature {COMPILER_EXPORTER} -- Removal

	wipe_out_sub_clusters
			-- Wipe out the sub_cluster list.
		do
			sub_clusters.wipe_out
		ensure
			empty_sub_clusters: sub_clusters /= Void
		end;

invariant

	sub_clusters_exists: sub_clusters /= Void

note
	copyright:	"Copyright (c) 1984-2019, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
