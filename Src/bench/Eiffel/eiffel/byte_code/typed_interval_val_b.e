indexing
	description: "Abstract representation of an inspect value of a particular type."
	date: "$Date$"
	revision: "$Revision$"

deferred class TYPED_INTERVAL_VAL_B [H]

inherit
	INTERVAL_VAL_B
		redefine
			is_equal
		end

feature {NONE} -- Initialization

	make (v: H) is
			-- Initialize `value' with `v'.
		do
			value := v
		ensure
			value_set: value = v
			generation_value_set: generation_value = v
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Is `other' equal to Current?
		do
			Result := generation_value = other.generation_value
		end

feature {NONE} -- Data

	value: H
			-- Constant value

feature -- Code generation

	generation_value: H is
			-- Value to generate
		do
			Result := value
		end

end
