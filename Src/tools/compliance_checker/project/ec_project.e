indexing
	description: "[
		Compliance checker project settings.
	]"
	author     : "$Author$"
	date       : "$Date$"
	revision   : "$Revision$"

class
	EC_PROJECT_SETTINGS

create
	make_empty
	
feature {NONE} -- Initialization
	
	make_empty is
			-- Create an initialize a new empty project
		do
			create assembly.make_empty
			create internal_reference_paths.make (1)
			internal_reference_paths.compare_objects
		end

feature -- Access

	is_dirty: BOOLEAN assign set_is_dirty
			-- Has the project been modified?

	reference_paths: LIST [STRING] is
			-- List of reference paths to resolve `assembly' references.
		do
			Result := internal_reference_paths
		ensure
			result_not_void: Result /= Void
			result_compares_objects: Result.object_comparison
		end

	assembly: STRING assign set_assembly
			-- Assembly path to check for compliance.
			
feature -- Element change

	set_is_dirty (an_is_dirty: like is_dirty) is
			-- Set `is_dirty' to `an_is_dirty'.
		do
			is_dirty := an_is_dirty
		ensure
			is_dirty_assigned: is_dirty = an_is_dirty
		end

	set_assembly (a_assembly: like assembly) is
			-- Set `assembly' to `a_assembly'.
		require
			a_assembly_not_void: a_assembly /= Void
		do
			if not is_dirty and then not assembly.is_case_insensitive_equal (a_assembly) then
				is_dirty := True
			end
			assembly := a_assembly
		ensure
			assembly_assigned: assembly = a_assembly
			is_dirty: (not assembly.is_case_insensitive_equal (a_assembly)) implies is_dirty
		end

feature -- Basic operations

	add_reference_path (a_path: STRING) is
			-- Adds `a_path' to `reference_paths'
		require
			a_path_not_void: a_path /= Void
			not_a_path_is_empty: not a_path.is_empty
			not_reference_paths_has_a_path: not reference_paths.has (a_path)
		do
			internal_reference_paths.extend (a_path)
			is_dirty := True
		ensure
			a_path_added: reference_paths.has (a_path)
			is_dirty: is_dirty
		end

feature -- Replacement

	replace_reference_path (a_old: STRING; a_new: STRING) is
			-- Replaces `a_old' reference path with `a_new'
		require
			a_old_not_void: a_old /= Void
			not_a_old_is_empty: not a_old.is_empty
			reference_paths_has_a_old: reference_paths.has (a_old)
			a_new_not_void: a_new /= Void
			not_a_new_is_empty: not a_new.is_empty
		local
			l_list: like internal_reference_paths
			l_cursor: CURSOR
		do
			l_list := internal_reference_paths
			l_cursor := l_list.cursor
			
			l_list.start
			l_list.search (a_old)
			if not l_list.after then
				l_list.replace (a_new)
				is_dirty := True
			end
			
			l_list.go_to (l_cursor)
		ensure
			a_old_removed: not reference_paths.has (a_old)
			a_new_added: reference_paths.has (a_new)
			is_dirty: is_dirty
		end

feature -- Removal

	remove_reference_path (a_path: STRING) is
			-- Removed `a_path' from `reference_paths'
		require
			a_path_not_void: a_path /= Void
			reference_paths_has_a_path: reference_paths.has (a_path)
		local
			l_list: like internal_reference_paths
			l_cursor: CURSOR
		do
			l_list := internal_reference_paths
			l_cursor := l_list.cursor
			
			l_list.start
			l_list.search (a_path)
			if not l_list.after then
				l_list.remove
				is_dirty := True
			end
			
			l_list.go_to (l_cursor)
		ensure
			a_path_removed: not reference_paths.has (a_path)
			is_dirty: is_dirty
		end
		
feature {NONE} -- Implementation

	internal_reference_paths: ARRAYED_LIST [STRING]
			-- Mutable list of reference paths.

invariant
	assembly_not_void: assembly /= Void
	internal_reference_paths_not_void: internal_reference_paths /= Void
	internal_reference_paths_compares_objects: internal_reference_paths.object_comparison

end -- class EC_PROJECT_SETTINGS
