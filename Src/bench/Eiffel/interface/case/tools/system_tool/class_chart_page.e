indexing
	description: "Edit the description of the classes"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	CLASS_CHART_PAGE
	
inherit
	SYSTEM_CHART_PAGE
		redefine
			make
		end

creation
	make

feature -- Initialization

	make (noteb: EV_NOTEBOOK; ent: ANY) is
		do
			precursor ( noteb, ent )
			noteb.append_page(page, "Clusters Chart")
			update_from(system.classes_in_system)
		end

feature -- update

	update is
		do
			update_from(system.classes_in_system)
		end

end -- class CLASS_CHART_PAGE
