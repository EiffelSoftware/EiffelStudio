indexing
	description: "Lace cluster"
	date: "$$"
	revision: "$$"

class
	ECDP_LACE_CLUSTER

create 
	make,
	make_with_name_and_path
		
feature {NONE} -- Initialization

	make is
			-- Default initialization
		do
			create name.make_empty
			path := ""
			create excludes.make
		ensure
			non_void_name: name /= Void
			non_void_path: path /= Void
			non_void_excludes: excludes /= Void
		end

	make_with_name_and_path (a_name: like name; a_path: like path) is
			-- Initialize `name' with `a_name' an `path' with `a_path'.
		require
			non_void_name: a_name /= Void
			non_empty_name: not a_name.is_empty
			non_void_path: a_path /= Void
			non_empty_path: not a_path.is_empty
		do
			create name.make_from_string (a_name)
			create path.make_from_string (a_path)
			create excludes.make
		ensure
			name_set: name.is_equal (a_name)
			path_set: path.is_equal (a_path)
			non_void_excludes: excludes /= Void
		end

feature -- Access

	name: STRING
			-- Cluster name

	path: STRING
			-- Cluster path

	excludes: LINKED_LIST [STRING]
			-- List of excludes
			
	all_sub_dir: BOOLEAN
			-- add all subdirectories?

feature -- Status Setting
	
	set_name (a_name: like name) is
			-- Set `name' with `a_name'
		require
			non_void_name: a_name /= Void
			non_empty_name: not a_name.is_empty
		do
			name := a_name
		ensure
			name_set: name = a_name
		end

	set_path (a_path: like path) is
			-- Set `path' with `a_path'
		require
			non_void_path: a_path /= Void
			non_empty_path: not a_path.is_empty
		do
			path := a_path
		ensure
			path_set: path = a_path
		end

	set_all_sub_dir (a_bool: like all_sub_dir) is
			-- Set `all_sub_dir' with `a_bool'
		do
			all_sub_dir := a_bool
		ensure
			all_sub_dir_set: all_sub_dir = a_bool
		end

feature -- Basic Operations
	
	add_exclude (an_exclude: STRING) is
			-- Add `an_exclude' to `excludes'
		require
			non_void_exclude: an_exclude /= Void
			non_empty_exclude: not an_exclude.is_empty
		do
			excludes.extend (an_exclude)
		ensure
			excludes_set: excludes.has (an_exclude)
		end

invariant
	non_void_name: name /= Void
	non_void_path: path /= Void
	non_void_excludes: excludes /= Void

end -- class ECDP_LACE_CLUSTER

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------