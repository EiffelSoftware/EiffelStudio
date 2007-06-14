indexing

	description:

		"Interface for platform-dependent properties"

	library: "Gobo Eiffel Kernel Library"
	copyright: "Copyright (c) 2002-2004, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

deferred class KI_PLATFORM


inherit

	PLATFORM
		rename

			Minimum_character_code as old_minimum_character_code,
			Maximum_character_code as old_maximum_character_code,
			Minimum_integer as old_minimum_integer,
			Maximum_integer as old_maximum_integer,

			Boolean_bits as old_boolean_bits,
			Character_bits as old_character_bits,
			Double_bits as old_double_bits,
			Integer_bits as old_integer_bits,
			Pointer_bits as old_pointer_bits,
			Real_bits as old_real_bits
		end


feature -- Bits

	Boolean_bits: INTEGER is
			-- Number of bits in a value of type BOOLEAN
		deferred
		ensure
			large_enough: Result >= 1
			-- Note: Postcondition commented out to avoid recursive
			-- call in once-function in KL_PLATFORM:
			-- small_enough: Result <= Boolean_bytes * Byte_bits
		end

	Byte_bits: INTEGER is 8
			-- Number of bits in a byte

	Character_bits: INTEGER is
			-- Number of bits in a value of type CHARACTER
		deferred
		ensure
			-- Note: Postcondition commented out to avoid recursive
			-- call in once-function in KL_PLATFORM:
			-- definition: Result = Character_bytes * Byte_bits
			more_than_byte: Result >= Byte_bits
		end

	Double_bits: INTEGER is
			-- Number of bits in a value of type DOUBLE
		deferred
		ensure
			-- Note: Postcondition commented out to avoid recursive
			-- call in once-function in KL_PLATFORM:
			-- definition: Result = Double_bytes * Byte_bits
			more_than_real: Result >= Real_bits
		end

	Integer_bits: INTEGER is
			-- Number of bits in a value of type INTEGER
		deferred
		ensure
			-- Note: Postcondition commented out to avoid recursive
			-- call in once-function in KL_PLATFORM:
			-- definition: Result = Integer_bytes * Byte_bits
			more_than_character: Result >= Character_bits
		end

	Pointer_bits: INTEGER is
			-- Number of bits in a value of type POINTER
		deferred
		ensure
			-- Note: Postcondition commented out to avoid recursive
			-- call in once-function in KL_PLATFORM:
			-- definition: Result = Pointer_bytes * Byte_bits
		end

	Real_bits: INTEGER is
			-- Number of bits in a value of type REAL
		deferred
		ensure
			-- Note: Postcondition commented out to avoid recursive
			-- call in once-function in KL_PLATFORM:
			-- definition: Result = Real_bytes * Byte_bits
		end

feature -- Bytes

	Boolean_bytes: INTEGER is
			-- Number of bytes in a value of type BOOLEAN
		deferred
		ensure
			meaningful: Result >= 1
		end

	Byte_bytes: INTEGER is 1
			-- Number of bytes in a byte

	Character_bytes: INTEGER is
			-- Number of bytes in a value of type CHARACTER
		deferred
		ensure
			meaningful: Result >= 1
			more_than_byte: Result >= Byte_bytes
		end

	Double_bytes: INTEGER is
			-- Number of bytes in a value of type DOUBLE
		deferred
		ensure
			meaningful: Result >= 1
			more_than_real: Result >= Real_bytes
		end

	Integer_bytes: INTEGER is
			-- Number of bytes in a value of type INTEGER
		deferred
		ensure
			meaningful: Result >= 1
			more_than_character: Result >= Character_bytes
		end

	Pointer_bytes: INTEGER is
			-- Number of bytes in a value of type POINTER
		deferred
		ensure
			meaningful: Result >= 1
		end

	Real_bytes: INTEGER is
			-- Number of bytes in a value of type REAL
		deferred
		ensure
			meaningful: Result >= 1
		end

feature -- Values

	Minimum_byte_code: INTEGER is 0
			-- Smallest supported code for a byte

	Maximum_byte_code: INTEGER is 255
			-- Largest supported code for a byte

	Minimum_character_code: INTEGER is
			-- Smallest supported code for CHARACTER values
		deferred
		ensure
			meaningful: Result = 0
		end

	Maximum_character_code: INTEGER is
			-- Largest supported code for CHARACTER values
		deferred
		ensure
			meaningful: Result >= Maximum_byte_code



			-- Problem with ^ in SE 2.1b1, and with ISE 5.6 for .NET:
			-- definition: Result = (2 ^ Character_bits) - 1

		end

	Minimum_integer: INTEGER is
			-- Smallest supported value of type INTEGER
		deferred
		ensure
			meaningful: Result <= 0
				-- Result = - (2 ^ (Integer_bits - 1)):



			-- Problem with ^ in SE 2.1b1:
			-- definition: Result = (2 ^ (Integer_bits - 2)) * -2

		end

	Maximum_integer: INTEGER is
			-- Largest supported value of type INTEGER
		deferred
		ensure
			meaningful: Result >= 0
				-- Result = 2 ^ (Integer_bits - 1) - 1:
			definition: Result = - (Minimum_integer + 1)
		end

end
