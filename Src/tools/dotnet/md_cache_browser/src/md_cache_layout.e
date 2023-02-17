note
	description: "Summary description for {MD_CACHE_LAYOUT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MD_CACHE_LAYOUT

create
	make

feature {NONE} -- Initialization

	make (a_root: PATH)
		do
			root := a_root
		end

feature -- Access

	root: PATH

feature -- Access

	cache_info_location: PATH
		do
			Result := root.extended ("eac.info")
		end

	assembly_folder_location (ass: CONSUMED_ASSEMBLY): PATH
		do
			Result := root.extended (ass.folder_name)
		end

	referenced_assemblies_location (ass: CONSUMED_ASSEMBLY): PATH
		do
			Result := assembly_folder_location (ass).extended ("referenced_assemblies.info")
		end

	types_location (ass: CONSUMED_ASSEMBLY): PATH
		do
			Result := assembly_folder_location (ass).extended ("types.info")
		end

	classes_location (ass: CONSUMED_ASSEMBLY): PATH
		do
			Result := assembly_folder_location (ass).extended ("classes.info")
		end

	relative_path (p: PATH): STRING_32
		local
			s, s_root: STRING_32
		do
			Result := p.name
			s_root := root.name
			if Result.starts_with_general (s_root) then
				Result.remove_head (s_root.count + 1)
			end
		end


end
