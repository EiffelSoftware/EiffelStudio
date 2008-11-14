indexing
	description: "[
		A dynmaic code value for values that change according to other values or are the result of some other
		calculation.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	CODE_SYMBOL_DYNAMIC_VALUE

inherit
	CODE_SYMBOL_VALUE

feature -- Access

	value: !STRING_32
			-- The actual value, having been processed
		do
			if has_value_been_evaluated then
				perform_value_evaluation
			end
			create Result.make_from_string (internal_value)
		ensure then
			has_value_been_evaluated: has_value_been_evaluated
		end

feature -- Status report

	has_value_been_evaluated: BOOLEAN
			-- Indicates if `value' has been evaluated
		do
			Result := (internal_value = Void)
		ensure
			internal_value_attached: Result implies internal_value /= Void
		end

feature -- Status setting

	invalidate_value
			-- Invalidates any cached data so the next request to `value'
			-- will reperform the evalatuation of the actual value.
		do
			internal_value := Void
		ensure
			internal_value_detached: internal_value = Void
			not_has_value_been_evaluated: not has_value_been_evaluated
		end

feature {NONE} -- Query

	calculate_value: ?STRING_32
			-- Called during a request to re-evaluate Current's `value' to fetch the most current
			-- value.
			--
			--| Note: No caching should be performed here because value caching is done automatically.
			--|       If any caching has to be performed, ensure it's wiped out in `internal_value'.
		require
			not_has_value_been_evaluated: not has_value_been_evaluated
		deferred
		end

feature {NONE} -- Basic operations

	frozen perform_value_evaluation
			-- Performs an evaluation on any current data and returns the result
		require
			not_has_value_been_evaluated: not has_value_been_evaluated
		local
			l_result: !STRING_32
			l_value: like calculate_value
			retried: BOOLEAN
		do
			if not retried then
					-- Protected because `calculate_value' may fail
				l_value := calculate_value
			else
				l_value := default_value
			end

			if l_value /= Void and not l_value.is_empty then
				create l_result.make (l_value.count)
				Result.append_string (l_value)
			else
				create l_result.make_empty
			end
			internal_value := l_result
		ensure
			has_value_been_evaluated: has_value_been_evaluated
		rescue
			retried := True
			retry
		end

;indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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
