indexing
	description: "Node for integer constant. Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class INTEGER_AS

inherit
	ATOMIC_AS
		redefine
			is_integer, good_integer, is_equivalent,
			type_check, byte_node, value_i, make_integer
		end

feature {AST_FACTORY} -- Initialization

	initialize (i: INTEGER) is
			-- Create a new INTEGER AST node.
		do
			value := i
		ensure
			value_set: value = i
		end

	initialize_from_hexa (s: STRING) is
			-- Create a new INTEGER AST node from `s' string representing
			-- an integer in hexadecimal starting with the following sequence
			-- "0x".
		require
			s_not_void: s /= Void
			s_not_empty: not s.is_empty
			--s_valid_hexadecimal_integer
			s_not_too_big: s.count <= 18
		do
				-- FIXME: even though we accept 64bits hexadecimal values,
				-- result will be truncated.
			value := to_integer_value (s)
		end

feature -- Properties

	value: INTEGER
			-- Integer value

	is_integer: BOOLEAN is True
			-- Is it an integer value ?

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := value = other.value
		end

feature -- Conveniences

	value_i: INT_VALUE_I is
			-- Interface value
		do
			!! Result
			Result.set_int_val (value)
		end

	type_check is
			-- Type check an integer type
		do
				-- Put onto the type stack an integer actual type
			context.put (Integer_type)
		end

	byte_node: INT_CONST_B is
			-- Associated byte code
		do
			!! Result
			Result.set_value (value)
		end

	make_integer: INT_VAL_B is
			-- Integer value
		do
			!! Result.make (value)
		end

feature -- Output

	string_value: STRING is
		do
			Result := value.out
		end	

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.put_text_item (
				create {NUMBER_TEXT}.make (string_value)
			)
		end
	
feature {COMPILER_EXPORTER}

	good_integer: BOOLEAN is True
			-- Is the atomic a good integer bound for multi-branch ?

feature {NONE} -- Translation

	to_integer_value (s: STRING): INTEGER is
			-- Convert `s' hexadecimal value into an integer representation.
		require
			s_not_void: s /= Void
			s_large_enough: s.count > 2
		local
			i: INTEGER
			power: INTEGER
		do
			from
				i := s.count
				power := 1
			until
				i = 2
			loop
				inspect
					s.item (i).lower
				when 'a' then
					Result := Result + 10 * power
				when 'b' then
					Result := Result + 11 * power
				when 'c' then
					Result := Result + 12 * power
				when 'd' then
					Result := Result + 13 * power
				when 'e' then
					Result := Result + 14 * power
				when 'f' then
					Result := Result + 15 * power
				else
					Result := Result + (s.item (i).code - 48) * power
				end
				i := i - 1
				power := power * base_16
			end
		end

	base_16: INTEGER is 16
			-- Value of integer base.

end -- class INTEGER_AS
