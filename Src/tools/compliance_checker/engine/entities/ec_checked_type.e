indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author     : "$Author$"
	date       : "$Date$"
	revision   : "$Revision$"

class
	EC_CHECKED_TYPE

inherit		
	EC_CACHABLE_CHECKED_ENTITY
		redefine
			check_extended_compliance,
			check_eiffel_compliance
		end
		
create
	make
	
feature {NONE} -- Initialization

	make (a_type: like type) is
			-- Create an initialize CLS-compliant checked type.
		require
			a_type_not_void: a_type /= Void
		local
			l_element: EC_CHECKED_TYPE
			l_elm_type: SYSTEM_TYPE
		do
			type := a_type
			if a_type.has_element_type then
				l_elm_type := a_type.get_element_type
				l_element ?= checked_entities.item (l_elm_type)
				if l_element = Void then
					create l_element.make (l_elm_type)
				end
				element_checked_type := l_element
			end
		ensure
			type_set: type = a_type
		end
		
feature -- Access
		
	type: SYSTEM_TYPE
			-- Type that was examined.
			
	element_checked_type: EC_CHECKED_TYPE
			-- Checked type for `type' element
			
feature -- Query

	has_element_checked_type: BOOLEAN is
			-- Does checked type have an checked type element?
		indexing
			metadata: create {SYNCHRONIZATION_ATTRIBUTE}.make end
		do
			Result := element_checked_type /= Void
		ensure
			result_set: Result = (element_checked_type /= Void)
		end
		
feature {NONE} -- Basic Operations {EC_CHECKED_ENTITY}

	check_extended_compliance is
			-- Checks entity's CLS-compliance.
		indexing
			metadata: create {SYNCHRONIZATION_ATTRIBUTE}.make end
		local
			l_type: like type
			l_checked_asm: EC_CHECKED_ASSEMBLY
			l_asm: ASSEMBLY
			l_element: like element_checked_type
			l_compliant: BOOLEAN
		do
			l_type := type
			
			if l_type.is_pointer then
				internal_is_marked := True
				internal_is_compliant := False
				non_compliant_reason := non_compliant_reasons.reason_type_marked_non_cls_compliant
			elseif has_element_checked_type then
				l_element := element_checked_type
				internal_is_marked := l_element.is_marked
				l_compliant := l_element.is_compliant
				if l_compliant then
					internal_is_compliant := True
				else
					non_compliant_reason := l_element.non_compliant_reason
				end
			else
				Precursor {EC_CACHABLE_CHECKED_ENTITY}
				if not internal_is_marked then
						-- type was not marked with CLS-compliant attribute, but it might be marked on an
						-- assembly level.
					l_asm := type.assembly
					l_checked_asm := checked_assembly (l_asm)
					internal_is_marked := l_checked_asm.is_marked
					l_compliant := l_checked_asm.is_compliant
					if l_compliant then
						internal_is_compliant := True
					else
						non_compliant_reason := non_compliant_reasons.reason_assembly_marked_non_cls_compliant
					end
				elseif not internal_is_compliant then
					non_compliant_reason := non_compliant_reasons.reason_type_marked_non_cls_compliant
				end
			end

		end
		
	check_eiffel_compliance is
			-- Checks entity to see if it is Eiffel-compliant.
		indexing
			metadata: create {SYNCHRONIZATION_ATTRIBUTE}.make end
		local
			l_compliant: BOOLEAN
			l_type: SYSTEM_TYPE		
			l_element_type: like element_checked_type
			l_checked_asm: EC_CHECKED_ASSEMBLY
			l_asm: ASSEMBLY
		do
			Precursor {EC_CACHABLE_CHECKED_ENTITY}
			if internal_is_eiffel_compliant then
				l_asm := type.assembly
				l_checked_asm := checked_assembly (l_asm)
				internal_is_marked := l_checked_asm.is_marked
				l_compliant := l_checked_asm.is_compliant
				if l_compliant then
					l_type := type
					l_compliant := l_type.full_name /= Void and then not (l_type.full_name.index_of_character ('`') >= 0)
					if l_compliant then
						l_compliant := not l_type.is_pointer
						if l_compliant and has_element_checked_type then
							l_element_type := element_checked_type
							l_compliant := l_element_type.is_eiffel_compliant
							if not l_compliant then
								non_eiffel_compliant_reason := l_element_type.non_eiffel_compliant_reason
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
				non_eiffel_compliant_reason := non_compliant_reasons.reason_type_marked_non_eiffel_consumable
			end
		end
		
feature {NONE} -- Query {EC_CHECKED_ENTITY}

	custom_attribute_provider: ICUSTOM_ATTRIBUTE_PROVIDER is
			-- Retrieve custom attribute provider for entity.
		do
			Result := type
		end
			
invariant
	type_not_void: type /= Void
	element_checked_type_not_void: type.has_element_type implies element_checked_type /= Void
			
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
end -- class EC_CHECKED_TYPE
