deferred class A

feature

	natural_constant: NATURAL_8 = 0
			-- A basic type constant.

	natural_external: NATURAL_16
			-- A basic type external function.
		external "C inline"
			alias "[
				return (EIF_NATURAL_16) 2;
			]"
		ensure
			is_instance_free: class
		end

	natural_function: NATURAL_32
			-- A basic type function.
		do
			Result := 0
		ensure
			is_instance_free: class
		end

	natural_once: NATURAL_64
			-- A basic type once function.
		once
			Result := 0
		ensure
			is_instance_free: class
		end

	string_constant: STRING_32 = ""
			-- A reference type constant.

	string_function: STRING_32
			-- A reference type function.
		do
			Result := {STRING_32} ""
		ensure
			is_instance_free: class
		end

	string_once: STRING_32
			-- A reference type once function.
		once
			Result := {STRING_32} ""
		ensure
			is_instance_free: class
		end

	string_external (argument: STRING_32): STRING_32
			-- A reference type external function.
		external "C inline"
			alias "[
				return eif_access ($argument);
			]"
		ensure
			is_instance_free: class
		end

end