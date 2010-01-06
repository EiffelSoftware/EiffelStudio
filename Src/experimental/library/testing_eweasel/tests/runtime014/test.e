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
		do
			create dll.make("test.dll")
			create str.make ("test")
			ptr := loal_api (dll.item, str.item)
			if ptr = default_pointer then
				get_last_error.do_nothing
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
