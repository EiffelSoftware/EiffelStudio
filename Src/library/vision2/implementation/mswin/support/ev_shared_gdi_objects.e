indexing
	description: "Records GDI objects used in system to limit their number"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_SHARED_GDI_OBJECTS

feature

	allocated_pens: EV_GDI_ALLOCATED_PENS is
		once
			create Result
		end

	allocated_brushes: EV_GDI_ALLOCATED_BRUSHES is
		once
			create Result
		end

end -- class EV_SHARED_GDI_OBJECTS
