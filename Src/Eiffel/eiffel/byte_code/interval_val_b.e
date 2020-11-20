note
	description: "Abstract representation of an interval value for `inspect' clauses."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class INTERVAL_VAL_B

inherit
	BYTE_NODE
		undefine
			is_equal
		end

	COMPARABLE

feature -- Error reporting

	display (a_text_formatter: TEXT_FORMATTER)
		require
			st_not_void: a_text_formatter /= Void
		deferred
		end

feature -- Comparison

	is_next (other: like Current): BOOLEAN
			-- Is `other' next to Current?
		require
			other_not_void: other /= Void
			same_type: same_type (other)
		deferred
		end

	is_allowed_unique_value: BOOLEAN
			-- Does `Current' represent an allowed unique value?
			-- (This is now true for positive integers.)
		do
			-- False by default.
		end

	is_signed: BOOLEAN
			-- Is current using a signed comparison?
		do
		end

feature -- Measurement

	distance (other: like Current): DOUBLE
			-- Distance between `other' and Current
		require
			other_not_void: other /= Void
			same_type: same_type (other)
			other_not_less: other >= Current
		deferred
		ensure
			non_negative_result: Result >= 0
		end

feature -- Iteration

	do_all (is_included: BOOLEAN; other: like Current; is_other_included: BOOLEAN; action: PROCEDURE)
			-- Apply `action' to all values in range `Current'..`other' where
			-- inclusion of bounds in the range is specified by `is_included' and `is_other_included'.
		require
			other_not_void: other /= Void
			same_type: same_type (other)
			other_not_less: other >= Current
			action_not_void: action /= Void
		deferred
		end

feature -- Evaluation

	inspect_interval (upper: like Current): TYPED_INTERVAL_B [like Current]
			-- Interval with lower set to `Current' and upper set to `upper'
		require
			upper_not_void: upper /= Void
			same_type: same_type (upper)
			upper_not_less: upper >= Current
		do
			create Result.make (Current, upper)
		ensure
			result_not_void: Result /= Void
			lower_set: Result.lower = Current
			upper_set: Result.upper = upper
		end

feature -- IL code generation

	generate_il_subtract (is_included: BOOLEAN)
			-- Generate code to subtract this value if `is_included' is true or
			-- next value if `is_included' is false from top of IL stack.
			-- Ensure that resulting value on the stack is UInt32.
		deferred
		end

feature {INTERVAL_B} -- C code generation

	generate_interval (other: like Current; e: detachable EXPR_B; creators: detachable ARRAY [FEATURE_I])
			-- Generate interval Current..`other` for constants or once creation procedures (when `e` is attached).
		require
			other_not_void: attached other
			same_type: same_type (other)
			good_range: Current <= other
			attached e ⇒ attached creators
			attached e ⇒ (attached real_type (e.type) as t ∧… attached t.base_class as b ∧…
				(b.is_once ∧ b.creators.count = creators.count))
			attached creators ⇒ across creators as p all p.cursor_index = p.item.creator_position end
		deferred
		end

feature {INTERVAL_B, IL_NODE_GENERATOR} -- IL code generation

	il_load_value
			-- Load value to IL stack.
		deferred
		end

	il_load_difference (other: like Current)
			-- Load a difference between current and `other' to IL stack.
		require
			other_not_void: other /= Void
			same_type: same_type (other)
			other_not_greater: other <= Current
		deferred
		end

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
