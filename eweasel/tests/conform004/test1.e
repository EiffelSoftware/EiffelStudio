class TEST1 [G -> ANY]

create
	make

feature {NONE} -- Creation

	make (t: G)
		do
			io.put_string ({G})
			io.put_new_line
			if (create {REFLECTOR}).type_conforms_to (t.generating_type.type_id, ({G}).type_id) then
				io.put_string ("OK%N")
			end
		end

end
