deferred class FOO

feature -- Access

	o_procedure
		once ("OBJECT")
			print (" [Execute procedure] ")
		end

	o_numeric: NATURAL
		once ("OBJECT")
			print (" [Get numeric] ")
			Result := 123
		end

	o_string: STRING_32
		once ("OBJECT")
			print (" [Get string] ")
			Result := "a_string"
		end

	o_current: ANY
		once ("OBJECT")
			print (" [Get current] ")
			Result := Current
		end
		
end
