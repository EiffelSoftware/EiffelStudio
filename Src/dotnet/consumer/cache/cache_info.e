indexing
	description: "EAC information - serialized"
	date: "$Date$"
	revision: "$Revision$"

class
	CACHE_INFO

create
	make

feature {NONE} -- Initalization

	make is
			-- Initialize `assemblies'.
		local
			di: DIRECTORY_INFO
			info_path: STRING
		do
			info_path := (create {CACHE_READER}).Absolute_info_path
			create di.make (info_path.substring (1, info_path.last_index_of ('\', info_path.count)).to_cil)
			di.create_
			create assemblies_info.make (1, 0)
		ensure
			non_void_assemblies_info: assemblies_info /= Void
		end
		
feature -- Access

	assemblies_info: ARRAY [CONSUMED_ASSEMBLY_INFO]
			-- Array of assemblies in EAC

feature {CACHE_WRITER} -- Element Settings
	
	add_assembly (ass_info: CONSUMED_ASSEMBLY_INFO) is
			-- Add `ass_info' to `assemblies'.
		require
			non_void_assembly_info: ass_info /= Void
			valid_assembly: not assemblies_info.has (ass_info)
		do
			assemblies_info.force (ass_info, assemblies_info.count + 1)
		end

	remove_assembly_from_location (ass_location: STRING) is
			-- Remove `ass_location' from `assemblies'.
		require
			non_void_ass_location: ass_location /= Void
			not_empty_ass_location: not ass_location.is_empty
		local
			i, j: INTEGER
			new: ARRAY [CONSUMED_ASSEMBLY_INFO]
		do
			create new.make (1, assemblies_info.count - 1)
			ass_location.to_lower
			from
				i := 1
				j := 1
			until
				i > assemblies_info.count
			loop
				if not assemblies_info.item (i).location.is_equal (ass_location) then
					new.put (assemblies_info.item (i), j)
					j := j + 1
				end
				i := i + 1
			end
			assemblies_info := new
		end

end -- class CACHE_INFO
