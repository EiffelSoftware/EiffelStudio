indexing
	description: "Local cache information"
	date: "$Date$"
	revision: "$Revision$"

class
	LOCAL_CACHE_INFO

inherit
	CACHE_INFO
		rename
			make as make_for_eac
		redefine
			add_assembly
		end

create
	make

feature {NONE} -- Initialization

	make (apath: STRING) is
			-- Initialize `assemblies'.
		require
			non_void_path: apath /= Void
			non_empty_path: not apath.is_empty
			path_exists: (create {DIRECTORY}.make (apath)).exists
		local
			di: DIRECTORY_INFO
			info_path: STRING
		do
			create di.make (apath.substring (1, apath.last_index_of ('\', apath.count)).to_cil)
			di.create_
			create assemblies.make (1, 0)
		ensure
			non_void_assemblies: assemblies /= Void
		end
	
feature {EMITTER, ISE_CACHE_MANAGER}	

	add_assembly (ass: CONSUMED_ASSEMBLY) is
			-- add an assembly to the info
		do
			Precursor (ass)
		end

end -- class LOCAL_CACHE_INFO
