note
	description: "[
		Type that can be used for inheritance relation. When used in actual generic parameter
		they can be an interval bounder to NONE, otherwise the lower and upper bound are the same.
		]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	INHERITANCE_TYPE_A

inherit
	ABSTRACT_TYPE_INTERVAL_A
		rename
			conform_to as general_conform_to
		end

feature -- Access

	lower: INHERITANCE_TYPE_A
		do
			Result := Current
		end

	upper: INHERITANCE_TYPE_A
		do
			if is_actual_generic_parameter then
					-- By default types used as actual generic parameter are no variant.
				Result := Current
			else
				Result := none_a
			end
		end

feature -- Generic conformance

	annotation_flags: NATURAL_16
			-- Flags for annotations of Current.
			-- Currently only `!' and `frozen' are supported
		do
 				-- Only if a type is not expanded do we need to generate the
				-- attached annotation since by default expanded implies attached.
			if is_attached and not is_expanded then
				Result := {SHARED_GEN_CONF_LEVEL}.attached_type
			end
		end

feature -- Status report

	is_actual_generic_parameter: BOOLEAN
			-- Is `Current' appearing as an actual generic parameter of a class?

	conform_to (a_context_class: CLASS_C; other: INHERITANCE_TYPE_A): BOOLEAN
			-- Does Current conform to `other' in `a_context_class'?
		require
			is_valid: is_valid
			a_context_class_not_void: a_context_class /= Void
			a_context_class_valid: a_context_class.is_valid
			a_context_valid_for_current: is_valid_for_class (a_context_class)
			other_not_void: other /= Void
			other_is_valid: other.is_valid
		deferred
		end

feature -- Settings

	set_is_actual_generic_parameter (v: BOOLEAN)
			-- Set `is_actual_generic_parameter' with `v'.
		do
			is_actual_generic_parameter := v
		ensure
			is_actual_generic_parameter_set: is_actual_generic_parameter = v
		end

feature {NONE} -- Implementation

	none_a: NONE_A
			-- Shared instance of NONE_A used for unbounded type intervals.
		once
			create Result
		end

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
