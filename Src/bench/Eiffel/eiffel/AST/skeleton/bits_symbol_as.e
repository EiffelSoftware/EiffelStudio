indexing
	description: "AST representation of bit symbols."
	date: "$Date$"
	revision: "$Revision$"

class BITS_SYMBOL_AS

inherit
	BASIC_TYPE
		rename
			initialize as initialize_basic_type
		redefine
			is_equivalent, append_to, format
		end

feature {AST_FACTORY} -- Initialization

	initialize (s: like bits_symbol) is
			-- Create a new BITS_SYMBOL AST node.
		require
			s_not_void: s /= Void
		do
			bits_symbol := s
		ensure
			bits_symbol_set: bits_symbol = s
		end

feature -- Attributes

	bits_symbol: ID_AS
			-- Bits value

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (bits_symbol, other.bits_symbol)
		end

feature 

	solved_type (feat_table: FEATURE_TABLE; f: FEATURE_I): BITS_SYMBOL_A is
		local
			vtbt: VTBT
			veen: VEEN
			constant: CONSTANT_I
			bits_value: INTEGER
			error: BOOLEAN
			int_value: INT_VALUE_I
			depend_unit: DEPEND_UNIT
		do
			if not feat_table.has (bits_symbol) then
				!! veen
				veen.set_class (feat_table.associated_class)
				veen.set_feature (f)
				veen.set_identifier (bits_symbol)
				Error_handler.insert_error (veen)
				Error_handler.raise_error
			end
			constant ?= feat_table.item (bits_symbol)
			error := constant = Void
			if not error then
				int_value ?= constant.value
				error := int_value = Void
				if not error then
					bits_value := int_value.int_val
					error := bits_value <= 0
				end
			end
			if error then
				!!vtbt
				vtbt.set_class (feat_table.associated_class)
				vtbt.set_feature (f)
				if bits_value < 0 then
					vtbt.set_value (bits_value)
				end
				Error_handler.insert_error (vtbt)
					-- Cannot go on here
				Error_handler.raise_error
			end
			check
				positive_bits_value: bits_value > 0
			end
			create Result.make (constant, bits_value)
			if System.in_pass3 then
				!!depend_unit.make (context.a_class.class_id, constant)
				context.supplier_ids.extend (depend_unit)
			end
		end; -- solved_type

	actual_type: BITS_A is
			-- Actual bits type
		do
				-- FIXME: Most probably, we need to fix it in the Eiffel grammar in
				-- order to avoid the following declaration:
				--   class TEST [g->ARRAY [BIT toto]]
				-- In that case only, we can't allow `BIT toto' however we can allow
				-- `BIT x' where x is a number.
				--
				-- For now, since we cannot prevent the user to use
				-- a BIT type within the declaration of a GENERIC CONSTRAINT we have to
				-- create something, even if it is wrong, to emphasize, we set `bit_count'
				-- to `-1'.
				-- But that's ok, since the result will never been used except for 
				-- displaying an error.
			create Result.make (-1)
		ensure then
			False
		end; -- actual_type

	append_to (st: STRUCTURED_TEXT) is
		do
			st.add_string ("BIT ")
			st.add_string (bits_symbol)
		end

feature -- Output

	format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.put_class_name (dump)
		end

	dump: STRING is
			-- Debug purpose
		do
			!! Result.make (5 + bits_symbol.count)
			Result.append ("BIT ")
			Result.append (bits_symbol)
   		end

end -- class BITS_SYMBOL_AS
