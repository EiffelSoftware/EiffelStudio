indexing
	description: "Node for integer constant. Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class INTEGER_CONSTANT

inherit
	ATOMIC_AS
		redefine
			is_integer
		end

create
	make_with_value, make_from_string, make_from_hexa_string

feature {NONE} -- Initialization

	make_with_value (v: INTEGER) is
			-- Create an integer constant of size 32.
		do
			size := 32
			is_integer := True
			compatibility_size := 32
			is_initialized := True
			constant_type := Void
			string_value := v.out
		ensure
			size_set: size = 32
			is_integer_set: is_integer
			is_initialized_set: is_initialized
		end

feature {NONE} -- Initialization

	make_from_string (a_type: like constant_type; is_neg: BOOLEAN; s: STRING) is
			-- Create a new INTEGER AST node.
			-- Set `is_initialized' to true if the string denotes a value that is
			-- within allowed integer bounds. Otherwise set `is_iniialized' to false.
		require
			valid_type: a_type /= Void implies (a_type.is_integer or a_type.is_natural)
			s_not_void: s /= Void
		do
			constant_type := a_type
			string_value := s
			is_initialized := True
		ensure
			constant_type_set: constant_type = a_type
		end

	make_from_hexa_string (a_type: like constant_type; sign: CHARACTER; s: STRING) is
			-- Create a new INTEGER AST node from `s' string representing 
			-- an integer in hexadecimal starting with the following sequence "0x"
			-- and given `sign'.
			-- Set `is_initialized' to true if the string denotes a value that is
			-- within allowed integer bounds. Otherwise set `is_initialized' to false.
		require
			valid_type: a_type /= Void implies (a_type.is_integer or a_type.is_natural)
			valid_sign: ("%U+-").has (sign)
			s_not_void: s /= Void
			s_long_enough: s.count >= 3
			s_has_hexadecimal_prefix: s.substring_index ("0x", 1) = 1
			s_has_hexadecimal_suffix: -- for all i in [3..s.count] ("0123456789ABCDEFabcdef").has (s.item (i))
		do
			constant_type := a_type
			is_initialized := True
			string_value := s
		ensure
			constant_type_set: constant_type = a_type
		end

feature -- Properties

	is_initialized: BOOLEAN
			-- Is constant initialized to allowed value?

	is_integer: BOOLEAN
			-- Is it an integer value ?

	constant_type: TYPE_A

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_integer_constant_as (Current)
		end

feature -- Status report

	size: INTEGER_8
			-- Current is stored on `size' bits.
	
	compatibility_size: INTEGER_8
			-- Minimum integer size that can hold current.
			-- Used for manifest integers that are of size `32' or `64'
			-- by default, but their value might be able to fit
			-- on an integer of size `8' or `16' as well.

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := string_value.is_equal (other.string_value)
		end

feature -- Output

	string_value: STRING
	
	dump: STRING is
			-- 
		do
			Result := string_value.twin
		end

end
