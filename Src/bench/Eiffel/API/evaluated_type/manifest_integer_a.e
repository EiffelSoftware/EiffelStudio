indexing
	description: "Actual type for integer constant types."
	date: "$Date$"
	revision: "$Revision$"

class
	MANIFEST_INTEGER_A

inherit
	INTEGER_A
		redefine
			convert_to,
			intrinsic_type
		end

	SHARED_TYPES

create
	make_for_constant

feature {NONE} -- Initialization

	make_for_constant (n, m: INTEGER; is_neg: BOOLEAN) is
			-- Create instance of INTEGER_A represented by `n' bits
			-- whose value can hold at list `m' bits with a sign of `is_neg'.
		require
			valid_n: n = 32 or n = 64
			valid_m: m = 8 or m = 16 or m = 32 or m = 64
		do
			size := n.to_integer_8
			compatibility_size := m.to_integer_8
			is_negative := is_neg
			cl_make (associated_class.class_id)
		ensure
			size_set: size = n
			compatibility_size_set: compatibility_size = m
			is_negative_set: is_negative = is_neg
		end

feature -- Property

	compatibility_size: INTEGER_8
			-- Minimum integer size that can hold current.
			-- Used for manifest integers that are of size `32' or `64'
			-- by default, but their value might be able to fit
			-- on an integer of size `8' or `16' as well.

	is_negative: BOOLEAN
			-- Is current value negative?

	intrinsic_type: INTEGER_A is
			-- Real type of current manifest integer.
			-- To preserve compatibility with ETL2, a manifest 
			-- integer is always at least 32 bits wide.
		do
			inspect size
			when 32 then Result := integer_type
			when 64 then Result := integer_64_type
			end
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
				Result := (l_int.size >= size) or else
					(l_int.size >= compatibility_size)
				if Result then
					l_feat := associated_class.feature_table.
						item ("to_integer_" + l_int.size.out)
						-- We protect ourself in case the `to_integer_xx' routines
						-- would have been removed from the INTEGER_XX classes
					if l_feat /= Void then
						create {FEATURE_CONVERSION_INFO} l_info.make_to (Current, l_int, associated_class, l_feat)
					else
						Result := False
					end
				end
				context.set_last_conversion_info (l_info)
			elseif a_target_type.is_natural then
				l_nat ?= a_target_type
				Result := not is_negative and then ((l_nat.size >= size) or else
					(l_nat.size >= compatibility_size))
				if Result then
					l_feat := associated_class.feature_table.
						item ("to_natural_" + l_nat.size.out)
						-- We protect ourself in case the `to_natural_xx' routines
						-- would have been removed from the INTEGER_XX classes
					if l_feat /= Void then
						create {FEATURE_CONVERSION_INFO} l_info.make_to (Current, l_nat, associated_class, l_feat)
					else
						Result := False
					end
				end
				context.set_last_conversion_info (l_info)
			else
				Result := Precursor {INTEGER_A} (a_context_class, a_target_type)
			end
		end

invariant
	correct_size: size = 32 or size = 64
	valid_compatibility_size: compatibility_size <= size

end -- class MANIFEST_INTEGER_A
