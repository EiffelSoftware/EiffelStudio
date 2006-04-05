indexing
	description: "A span that is either a single interval or a group of intervals in inspect instruction."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	INTERVAL_SPAN

feature -- Access

	lower: INTERVAL_VAL_B is
			-- Lower bound of a span
		deferred
		end

	upper: like lower is
			-- Upper bound of a span
		deferred
		end

	is_lower_included: BOOLEAN is
			-- Is `lower' included in a span?
		deferred
		end

	is_upper_included: BOOLEAN is
			-- Is `upper' included in a span?
		deferred
		end

feature -- Measurement

	count: DOUBLE is
			-- Number of intervals and gaps in current span
		deferred
		end

feature -- IL code generation

	generate_il (a_generator: IL_NODE_GENERATOR; min_value, max_value: like lower; is_min_included, is_max_included: BOOLEAN; labels: ARRAY [IL_LABEL]; instruction: INSPECT_B) is
			-- Generate code for span in `instruction' assuming that inspect value is in range `min'..`max'
			-- where bounds are included in interval according to values of `is_min_included' and `is_max_included'.
			-- Use `labels' to branch to the corresponding code.
		require
			a_generator_not_void: a_generator /= Void
			min_value_not_void: min_value /= Void
			max_value_not_void: max_value /= Void
			labels_not_void: labels /= Void
			labels_not_empty: not labels.is_empty
			labels_has_else_label: labels.lower <= 0
			else_label_not_void: labels.item (0) /= Void
			labels_has_end_label: labels.lower <= -1
			end_label_not_void: labels.item (-1) /= Void
			instruction_not_void: instruction /= Void
		deferred
		end

invariant
	lower_not_void: lower /= Void
	upper_not_void: upper /= Void
	lower_before_upper: lower <= upper

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
