deferred class A

feature

	natural_constant: NATURAL_8 = 0
			-- A basic type constant.

	natural_external: NATURAL_16
			-- A basic type external function.
		note
			option: instance_free
		external "C inline"
			alias "[
				return (EIF_NATURAL_16) 2;
			]"
		end

	natural_function: NATURAL_32
			-- A basic type function.
		note
			option: instance_free
		do
			Result := 0
		end

	natural_once: NATURAL_64
			-- A basic type once function.
		note
			option: instance_free
		once
			Result := 0
		end

	string_constant: STRING_32 = ""
			-- A reference type constant.

	string_function: STRING_32
			-- A reference type function.
		note
			option: instance_free
		do
			Result := {STRING_32} ""
		end

	string_once: STRING_32
			-- A reference type once function.
		note
			option: instance_free
		once
			Result := {STRING_32} ""
		end

	string_external (argument: STRING_32): STRING_32
			-- A reference type external function.
		note
			option: instance_free
		external "C inline"
			alias "[
				return eif_access ($argument);
			]"
		end

end