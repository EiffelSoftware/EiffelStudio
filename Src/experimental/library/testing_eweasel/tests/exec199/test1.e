class TEST1 [G -> ANY create default_create end]

create
	make

feature {NONE} -- Initialization

	make is
		do
			create list.make
		end

feature

	dummy_event_data: G is
		do
			if dummy_event_data_internal = Void then
				create dummy_event_data_internal
			end
			Result := dummy_event_data_internal
		end

	dummy_event_data_internal: G

	list: LINKED_LIST [like g]

	g: ANY

end

