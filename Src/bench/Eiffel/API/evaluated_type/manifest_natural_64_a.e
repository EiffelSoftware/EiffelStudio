indexing
	description: "Actual type for integer constant type NATURAL_64."
	date: "$Date$"
	revision: "$Revision$"

class
	MANIFEST_NATURAL_64_A

inherit
	NATURAL_A
		redefine
			convert_to,
			intrinsic_type
		end

	SHARED_TYPES

create
	make_for_constant

feature {NONE} -- Initialization

	make_for_constant (convertible_to_integer_64: BOOLEAN) is
			-- Create instance of NATURAL_A represented by 64 bits
			-- and that can be converted to INTEGER_64 iff
			-- `is_convertible_to_integer_64' is `True'.
		do
			size := 64
			is_convertible_to_integer_64 := convertible_to_integer_64
			cl_make (associated_class.class_id)
		ensure
			size_set: size = 64
			is_convertible_to_integer_64: convertible_to_integer_64
		end

feature -- Property

	is_convertible_to_integer_64: BOOLEAN
			-- Is manifest constant value compatible with INTEGER_64?

	intrinsic_type: NATURAL_A is
			-- Real type of current manifest integer.
		do
			Result := natural_64_type
		end

feature {COMPILER_EXPORTER} -- Implementation

	convert_to (a_context_class: CLASS_C; a_target_type: TYPE_A): BOOLEAN is
			-- Does current convert to `a_target_type' in `a_context_class'?
			-- Update `last_conversion_info' of AST_CONTEXT.
		local
			l_int: INTEGER_A
			l_nat: NATURAL_A
			l_info: CONVERSION_INFO
			l_feat: FEATURE_I
		do
			if a_target_type.is_integer then
				l_int ?= a_target_type
				if is_convertible_to_integer_64 and then l_int.size >= 64 then
					l_feat := associated_class.feature_table.
						item ("to_integer_" + l_int.size.out)
						-- We protect ourself in case the `to_integer_xx' routines
						-- would have been removed from the NATURAL_XX classes
					if l_feat /= Void then
						create {FEATURE_CONVERSION_INFO} l_info.make_to (Current, l_int, associated_class, l_feat)
						Result := True
					end
				end
				context.set_last_conversion_info (l_info)
			elseif a_target_type.is_natural then
				l_nat ?= a_target_type
				if l_nat.size >= 64 then
					l_feat := associated_class.feature_table.
						item ("to_natural_" + l_nat.size.out)
						-- We protect ourself in case the `to_natural_xx' routines
						-- would have been removed from the NATURAL_XX classes
					if l_feat /= Void then
						create {FEATURE_CONVERSION_INFO} l_info.make_to (Current, l_nat, associated_class, l_feat)
						Result := True
					end
				end
				context.set_last_conversion_info (l_info)
			else
				Result := Precursor (a_context_class, a_target_type)
			end
		end

invariant
	correct_size: size = 64

end
