indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SYSTEM_MODIF_PAGE

inherit
	EDITOR_WINDOW_PAGE
		redefine
			make
		end
creation
	make

feature -- Initialization

	make (noteb: EV_NOTEBOOK; ent: ANY) is
			-- Initialize
		do
			precursor ( noteb, ent)
			notebook.append_page(page, "Modified Classes")
			!! area.make(page)
		end

feature {NONE} -- Implementation 

	area: EV_TEXT_AREA	


feature -- Access

	reset, do_page is do end

	update is do end

end -- class SYSTEM_MODIF_PAGE
