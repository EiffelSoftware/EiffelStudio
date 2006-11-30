deferred class
	FUNDAMENTAL_DATA_SOURCE [reference G -> ANY]
	
inherit
	FUNDAMENTAL_COMPOSITE_DATA_SOURCE [G]
		redefine
			data_sources
		end
		
	DATA_SOURCE

feature
	
	data_sources: LINKED_LIST [FUNDAMENTAL_DATA_SOURCE [ANY]]

end
