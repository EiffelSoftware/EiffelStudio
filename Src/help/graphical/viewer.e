indexing
	description:"Viewer"
	author:"pascalf"

class VIEWER

inherit
	EV_APPLICATION
		redefine
			make
		end

creation
	make

feature -- Initialization

	make is
		-- Launch the viewer
		do
			precursor 
		end

feature -- Access

	first_window: VIEWER_WINDOW is
		once
			!! Result.make_viewer(Current)
		end

	structure: E_DOCUMENT

feature -- Operations

	update(path: STRING) is
			-- Resources specified by the user
		local
			fn: FILE_NAME
		do
			create fn.make_from_string(path)
			create structure.make_from_file_name(fn)
			first_window.update(structure)
		end
	
end --VIEWER