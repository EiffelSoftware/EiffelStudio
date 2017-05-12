note
	description: "Xorshift random number generators form a class of pseudorandom number generators "
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=XOR shift", "src=http://en.wikipedia.org/wiki/Xorshift", "protocol=uri"
	EIS: "name=XORSHIFT Paper", "src=http://www.jstatsoft.org/v08/i14/paper", "protocol=uri"

class
	XOR_SHIFT_64
create
	make

feature {NONE} -- Initialization

	make (a_seed: INTEGER_64)
			-- Create a new instance of XOR_SHIFT_64.
		do
			if a_seed = 0 then
				x := 0xdeadbeef
			else
				x := a_seed
			end
		end

feature -- Random

	random: INTEGER_64
			-- New random
		do
			x := x.bit_xor (x |<< 21)
			x := x.bit_xor (x |>> 35)
			x := x.bit_xor (x |<< 4)
			Result := x
		end

feature {NONE} -- Implementation

	x: INTEGER_64
		-- internal bit shifted	
;note
	copyright: "Copyright (c) 1984-2017, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
