indexing
	description: "EAC information - serialized"
	date: "$Date$"
	revision: "$Revision$"

class
	CACHE_INFO

create
	make
feature {NONE} -- Initalization

	make (a_clr_version: STRING) is
			-- Initialize `assemblies'.
		require
			a_clr_version_not_void: a_clr_version /= Void
		local
			di: DIRECTORY_INFO
			info_path: STRING
		do
			info_path := (create {CACHE_READER}.make (a_clr_version)).Absolute_info_path
			create di.make (info_path.substring (1, info_path.last_index_of ('\', info_path.count)).to_cil)
			di.create_
			create assemblies.make (1, 0)
			assemblies.compare_objects
			clr_version := a_clr_version
		ensure
			non_void_assemblies: assemblies /= Void
			clr_version_set: clr_version = a_clr_version
		end
		
feature -- Access

	assemblies: ARRAY [CONSUMED_ASSEMBLY]
			-- Array of assemblies in EAC
			
	clr_version: STRING
			-- Runtime version.
			
	is_dirty: BOOLEAN
			-- Is info ditry?

feature {CACHE_WRITER} -- Element Settings
	
	add_assembly (ass: CONSUMED_ASSEMBLY) is
			-- Add `ass' to `assemblies'.
		require
			non_void_assembly: ass /= Void
			valid_assembly: not assemblies.has (ass)
		do
			assemblies.force (ass, assemblies.count + 1)
			set_is_dirty (True)
		end
		
	update_assembly (a_assembly: CONSUMED_ASSEMBLY) is
			-- Updates `a_assembly' in `assemblies'
		require
			non_void_assembly: a_assembly /= Void
			valid_assembly: assemblies.has (a_assembly)
		local
			i: INTEGER
			l_done: BOOLEAN
		do
			from 
				i := 1
			until
				l_done or i > assemblies.count
			loop
				if assemblies.item (i).is_equal (a_assembly) then
					assemblies.put (a_assembly, i)
					set_is_dirty (True)
					l_done := True
				else
					i := i + 1
				end
				
			end
		end

	remove_assembly (ass: CONSUMED_ASSEMBLY) is
			-- Remove `ass' from `assemblies'.
		require
			non_void_assembly: ass /= Void
			--valid_assembly: assemblies.has (ass)
		local
			i, j: INTEGER
			new: ARRAY [CONSUMED_ASSEMBLY]
		do
			create new.make (1, assemblies.count - 1)
			if assemblies.object_comparison then
				new.compare_objects
			end
			from
				i := 1
				j := 1
			until
				i > assemblies.count
			loop
				if not assemblies.item (i).is_equal (ass) then
					new.put (assemblies.item (i), j)
					set_is_dirty (True)
					j := j + 1
				end
				i := i + 1
			end
			assemblies := new
		ensure
			removed: not assemblies.has (ass)
		end
		
	set_is_dirty (a_dirty: BOOLEAN) is
			-- Sets `is_dirty' with `a_dirty'
		do
			is_dirty := a_dirty
		ensure
			is_dirty_set: is_dirty = a_dirty
		end
		
invariant
	non_void_assemblies: assemblies /= Void
	
end -- class CACHE_INFO
