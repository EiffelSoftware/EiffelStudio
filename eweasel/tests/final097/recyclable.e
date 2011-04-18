class
	RECYCLABLE

inherit
	USABLE

feature

	is_interface_usable: BOOLEAN
		do
			Result := is_done
		end


	is_done: BOOLEAN

end
