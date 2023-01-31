note
	description : "[
		Abstact base implementation for compliance checked entities.
		
		Note: Implementation uses lazy evaluation so decendents should also use
		      lazy evaluation. See `is_compliant' and `is_marked' implementation
		      for a means on how to do this.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author     : "$Author$"
	date       : "$Date$"
	revision   : "$Revision$"

deferred class
	EC_CHECKED_ENTITY

inherit
	ANY

	EC_CHECKED_CACHE
		export
			{NONE} all
		end

	EC_CHECKED_ENTITY_FACTORY
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	init_reasons
			-- Void-safety initalization
		do
			non_compliant_reason := ""
			non_eiffel_compliant_reason := ""
		end

feature -- Access

	is_compliant: like internal_is_compliant
			-- Is `assembly' CLS-compliant?
		note
			metadata: create {SYNCHRONIZATION_ATTRIBUTE}.make end
		require
			not_is_being_checked: has_been_checked or not is_being_checked
		do
			if not has_been_checked then
				check_compliance
			end
			Result := internal_is_compliant
		ensure
			not_is_being_checked: has_been_checked or not is_being_checked
		end

	is_eiffel_compliant: like internal_is_eiffel_compliant
			-- Is `assembly' Eiffel-compliant?
		note
			metadata: create {SYNCHRONIZATION_ATTRIBUTE}.make end
		require
			not_is_being_checked: has_been_checked or not is_being_checked
		do
			if not has_been_checked then
				check_compliance
			end
			Result := internal_is_eiffel_compliant
		ensure
			not_is_being_checked: has_been_checked or not is_being_checked
		end

	is_marked: like internal_is_marked
			-- Is `assembly' marked with a `CLS_COMPLIANT_ATTRIBUTE'?
		note
			metadata: create {SYNCHRONIZATION_ATTRIBUTE}.make end
		require
			not_is_being_checked: has_been_checked or not is_being_checked
		do
			if not has_been_checked then
				check_compliance
			end
			Result := internal_is_marked
		ensure
			not_is_being_checked: has_been_checked or not is_being_checked
		end

	is_being_checked: BOOLEAN
		-- Is entity in the process of being checked?

	non_compliant_reason: STRING
			-- Reason why entity is non-CLS-compliant

	non_eiffel_compliant_reason: STRING
			-- Reason why entity is non-Eiffel-compliant

	has_been_checked: BOOLEAN
			-- Has entity been checked?

feature {NONE} -- Access

	non_compliant_reasons: separate EC_CHECKED_REASON_CONSTANTS
			-- Checked reasons
		once ("PROCESS")
			create Result
		ensure
			result_not_void: Result /= Void
		end

feature {NONE} -- Basic Operations

	frozen check_compliance
			-- Checks entity's CLS-compliance.
		note
			metadata: create {SYNCHRONIZATION_ATTRIBUTE}.make end
		require
			not_has_been_checked: not has_been_checked
			not_is_being_checked: not is_being_checked
		local
			l_provider: like custom_attribute_provider
		do
			is_being_checked := True
			l_provider := custom_attribute_provider
			examine_attributes (l_provider)
			check_extended_compliance
			if not skip_eiffel_checks then
				check_eiffel_compliance
			end
			has_been_checked := True
			is_being_checked := False
		ensure
			has_been_checked_set: has_been_checked
			not_is_being_checked: not is_being_checked
			reason_set: not internal_is_compliant implies non_compliant_reason /= Void
			eiffel_reason_set: not internal_is_eiffel_compliant implies non_eiffel_compliant_reason /= Void
		end

	check_extended_compliance
			-- Aguments `check_compliance' compliance checking.
			-- Decendents wanting to provide more checking should redefine this feature.
		note
			metadata: create {SYNCHRONIZATION_ATTRIBUTE}.make end
		deferred
		end

	check_eiffel_compliance
			-- Checks entity to see if it is Eiffel-compliant.
		note
			metadata: create {SYNCHRONIZATION_ATTRIBUTE}.make end
		deferred
		end

feature {NONE} -- Query

	custom_attribute_provider: ICUSTOM_ATTRIBUTE_PROVIDER
			-- Retrieve custom attribute provider for entity.
		note
			metadata: create {SYNCHRONIZATION_ATTRIBUTE}.make end
		deferred
		ensure
			result_not_void: Result /= Void
		end

	is_cls_member_name (a_member: MEMBER_INFO): BOOLEAN
			-- Does `a_member' have a valid CLS-compliant name?
		require
			a_member_not_void: a_member /= Void
		local
			l_count: INTEGER
			i: INTEGER
			c: CHARACTER
		do
			if
				attached a_member.name as l_string and then
				attached l_string.to_char_array as l_name
			then
				l_count := l_name.count
				if l_count > 0 then
					Result := l_name.item (0).is_alpha
					from
						i := 1
					until
						i = l_count or not Result
					loop
						c := l_name.item (i)
						Result := c.is_alpha_numeric or c = '_'
						i := i + 1
					end
				end
			else
				check
					from_documentation_name_attached: False
				end
			end
		end

