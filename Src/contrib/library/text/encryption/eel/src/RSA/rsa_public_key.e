note
	description: "Summary description for {RSA_KEY}."
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "Tyranny is always better organized than freedom. - Charles Peguy"

class
	RSA_PUBLIC_KEY

inherit
	DEBUG_OUTPUT

create
	make

feature
	make (modulus_a: INTEGER_X exponent_a: INTEGER_X)
		do
			modulus := modulus_a
			exponent := exponent_a
		end

	verify (message: INTEGER_X signature: INTEGER_X): BOOLEAN
		do
			result := encrypt (signature) ~ message
		end

	encrypt (message: INTEGER_X): INTEGER_X
		do
			result := message.powm_value (exponent, modulus)
		end

feature
	modulus: INTEGER_X
	exponent: INTEGER_X

feature {RSA_KEY_PAIR}--{DEBUG_OUTPUT}
	debug_output: STRING
		do
			result := "Modulus: 0x" + modulus.out_hex
		end
end
