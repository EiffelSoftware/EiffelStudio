indexing
	description: "Provide formatting of assembly public key tokens"

class
	KEY_ENCODER

feature -- Access

	encoded_key (a_key: NATIVE_ARRAY [INTEGER_8]): STRING is
			-- Printable representation of `a_key'
		require
			a_key_not_void: a_key /= Void
		local
			i: INTEGER
			hex_rep: STRING
			x_string: STRING
		do
			x_string := "X";
			Result := ""
			from
				i := 0	
			until
				i >= a_key.count
			loop
				create hex_rep.make_from_cil (a_key.item (i).to_string_string2 (x_string.to_cil).to_lower)
				if hex_rep.count < 2 then
					hex_rep.prepend ("0")
				end
				Result.append (hex_rep)
				i := i + 1
			end
		ensure
			Result_not_void: Result /= Void
		end

end -- class KEY_ENCODER
