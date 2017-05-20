class
	TEST

inherit
	WEL_API

create
	make

feature {NONE} -- Initialization

	make
		local
			dll: WEL_DLL
			str: C_STRING
			ptr: POINTER
			err: INTEGER
		do
			create dll.make("test.dll")
			create str.make ("test")
			ptr := load_api (dll.item, str.item)
			err := get_last_error
			if ptr = default_pointer then
				io.put_string ("Failed to get a proc address. Error code: ")
				io.put_integer (err)
				io.put_new_line
			else
				$BEFORE_DLL_CALL
				call(ptr)
				$AFTER_DLL_CALL
			end
		end

	call (ptr: POINTER)
		external "C inline"
			alias "[
				(FUNCTION_CAST(void, ()) $ptr) ();
			]"
		end
end
