indexing
	description : "[
		Abstact base implementation for compliance checked entities.
		
		Note: Implementation uses lazy evaluation so decendents should also use
		      lazy evaluation. See `is_compliant' and `is_marked' implementation
		      for a means on how to do this.
		]"
	author     : "$Author$"
	date       : "$Date$"
	revision   : "$Revision$"

deferred class
	EC_CHECKED_ENTITY
	
inherit
	EC_CHECKED_CACHE
		export
			{NONE} all
		end

	EC_CHECKED_ENTITY_FACTORY
		export
			{NONE} all
		end

feature -- Access

	is_compliant: like internal_is_compliant is
			-- Is `assembly' CLS-compliant?
		indexing
			metadata: create {SYNCHRONIZATION_ATTRIBUTE}.make end
		do
			if not has_been_checked then
				check_compliance
			end
			Result := internal_is_compliant
		end
		
	is_eiffel_compliant: like internal_is_eiffel_compliant is
			-- Is `assembly' Eiffel-compliant?
		indexing
			metadata: create {SYNCHRONIZATION_ATTRIBUTE}.make end
		do
			if not has_been_checked then
				check_compliance
			end
			Result := internal_is_eiffel_compliant
		end
	
	is_marked: like internal_is_marked is
			-- Is `assembly' marked with a `CLS_COMPLIANT_ATTRIBUTE'?
		indexing
			metadata: create {SYNCHRONIZATION_ATTRIBUTE}.make end
		do
			if not has_been_checked then
				check_compliance
			end
			Result := internal_is_marked
		end
			
	has_been_checked: BOOLEAN
			-- Has entity been checked?

feature {NONE} -- Basic Operations

	frozen check_compliance is
			-- Checks entity's CLS-compliance.
		indexing
			metadata: create {SYNCHRONIZATION_ATTRIBUTE}.make end
		require
			not_has_been_checked: not has_been_checked
		local
			l_provider: like custom_attribute_provider
		do
			l_provider := custom_attribute_provider
			examine_attributes (l_provider)
			check_extended_compliance
			check_eiffel_compliance
			has_been_checked := True
		ensure
			has_been_checked_set: has_been_checked
		end
		
	check_extended_compliance is
			-- Aguments `check_compliance' compliance checking.
			-- Decendents wanting to provide more checking should redefine this feature.
		indexing
			metadata: create {SYNCHRONIZATION_ATTRIBUTE}.make end			
		do
			--| Do nothing...
		end
		
	check_eiffel_compliance is
			-- Checks entity to see if it is Eiffel-compliant.
		indexing
			metadata: create {SYNCHRONIZATION_ATTRIBUTE}.make end
		deferred
		end
			
feature {NONE} -- Query

	custom_attribute_provider: ICUSTOM_ATTRIBUTE_PROVIDER is
			-- Retrieve custom attribute provider for entity.
		indexing
			metadata: create {SYNCHRONIZATION_ATTRIBUTE}.make end
		deferred
		ensure
			result_not_void: Result /= Void
		end
		
feature {NONE} -- Implementation

	internal_is_compliant: BOOLEAN
			-- Is `assembly' CLS-compliant?
			-- Note: Do not use directly, use `is_compliant' instead.
	
	internal_is_eiffel_compliant: BOOLEAN
			-- Is `assembly' Eiffel-compliant?
			-- Note: Do not use directly, use `is_eiffel_compliant' instead.
	
	internal_is_marked: BOOLEAN
			-- Is `assembly' marked with a `CLS_COMPLIANT_ATTRIBUTE'?
			-- Note: Do not use directly, use `is_marked' instead.
			
	examine_attributes (a_provider: ICUSTOM_ATTRIBUTE_PROVIDER) is
			-- Examines `a_provider' custom attributes for System.ClsCompliant attribute.
			-- State is set accordingly.
		indexing
			metadata: create {SYNCHRONIZATION_ATTRIBUTE}.make end
		require
			a_provider_not_void: a_provider /= Void
		local
			l_attributes: NATIVE_ARRAY [SYSTEM_OBJECT]
			l_cls_comp_attr: CLS_COMPLIANT_ATTRIBUTE
			l_enum: IENUMERATOR
			l_compliant: BOOLEAN
		do
			l_compliant := True
			l_attributes := a_provider.get_custom_attributes (True)
			if l_attributes /= Void and then l_attributes.count > 0 then
				from
					l_enum := l_attributes.get_enumerator
				until
					not l_enum.move_next or else
					l_cls_comp_attr /= Void 
				loop
					l_cls_comp_attr ?= l_enum.current_
					if l_cls_comp_attr /= Void then
						l_compliant := l_cls_comp_attr.is_compliant
						internal_is_marked := True
					end
				end
			end
			internal_is_compliant := l_compliant
		end

end -- class EC_CHECKED_ENTITY
