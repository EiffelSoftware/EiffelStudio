class
	FUNDAMENTAL_COMPOSITE_DATA_SOURCE [reference G -> ANY]

inherit
	COMPOSITE_DATA_SOURCE
		rename
			make as make_composite
		redefine
			data_source_anchor
		end
		
feature

	data_source_anchor: FUNDAMENTAL_DATA_SOURCE [ANY]

end
