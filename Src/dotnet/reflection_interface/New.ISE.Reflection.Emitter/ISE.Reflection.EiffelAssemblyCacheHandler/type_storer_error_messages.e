indexing
	description: "Error messages for type XML code generation"
--	attribute: create {SYSTEM_RUNTIME_INTEROPSERVICES_CLASSINTERFACEATTRIBUTE}.make_classinterfaceattribute (2) end

class
	TYPE_STORER_ERROR_MESSAGES

inherit
	SUPPORT_ERROR_MESSAGES
	
feature -- Access	

	Assembly_description_update_failed: STRING is "Assembly description update failed"
		indexing
			description: "Error name: Assembly description update failed"
		end

	Assembly_description_update_failed_message: STRING is "The update of assembly description corresponding to this assembly has failed. The file may be corrupted or there may be a sharing violation."
		indexing
			description: "Error message when assembly description update has failed"
		end


	File_access_failed: STRING is "File access failed"
		indexing
			description: "Error name: File access failed"
		end

	File_access_failed_message: STRING is "The XML file access has failed. There may be a sharing violation or the path may be invalid."
		indexing
			description: "Error message when an XML file access has failed"
		end
		

	Xml_type_generation_failed: STRING is "XML type generation failed"	
		indexing
			description: "Error name: Xml type generation failed"
		end
	
	Xml_type_generation_failed_message: STRING is "The generation of XML description corresponding to this type has failed"	
		indexing	
			description: "Error message when Xml type generation has failed"
		end
		
	
	Write_lock_removal_failed: STRING is "Write lock removal failed"
		indexing
			description: "Error name: write lock removal failed"
		end
	
	Write_lock_removal_failed_message: STRING is "The removal of write lock has failed. There may be a sharing violation or the folder for current assembly may be corrupted."
		indexing
			description: "Error message when write lock removal failed"
		end


	Xml_class_header_generation_failed: STRING is "XML class header generation failed"
		indexing
			description: "Error name: XML class header generation failed"
		end

	Xml_class_header_generation_failed_message: STRING is "The generation of XML elements corresponding to class header has failed."
		indexing
			description: "Error message when XML class header generation has failed"
		end


	Xml_alias_element_generation_failed: STRING is "XML alias element generation failed"
		indexing
			description: "Error name: XML alias element generation failed"
		end

	Xml_alias_element_generation_failed_message: STRING is "The generation of XML alias element has failed"
		indexing
			description: "Error message when XML alias element generation has failed"
		end
		
	
	Xml_inherit_element_generation_failed: STRING is "XML inherit element generation failed"
		indexing
			description: "Error name: XML inherit element generation failed"
		end

	Xml_inherit_element_generation_failed_message: STRING is "The generation of XML inherit element has failed"
		indexing
			description: "Error message when XML inherit element generation has failed"
		end
		
	
	Xml_class_body_generation_failed: STRING is "XML class body generation failed"
		indexing
			description: "Error name: XML class body generation failed"
		end

	Xml_class_body_generation_failed_message: STRING is "The generation of XML elements corresponding to class body has failed."
		indexing
			description: "Error message when XML class body generation has failed"
		end


	Xml_class_footer_generation_failed: STRING is "XML class footer generation failed"
		indexing
			description: "Error name: XML class footer generation failed"
		end

	Xml_class_footer_generation_failed_message: STRING is "The generation of XML elements corresponding to class footer has failed."
		indexing
			description: "Error message when XML class footer generation has failed"
		end
		
		
	Xml_class_features_generation_failed: STRING is "XML class features generation failed"
		indexing
			description: "Error name: XML class features generation failed"
		end

	Xml_class_features_generation_failed_message: STRING is "The generation of XML elements corresponding to class features has failed."
		indexing
			description: "Error message when XML class features generation has failed"
		end


	Xml_feature_arguments_generation_failed: STRING is "XML feature arguments generation failed"
		indexing
			description: "Error name: XML feature arguments generation failed"
		end

	Xml_feature_arguments_generation_failed_message: STRING is "The generation of XML elements corresponding to feature arguments has failed."
		indexing
			description: "Error message when XML feature arguments from XML generation has failed"
		end


	Xml_feature_assertions_generation_failed: STRING is "XML feature assertions generation failed"
		indexing
			description: "Error name: XML feature assertions generation failed"
		end

	Xml_feature_assertions_generation_failed_message: STRING is "The generation of XML elements corresponding to feature assertions has failed."
		indexing
			description: "Error message when XML feature assertions from XML generation has failed"
		end
		
end -- class TYPE_STORER_ERROR_MESSAGES	
