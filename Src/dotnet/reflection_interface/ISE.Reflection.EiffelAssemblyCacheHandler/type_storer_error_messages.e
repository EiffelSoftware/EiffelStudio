indexing
	description: "Error messages for type XML code generation"
	external_name: "ISE.Reflection.TypeStorerErrorMessages"
--	attribute: create {SYSTEM_RUNTIME_INTEROPSERVICES_CLASSINTERFACEATTRIBUTE}.make_classinterfaceattribute (2) end

class
	TYPE_STORER_ERROR_MESSAGES

inherit
	ISE_REFLECTION_SUPPORTERRORMESSAGES
	
feature -- Access	

	File_access_failed: STRING is "File access failed"
		indexing
			description: "Error name: File access failed"
			external_name: "FileAccessFailed"
		end

	File_access_failed_message: STRING is "The XML file access has failed. There may be a sharing violation or the path may be invalid."
		indexing
			description: "Error message when an XML file access has failed"
			external_name: "FileAccessFailedMessage"
		end
		

	Xml_type_generation_failed: STRING is "XML type generation failed"	
		indexing
			description: "Error name: Xml type generation failed"
			external_name: "XmlTypeGenerationFailed"
		end
	
	Xml_type_generation_failed_message: STRING is "The generation of XML description correponding to this type has failed"	
		indexing	
			description: "Error message when Xml type generation has failed"
			external_name: "XmlTypeGenerationFailedMessage"
		end
		
	
	Write_lock_removal_failed: STRING is "Write lock removal failed"
		indexing
			description: "Error name: write lock removal failed"
			external_name: "WriteLockRemovalFailed"
		end
	
	Write_lock_removal_failed_message: STRING is "The removal of write lock has failed. There may be a sharing violation or the folder for current assembly may be corrupted."
		indexing
			description: "Error message when write lock removal failed"
			external_name: "WriteLockRemovalFailedMessage"
		end


	Xml_class_header_generation_failed: STRING is "XML class header generation failed"
		indexing
			description: "Error name: XML class header generation failed"
			external_name: "XmlClassHeaderGenerationFailed"
		end

	Xml_class_header_generation_failed_message: STRING is "The generation of XML elements corresponding to class header has failed."
		indexing
			description: "Error message when XML class header generation has failed"
			external_name: "XmlClassHeaderGenerationFailedMessage"
		end


	Xml_alias_element_generation_failed: STRING is "XML alias element generation failed"
		indexing
			description: "Error name: XML alias element generation failed"
			external_name: "XmlAliasElementGenerationFailed"
		end

	Xml_alias_element_generation_failed_message: STRING is "The generation of XML alias element has failed"
		indexing
			description: "Error message when XML alias element generation has failed"
			external_name: "XmlAliasElementGenerationFailedMessage"
		end
		
	
	Xml_inherit_element_generation_failed: STRING is "XML inherit element generation failed"
		indexing
			description: "Error name: XML inherit element generation failed"
			external_name: "XmlInheritElementGenerationFailed"
		end

	Xml_inherit_element_generation_failed_message: STRING is "The generation of XML inherit element has failed"
		indexing
			description: "Error message when XML inherit element generation has failed"
			external_name: "XmlInheritElementGenerationFailedMessage"
		end
		
	
	Xml_class_body_generation_failed: STRING is "XML class body generation failed"
		indexing
			description: "Error name: XML class body generation failed"
			external_name: "XmlClassBodyGenerationFailed"
		end

	Xml_class_body_generation_failed_message: STRING is "The generation of XML elements corresponding to class body has failed."
		indexing
			description: "Error message when XML class body generation has failed"
			external_name: "XmlClassBodyGenerationFailedMessage"
		end


	Xml_class_footer_generation_failed: STRING is "XML class footer generation failed"
		indexing
			description: "Error name: XML class footer generation failed"
			external_name: "XmlClassFooterGenerationFailed"
		end

	Xml_class_footer_generation_failed_message: STRING is "The generation of XML elements corresponding to class footer has failed."
		indexing
			description: "Error message when XML class footer generation has failed"
			external_name: "XmlClassFooterGenerationFailedMessage"
		end
		
		
	Xml_class_features_generation_failed: STRING is "XML class features generation failed"
		indexing
			description: "Error name: XML class features generation failed"
			external_name: "XmlClassFeaturesGenerationFailed"
		end

	Xml_class_features_generation_failed_message: STRING is "The generation of XML elements corresponding to class features has failed."
		indexing
			description: "Error message when XML class features generation has failed"
			external_name: "XmlClassFeaturesGenerationFailedMessage"
		end


	Xml_feature_arguments_generation_failed: STRING is "XML feature arguments generation failed"
		indexing
			description: "Error name: XML feature arguments generation failed"
			external_name: "XmlFeatureArgumentsGenerationFailed"
		end

	Xml_feature_arguments_generation_failed_message: STRING is "The generation of XML elements corresponding to feature arguments has failed."
		indexing
			description: "Error message when XML feature arguments from XML generation has failed"
			external_name: "XmlFeatureArgumentsGenerationFailedMessage"
		end


	Xml_feature_assertions_generation_failed: STRING is "XML feature assertions generation failed"
		indexing
			description: "Error name: XML feature assertions generation failed"
			external_name: "XmlFeatureAssertionsGenerationFailed"
		end

	Xml_feature_assertions_generation_failed_message: STRING is "The generation of XML elements corresponding to feature assertions has failed."
		indexing
			description: "Error message when XML feature assertions from XML generation has failed"
			external_name: "XmlFeatureAssertionsGenerationFailedMessage"
		end
		
end -- class TYPE_STORER_ERROR_MESSAGES	