indexing
	description: "Representation of a BIT type."
	date: "$Date$"
	revision: "$Revision$"

class BITS_AS

inherit
	TYPE_AS
		redefine
			append_to
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (v: like bits_value) is
			-- Create a new BITS AST node.
		require
			v_not_void: v /= Void
		local
			vtbt: VTBT_SIMPLE
		do
			bits_value := v
			if (bits_value.integer_32_value <= 0) then
				create vtbt
				vtbt.set_class (System.current_class)
				vtbt.set_value (bits_value.integer_32_value)
				vtbt.set_location (bits_value.start_location)
				Error_handler.insert_error (vtbt)
					-- Cannot go on here
				Error_handler.raise_error
			end
		ensure
			bits_value_set: bits_value = v
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_bits_as (Current)
		end

feature -- Attributes

	bits_value: INTEGER_AS
			-- Bits value

feature -- Location

	start_location: LOCATION_AS is
			-- Starting point for current construct.
		do
			Result := bits_value.start_location
		end
		
	end_location: LOCATION_AS is
			-- Ending point for current construct.
		do
			Result := bits_value.end_location
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (bits_value, other.bits_value)
		end

feature -- Type evaluation

	append_to (st: STRUCTURED_TEXT) is
		do
			actual_type.append_to (st)
		end

	solved_type (feat_table: FEATURE_TABLE; f: FEATURE_I): BITS_A is
			-- Calculated type in function of the feature `f' which has
			-- the type Current and the feautre table `feat_table'
		local
			vtbt: VTBT
		do
			if 
				bits_value.integer_32_value <= 0 or else
				bits_value.integer_32_value > {EIFFEL_SCANNER_SKELETON}.Maximum_bit_constant 
			then
				create vtbt
				vtbt.set_class (feat_table.associated_class)
				vtbt.set_feature (f)
				vtbt.set_value (bits_value.integer_32_value)
				vtbt.set_location (bits_value.start_location)
				Error_handler.insert_error (vtbt)
					-- Cannot go on here
				Error_handler.raise_error
			end
			Result := actual_type
		end

	actual_type: BITS_A is
			-- Actual bits type
		do
			create Result.make (bits_value.integer_32_value)
		end

feature -- Output

	dump: STRING is
			-- Debug purpose
		do
			create Result.make (10)
			Result.append ("BIT ")
			Result.append_integer (bits_value.integer_32_value)
		end

end -- class BITS_AS
