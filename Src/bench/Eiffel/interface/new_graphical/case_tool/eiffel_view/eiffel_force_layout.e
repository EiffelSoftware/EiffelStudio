indexing
	description: "Objects that is a force directed physics for Eiffel graphs."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_FORCE_LAYOUT

inherit
	EG_FORCE_DIRECTED_LAYOUT
		redefine
			get_link_weight,
			default_create,
			layout
		end
	
create
	make_with_world
	
feature {NONE} -- Initialization

	default_create is
			-- Create an EIFFEL_FORCE_LAYOU
		do
			Precursor {EG_FORCE_DIRECTED_LAYOUT}
			set_inheritance_weight (25)
			set_client_supplier_weight (25)
		end

feature -- Access

	inheritance_weight: INTEGER
	
	client_supplier_weight: INTEGER
	
feature -- Element change

	set_inheritance_weight (a_value: INTEGER) is
			-- 
		require
			percent: a_value > 0 and a_value <= 100
		do
			inheritance_weight := a_value
		ensure
			set: inheritance_weight = a_value
		end
		
	set_client_supplier_weight (a_value: INTEGER) is
			-- 
		require
			percent: a_value > 0 and a_value <= 100
		do
			client_supplier_weight := a_value
		ensure
			set: client_supplier_weight = a_value
		end
		
	layout is
			-- Arrange the elements in `graph'.
		do
			internal_inheritance_weight := (inheritance_weight / 50) / world.scale_factor
			internal_client_supplier_weight := (client_supplier_weight / 50) / world.scale_factor
			Precursor {EG_FORCE_DIRECTED_LAYOUT}
		end
	
feature {NONE} -- Implementation

	internal_inheritance_weight: DOUBLE
	internal_client_supplier_weight: DOUBLE

	get_link_weight (link: EG_LINK_FIGURE): DOUBLE is
			-- 
		local
			i_link: EIFFEL_INHERITANCE_FIGURE
		do
			i_link ?= link
			if i_link = Void then
				Result := internal_client_supplier_weight
			else
				
				Result := internal_inheritance_weight
			end
		end

end -- class EIFFEL_FORCE_LAYOUT