feature {NONE} -- Implementation

	skip_eiffel_checks: BOOLEAN
			-- Indicates if Eiffel compliance checks should be skipped.

	internal_is_compliant: BOOLEAN
			-- Is `assembly' CLS-compliant?
			-- Note: Do not use directly, use `is_compliant' instead.

	internal_is_eiffel_compliant: BOOLEAN
			-- Is `assembly' Eiffel-compliant?
			-- Note: Do not use directly, use `is_eiffel_compliant' instead.

	internal_is_marked: BOOLEAN
			-- Is `assembly' marked with a `CLS_COMPLIANT_ATTRIBUTE'?
			-- Note: Do not use directly, use `is_marked' instead.

	examine_attributes (a_provider: ICUSTOM_ATTRIBUTE_PROVIDER)
			-- Examines `a_provider' custom attributes for System.ClsCompliant attribute.
			-- State is set accordingly.
		note
			metadata: create {SYNCHRONIZATION_ATTRIBUTE}.make end
		require
			a_provider_not_void: a_provider /= Void
		local
			l_cls_comp_attr: CLS_COMPLIANT_ATTRIBUTE
			l_eiffel_attr: EIFFEL_CONSUMABLE_ATTRIBUTE
			l_compliant: BOOLEAN
		do
			l_compliant := True
			if
				attached {RT_CUSTOM_ATTRIBUTE_DATA}.get_eiffel_custom_attributes ({CLS_COMPLIANT_ATTRIBUTE}, a_provider) as l_attributes and then
				l_attributes.count > 0 and then
				attached l_attributes.get_enumerator as l_enum
			then
				from
				until
					not l_enum.move_next or else
					l_cls_comp_attr /= Void
				loop
					l_cls_comp_attr := {CLS_COMPLIANT_ATTRIBUTE} / l_enum.current_
					if l_cls_comp_attr /= Void then
						l_compliant := l_cls_comp_attr.is_compliant
						internal_is_marked := True
					end
				end
			end
			internal_is_compliant := l_compliant

			if
				attached {RT_CUSTOM_ATTRIBUTE_DATA}.get_eiffel_custom_attributes ({EIFFEL_CONSUMABLE_ATTRIBUTE}, a_provider) as l_attributes and then
				 l_attributes.count > 0  and then
				 attached l_attributes.get_enumerator as l_enum
			then
				from
				until
					not l_enum.move_next or else
					l_eiffel_attr /= Void
				loop
					l_eiffel_attr := {EIFFEL_CONSUMABLE_ATTRIBUTE} / l_enum.current_
					if l_eiffel_attr /= Void then
						l_compliant := l_eiffel_attr.consumable
							-- Explict attribute, skip Eiffel checking
						skip_eiffel_checks := True
						internal_is_eiffel_compliant := l_compliant
						if not l_compliant then
							non_eiffel_compliant_reason := non_compliant_reasons.reason_entity_marked_non_eiffel_compliant
						end
					end
				end
			end
		end

note
	copyright:	"Copyright (c) 1984-2022, Eiffel Software"
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
end -- class EC_CHECKED_ENTITY
