indexing
	description: "[
		Base implementation for checked entities that describes and examines an assembly type method.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author     : "$Author$"
	date       : "$Date$"
	revision   : "$Revision$"

deferred class
	EC_CHECKED_MEMBER_METHOD_BASE

inherit
	EC_CHECKED_MEMBER
		redefine
			member,
			check_extended_compliance,
			check_eiffel_compliance
		end

feature -- Access {EC_CHECKED_MEMBER}

	member: METHOD_BASE
			-- Member that was examined.

feature {NONE} -- Basic Operations {EC_CHECKED_MEMBER}

	check_extended_compliance is
			-- Checks entity's CLS-compliance.
		local
			l_member: like member
			l_compliant: BOOLEAN
		do
			l_member := member
			if l_member.is_public or l_member.is_family or l_member.is_family_or_assembly then
				Precursor {EC_CHECKED_MEMBER}
				if internal_is_compliant and not internal_is_marked then
					l_compliant := not (l_member.calling_convention = {CALLING_CONVENTIONS}.var_args)
					if not l_compliant then
						non_compliant_reason := non_compliant_reasons.reason_method_uses_var_args
					end
					internal_is_compliant := l_compliant
				end
			else
				internal_is_compliant := True
				internal_is_marked := True
			end
		end

	check_eiffel_compliance is
			-- Checks entity to see if it is Eiffel-compliant.
		local
			l_member: like member
			l_compliant: BOOLEAN
		do
			l_member := member
			if l_member.is_public or l_member.is_family or l_member.is_family_or_assembly then
				Precursor {EC_CHECKED_MEMBER}
				if internal_is_eiffel_compliant then
					l_compliant := not (l_member.calling_convention = {CALLING_CONVENTIONS}.var_args)
					if not l_compliant then
						non_eiffel_compliant_reason := non_compliant_reasons.reason_method_uses_var_args
					end
					internal_is_eiffel_compliant := l_compliant
				end
			end
		end

feature -- Access

	checked_parameter_types: ARRAY [EC_CHECKED_TYPE] is
			-- `member' method checked parameter types.
		local
			l_params: NATIVE_ARRAY [PARAMETER_INFO]
			l_type: EC_CHECKED_TYPE
			i: INTEGER
		do
			l_params := member.get_parameters
			i := l_params.count
			create Result.make (1, i)
			if i > 0 then
				from
				until
					i = 0
				loop
					l_type := checked_type (l_params.item (i - 1).parameter_type)
					Result.put (l_type, i)
					i := i - 1
				end
			end
		ensure
			result_not_void: Result /= Void
		end

feature {NONE} -- Implementation

	are_parameters_compliant (a_check_eiffel: BOOLEAN): BOOLEAN is
			-- Are `member' parameters compliant?
			-- If `a_check_eiffel' then parameters are checked for Eiffel compliance.
		local
			l_params: like checked_parameter_types
			l_item: EC_CHECKED_TYPE
			i: INTEGER
		do
			l_params := checked_parameter_types
			i := l_params.count
			Result := True
			if i > 0 then
				from
				until
					i = 0 or not Result
				loop
					l_item := l_params.item (i)
					if a_check_eiffel then
						Result := l_item.is_eiffel_compliant
					else
						Result := l_item.is_compliant
					end
					i := i - 1
				end
			end
		end

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
end -- class EC_CHECKED_MEMBER_METHOD_BASE
