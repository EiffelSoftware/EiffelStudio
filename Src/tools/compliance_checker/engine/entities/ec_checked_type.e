indexing
	description: "Objects that ..."
	author     : "$Author$"
	date       : "$Date$"
	revision   : "$Revision$"

class
	EC_CHECKED_TYPE

inherit		
	EC_CACHABLE_CHECKED_ENTITY
		redefine
			check_extended_compliance
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
		do
			l_type := type
			
			if l_type.is_pointer then
				internal_is_marked := True
				internal_is_compliant := False
			elseif has_element_checked_type then
				l_element := element_checked_type
				internal_is_marked := l_element.is_marked
				internal_is_compliant := l_element.is_compliant
			else
				Precursor {EC_CACHABLE_CHECKED_ENTITY}
				if not internal_is_marked then
						-- type was not marked with CLS-compliant attribute, but it might be marked on an
						-- assembly level.
					l_asm := type.assembly
					l_checked_asm := checked_assembly (l_asm)
					internal_is_marked := l_checked_asm.is_marked
					if not internal_is_marked and l_type.is_interface then
							-- There is no indication if assembly is CLS-complaint or not,
							-- so we need to check interface members for compliance.
					else
						internal_is_compliant := l_checked_asm.is_compliant
					end
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
		do
			l_type := type
			l_compliant := not l_type.is_pointer
			if l_compliant and has_element_checked_type then
				l_compliant := element_checked_type.is_eiffel_compliant
			end
			internal_is_eiffel_compliant := l_compliant
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
			
end -- class EC_CHECKED_TYPE
