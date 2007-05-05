class TEST

create
	make

feature -- Initialization

	make is
		local
			l_attributes: NATIVE_ARRAY [SYSTEM_OBJECT]
			l_object: SYSTEM_OBJECT
		do
			create a
			l_object := a

				-- Check that we can retrieve all custom attributes
			l_attributes := l_object.get_type.get_custom_attributes (True)
			check l_attributes /= Void end
		end

	a: A [STORE_PERMISSION_FLAGS, STRING]

end
