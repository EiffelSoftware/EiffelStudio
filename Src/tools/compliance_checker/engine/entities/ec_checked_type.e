note
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	EC_CHECKED_TYPE

inherit
	EC_CACHABLE_CHECKED_ENTITY

create
	make

feature {NONE} -- Initialization

	make (a_type: like type)
			-- Create an initialize CLS-compliant checked type.
		require
			a_type_not_void: a_type /= Void
		local
			l_element: EC_CHECKED_TYPE
		do
			init_reasons
			type := a_type
			if a_type.has_element_type then
				if attached a_type.get_element_type as l_elm_type then
					if attached {EC_CHECKED_TYPE} checked_entities.item (l_elm_type) as e then
						l_element := e
					else
						create l_element.make (l_elm_type)
					end
					element_checked_type := l_element
				else
					check
						from_documentation_get_element_type_attached: False
					then
					end
				end
			end
		ensure
			type_set: type = a_type
		end

feature -- Access

	type: SYSTEM_TYPE
			-- Type that was examined.

	element_checked_type: detachable EC_CHECKED_TYPE
			-- Checked type for `type' element

feature -- Query

	has_element_checked_type: BOOLEAN
			-- Does checked type have an checked type element?
		note
			metadata: create {SYNCHRONIZATION_ATTRIBUTE}.make end
		do
			Result := element_checked_type /= Void
		ensure
			result_set: Result = (element_checked_type /= Void)
		end

feature {NONE} -- Basic Operations {EC_CHECKED_ENTITY}

	check_extended_compliance
			-- Checks entity's CLS-compliance.
		note
			metadata: create {SYNCHRONIZATION_ATTRIBUTE}.make end
		local
			l_type: like type
			l_checked_asm: EC_CHECKED_ASSEMBLY
			l_compliant: BOOLEAN
		do
			l_type := type

			if l_type.is_pointer then
				internal_is_marked := True
				internal_is_compliant := False
				non_compliant_reason := non_compliant_reasons.reason_type_marked_non_cls_compliant
			elseif attached element_checked_type as l_element then
				internal_is_marked := l_element.is_marked
				l_compliant := l_element.is_compliant
				if l_compliant then
					internal_is_compliant := True
				else
					non_compliant_reason := l_element.non_compliant_reason
				end
			else
				if not internal_is_marked then
					-- type was not marked with CLS-compliant attribute, but it might be marked on an
					-- assembly level.
					if type.is_visible then
						if attached type.assembly as l_asm then
							l_checked_asm := checked_assembly (l_asm)
							internal_is_marked := l_checked_asm.is_marked
							l_compliant := l_checked_asm.is_compliant
							if l_compliant then
								internal_is_compliant := True
							else
								non_compliant_reason := non_compliant_reasons.reason_assembly_marked_non_cls_compliant
							end
						else
							check
								from_documentation_assembly_attached: False
							end
						end
					else
						non_eiffel_compliant_reason := non_compliant_reasons.reason_type_is_not_visible
					end
				elseif not internal_is_compliant then
					non_compliant_reason := non_compliant_reasons.reason_type_marked_non_cls_compliant
				end
			end
		end

	check_eiffel_compliance
			-- Checks entity to see if it is Eiffel-compliant.
		note
			metadata: create {SYNCHRONIZATION_ATTRIBUTE}.make end
		local
			l_compliant: BOOLEAN
			l_type: SYSTEM_TYPE
			l_checked_asm: EC_CHECKED_ASSEMBLY
			retried: BOOLEAN
		do
			if not retried then
				if type.is_visible then
					if attached type.assembly as l_asm then
						l_checked_asm := checked_assembly (l_asm)
						internal_is_marked := l_checked_asm.is_marked
						l_compliant := l_checked_asm.is_eiffel_compliant
						if l_compliant then
							l_type := type
							l_compliant := attached l_type.full_name as l_full_name and then not (l_full_name.index_of_character ('`') >= 0)
							if l_compliant then
								l_compliant := not l_type.is_pointer
								if l_compliant then
									if attached element_checked_type as l_element_type then
										l_compliant := l_element_type.is_eiffel_compliant
										if not l_compliant then
											non_eiffel_compliant_reason := l_element_type.non_eiffel_compliant_reason
										end
									end
								else
									non_eiffel_compliant_reason := non_compliant_reasons.reason_type_marked_non_cls_compliant
								end
							else
								non_eiffel_compliant_reason := non_compliant_reasons.reason_type_is_generic
							end
						else
							non_eiffel_compliant_reason := non_compliant_reasons.reason_assembly_marked_non_eiffel_consumable
						end
						internal_is_eiffel_compliant := l_compliant
					else
						check
							from_documentation_assembly_attached: False
						end
					end
				else
					internal_is_eiffel_compliant := False
					non_eiffel_compliant_reason := non_compliant_reasons.reason_type_is_not_visible
				end
			else
				internal_is_eiffel_compliant := False
				non_eiffel_compliant_reason := non_compliant_reasons.reason_type_crash
			end
		end

feature {NONE} -- Query {EC_CHECKED_ENTITY}

	custom_attribute_provider: ICUSTOM_ATTRIBUTE_PROVIDER
			-- Retrieve custom attribute provider for entity.
		do
			Result := type
		end

invariant
	type_not_void: type /= Void
	element_checked_type_not_void: type.has_element_type implies element_checked_type /= Void

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

end
