note
	description: "Helper functions using .NET reflection"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	REFLECTION

inherit
	FIELD_CONSUMER_HELPER

	EC_CHECKED_ENTITY_FACTORY
		export
			{NONE} all
		end

feature -- Status Report

	is_consumed_type (t: SYSTEM_TYPE): BOOLEAN
			-- Is `t' a public CLS compliant type?
		do
			if is_eiffel_compliant_type (t) then
				Result := is_visible_type (t)
				if not Result then
					if t.is_nested_public or t.is_nested_family or t.is_nested_fam_or_assem then
						Result := is_consumed_type (t.declaring_type)
					end
				end
			end
		end

	is_consumed_method (m: METHOD_BASE): BOOLEAN
			-- Is `m' a public/family CLS compliant method?
		require
			m_not_void: m /= Void
		do
			if (m.is_public or m.is_family or m.is_family_or_assembly) then
					-- check that member is fully cls compliant
				Result := is_eiffel_compliant_member (m)
			end
		end

	is_consumed_field (f: FIELD_INFO): BOOLEAN
			-- Is `f' a public/family CLS compliant field?
		require
			f_not_void: f /= Void
		do
			if (f.is_public or f.is_family or f.is_family_or_assembly) then
					-- check that field is fully cls compliant
				Result := is_eiffel_compliant_member (f)

				if Result and then f.is_literal then
					Result := is_valid_literal_field (f)
				end
			end
		end

	is_valid_literal_field (f: FIELD_INFO): BOOLEAN
			-- Is `f' a valid literal field?
		require
			f_not_void: f /= Void
			f_is_literal: f.is_literal
		do
			Result := field_value (f) /= Void
		end

	is_cls_generic_type (a_type: SYSTEM_TYPE): BOOLEAN
			--
		local
			l_name: SYSTEM_STRING
		do
				-- If `a_type.full_name' is Void, it means it is a formal generic parameter.
				-- We consider this case and the case where the string contains ``'
				-- as generic type.
			l_name := a_type.full_name
			Result := l_name = Void or else l_name.index_of ('`') >= 0
		end

	is_eiffel_compliant_type (a_type: SYSTEM_TYPE): BOOLEAN
			-- is `a_type' Eiffel-compliant
		require
			a_type_not_void: a_type /= Void
		local
			l_type: EC_CHECKED_TYPE
		do
			l_type := checked_type (a_type)
			Result := l_type.is_eiffel_compliant
		end

	is_eiffel_compliant_member (member: MEMBER_INFO): BOOLEAN
			-- 	Is `member' Eiffel-compliant?
		local
			l_type: SYSTEM_TYPE
		do
			l_type ?= member
			if l_type = Void then
				Result := checked_member (member).is_eiffel_compliant
			else
				Result := is_eiffel_compliant_type (l_type)
			end
		end

	is_public_field (a_field: FIELD_INFO): BOOLEAN
			-- Is `a_field' public and static?
		do
			Result := a_field.is_public and not a_field.is_literal
		end

	is_init_only_field (a_field: FIELD_INFO): BOOLEAN
			-- Is `a_field' a initonly field?
		do
			Result := a_field.is_init_only
		end

feature {NONE} -- Implementation

	is_visible_type (a_type: SYSTEM_TYPE): BOOLEAN
			-- Determines if type `a_type' is really visible, which is require on 2.0 to test if types are really public!
		require
			a_type_attached: a_type /= Void
		local
			l_call: like is_visible_function
		do
			Result := a_type.is_public
			if Result then
				l_call := is_visible_function
				if l_call /= Void then
					Result ?= l_call.invoke_object_object_array (a_type, create {NATIVE_ARRAY [SYSTEM_OBJECT]}.make (0))
				end
			end
		end

	is_visible_function: METHOD_INFO
			-- get_IsVisible function from System.Type
		local
			l_type: SYSTEM_TYPE
		once
			if {ENVIRONMENT}.version.major >= 2 then
				l_type := {SYSTEM_TYPE}
				Result := l_type.get_method ("get_IsVisible")
			end
		end

note
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


end -- class REFLECTION
