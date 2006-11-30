class
	COMPOSITE_DATA_SOURCE

feature

	make (a_source: ARRAY [like data_source_anchor]) is
		do
			create data_sources.make
		end
		
feature -- Access

    data_sources: LINKED_LIST [like data_source_anchor]

feature {NONE}

	data_source_anchor: DATA_SOURCE is do end

end
