indexing
	description: "All the information about the system";
	date: "$Date$";
	revision: "$Revision$"

class
	SYSTEM_DESCRIPTION

inherit
	PROJECT_CONTEXT

	SHARED_COMPILATION_MODES

	SHARED_ID

feature -- Update

	set_system_name (s: STRING) is
			-- Assign `s' to `system_name'.
		do
			system_name := s
		end

	set_root_cluster (c: CLUSTER_I) is
			-- Assign `c' to `root_cluster'.
		do
			root_cluster := c
		end

	set_root_class_name (s: STRING) is
			-- Assign `s' to `root_class_name'.
		do
			root_class_name := s
		end

	set_creation_name (s: STRING) is
			-- Assign `s' to `creation_name'.
		do
			creation_name := s
		end

	set_c_file_names (l: like c_file_names) is
			-- Assign `l' to `c_file_names'.
		do
			c_file_names := l
		end

	set_include_paths (l: like include_paths) is
			-- Assign `l' to `include_paths'.
		do
			include_paths := l
		end

	set_object_file_names (l: like object_file_names) is
			-- Assign `l' to `object_file_names'.
		do
			object_file_names := l
		end

	set_makefile_names (l: like makefile_names) is
			-- Assign `l' to `makefile_names'.
		do
			makefile_names := l
		end

feature -- Update for the precompilation

	set_compilation_id is
			-- Set `compilation_id' value.
		local
			str: ANY
		do
			if Compilation_modes.is_precompiling then
				str := Project_directory_name.to_c;
				compilation_id := eif_date ($str)
			elseif Compilation_modes.is_extending then
				compilation_id := Dle_compilation
			else
				compilation_id := Normal_compilation
			end
		end

	set_precompilation (b: BOOLEAN) is
		do
			is_precompiled := b
		end

	set_has_precompiled_preobj (b: BOOLEAN) is
			-- Set `has_precompiled_preobj' to `b'.
		do
			has_precompiled_preobj := b
		end

	set_licensed_precompilation (b: BOOLEAN) is
			-- Set `licensed_precompilation' to `b'.
		do
			licensed_precompilation := b
		end

feature -- Access

	system_name: STRING;
			-- System name

	root_cluster: CLUSTER_I;
			-- Root class of the system

	root_class_name: STRING;
			-- Root class name

	creation_name: STRING;
			-- Creation procedure name

	c_file_names: FIXED_LIST [STRING];
			-- C file names to include

	include_paths: FIXED_LIST [STRING];
			-- Include paths to add in the Makefile C flags

	object_file_names: FIXED_LIST [STRING];
			-- Object file names to link with the application

	makefile_names: FIXED_LIST [STRING];
			-- Makefile names to execute before the linking

feature -- Access for the precompilation configuration

	compilation_id: INTEGER
			-- Precompilation identifier

	is_precompiled: BOOLEAN;
			-- Is the Current system from a precompilation?

	uses_precompiled: BOOLEAN;
			-- Does current system use a precompiled library?

	has_precompiled_preobj: BOOLEAN;
			-- Does a `preobj' file exist for the current precompiled project?
			-- This file might not exist as a result of merging precompilations

	licensed_precompilation: BOOLEAN
			-- Is the precompiled library protected by a license?

feature {NONE} -- External

	eif_date (s: POINTER): INTEGER is
			-- Date of file of name `s'.
		external
			"C"
		end;

end -- class SYSTEM_DESCRIPTION
