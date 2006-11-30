class
	COMPUSTAT_FUNDAMENTAL_COMPOSITE_DATA_SOURCE
inherit
	FUNDAMENTAL_COMPOSITE_DATA_SOURCE [STRING]

create
	make

feature -- Initialization

	make is
		do
			make_composite (<< industrial >>)
		end
		
	industrial: COMPUSTAT_FUNDAMENTAL_DATA_SOURCE

end
