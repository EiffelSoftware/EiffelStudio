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
		do
			create Result.make (a_key.count * 2)
			from
				i := 0	
			until
				i >= a_key.count
			loop
				Result.append (a_key.item (i).to_hex_string)
				i := i + 1
			end
			Result.to_lower
		ensure
			Result_not_void: Result /= Void
		end

end -- class KEY_ENCODER
