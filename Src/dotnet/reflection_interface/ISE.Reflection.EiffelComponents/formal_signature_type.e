indexing
	description: "Formal signature type"
	external_name: "ISE.Reflection.FormalSignatureType"
	attribute: create {SYSTEM_RUNTIME_INTEROPSERVICES_CLASSINTERFACEATTRIBUTE}.make_classinterfaceattribute ((create {SYSTEM_RUNTIME_INTEROPSERVICES_CLASSINTERFACETYPE}).auto_dual) end

class
	FORMAL_SIGNATURE_TYPE

inherit
	SIGNATURE_TYPE

create 
	make

feature -- Access

	generic_parameter_index: INTEGER
		indexing
			description: "Generic parameter index"
			external_name: "GenericParameterIndex"
		end

feature -- Status Setting

	set_generic_parameter_index (an_index: like generic_parameter_index) is
		indexing
			description: "Set `generic_parameter_index' with `an_index'."
			external_name: "SetGenericParameterIndex"
		do
			generic_parameter_index := an_index
		ensure
			index_set: generic_parameter_index = an_index
		end
		
end -- class FORMAL_SIGNATURE_TYPE
