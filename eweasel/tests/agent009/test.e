class TEST
create
	make

feature {NONE}

	make
		local
			a: PROCEDURE [ANY, TUPLE [!STRING]]
		do

			a := agent f
			if not a.valid_operands ([("STRING").as_attached]) then
				io.put_string ("not OK")
				io.put_new_line
			end
		end

	f (a: !STRING) is
		do
		end

end
