indexing
	description: "Error messages for support"
	external_name: "ISE.Reflection.ReflectionSupportErrorMessages"
--	attribute: create {SYSTEM_RUNTIME_INTEROPSERVICES_CLASSINTERFACEATTRIBUTE}.make_classinterfaceattribute (2) end

class
	REFLECTION_SUPPORT_ERROR_MESSAGES

inherit
	SUPPORT_ERROR_MESSAGES
	
feature -- Access

	No_assembly_description: STRING is "No assembly description"
		indexing
			description: "Error name: no assembly description"
			external_name: "NoAssemblyDescription"
		end
		
	No_assembly_description_message: STRING is "The XML description file corresponding to this assembly has not been found."
		indexing
			description: "Error message when no `assembly_description.xml' file is found"
			external_name: "NoAssemblyDescriptionMessage"
		end

	
	No_type_description: STRING is "No type description"
		indexing
			description: "Error name: no type description"
			external_name: "NoTypeDescription"
		end
		
	No_type_description_message: STRING is "The XML description file corresponding to this type has not been found."
		indexing
			description: "Error message when no type XML file is found"
			external_name: "NoTypeDescriptionMessage"
		end


	Hash_value_computation_failed: STRING is "Hash value computation failed"
		indexing
			description: "Error name: hash value computation failed"
			external_name: "HashValueComputationFailed"
		end

	Hash_value_computation_failed_message: STRING is "The hash value computation needed to create the assembly repository has failed."
		indexing
			description: "Error message when hash value computation has failed"
			external_name: "HashValueComputationFailedMessage"
		end

end -- class REFLECTION_SUPPORT_ERROR_MESSAGES	