indexing
	description: "Error messages"
	external_name: "ISE.Reflection.ErrorMessages"

class
	ERROR_MESSAGES

feature -- Reflection error names
	
	Write_lock_found_during_storage_name: STRING is "Write lock found during storage"
			-- Error code: 1
		indexing
			external_name: "WriteLockFoundDuringStorageName"
		end
		
	Read_lock_found_during_storage_name: STRING is "Read lock found during storage"
			-- Error code: 2
		indexing
			external_name: "ReadLockFoundDuringStorageName"
		end
		
	Write_lock_creation_failed_name: STRING is "Write lock creation failed"
			-- Error code: 3
		indexing
			external_name: "WriteLockCreationFailedName"
		end
		
	Assembly_directory_creation_failed_name: STRING is "Assembly directory creation failed"
			-- Error code: 4
		indexing
			external_name: "AssemblyDirectoryCreationFailedName"
		end
		
	Xml_file_creation_failed_name: STRING is "XML file creation failed"
			-- Error code: 5
		indexing
			external_name: "XmlFileCreationFailedName"
		end
		
	Xml_file_opening_failed_name: STRING is "XML file opening failed"
			-- Error code: 6
		indexing
			external_name: "XmlFileOpeningFailedName"
		end
		
	Empty_XML_file_name: STRING is "Empty XML file"
			-- Error code: 7
		indexing
			external_name: "EmptyXmlFileName"
		end
		
	Write_lock_found_during_retrieval_name: STRING is "Write lock found during retrieval"
			-- Error code: 8
		indexing
			external_name: "WriteLockFoundDuringRetrievalName"
		end
		
	Read_lock_found_during_retrieval_name: STRING is "Read lock found during retrieval"
			-- Error code: 9
		indexing
			external_name: "ReadLockFoundDuringRetrievalName"
		end
		
	Read_lock_creation_failed_name: STRING is "Read lock creation failed"
			-- Error code: 10 
		indexing
			external_name: "ReadLockCreationFailedName"
		end
		
	Write_lock_found_during_removal_name: STRING is "Write lock found during removal"
			-- Error code: 11
		indexing
			external_name: "WriteLockFoundDuringRemovalName"
		end
		
	Read_lock_found_during_removal_name: STRING is "Read lock found during removal"
			-- Error code: 12		
		indexing
			external_name: "ReadLockFoundDuringRemovalName"
		end
		
	Invalid_assembly_qualified_name: STRING is "Invalid assembly qualified name"
			-- Error code: 13
		indexing
			external_name: "InvalidAssemblyQualifiedName"
		end
	
	Types_retrieval_failed_name: STRING is "Types retrieval failed"
			-- Error code: 14
		indexing
			external_name: "TypesRetrievalFailedName"
		end
		
feature -- Reflection error descriptions
	
	Write_lock_found_during_storage_description: STRING is "Storage has failed because another process is currently writting in the database."
			-- Error code: 1	
		indexing
			external_name: "WriteLockFoundDuringStorageDescription"
		end
		
	Read_lock_found_during_storage_description: STRING is "Storage has failed because another process is currently reading in the database."
			-- Error code: 2
		indexing
			external_name: "ReadLockFoundDuringStorageDescription"
		end
	
	Write_lock_creation_failed_description: STRING is "An error occurred while creating write lock. You may not have required permission or the given path may be invalid."
			-- Error code: 3			
		indexing
			external_name: "WriteLockCreationFailedDescription"
		end

	Assembly_directory_creation_failed_description: STRING is "Creation of assembly directory failed. The given path may be invalid (either too long or containing special characters) or you may not have the required permission."
			-- Error code: 4
		indexing
			external_name: "AssemblyDirectoryCreationFailedDescription"
		end
			
	Xml_file_creation_failed_description: STRING is "Creation of XML file describing type failed. You may not have required permission or the given path may be invalid."
			-- Error code: 5
		indexing
			external_name: "XmlFileCreationFailedDescription"
		end

	Xml_file_opening_failed_description: STRING is "Opening of XML file describing type failed. You may not have required permission or the given path may be invalid."
			-- Error code: 6
		indexing
			external_name: "XmlFileOpeningFailedDescription"
		end

	Empty_XML_file_description: STRING is "XML file is empty : this cannot be a valid type description. You should call the new emitter with corresponding assembly as target to generate valid XML files."
			-- Error code: 7 
		indexing
			external_name: "EmptyXmlFileDescription"
		end

	Write_lock_found_during_retrieval_description: STRING is "Retrieval has failed because another process is currently writting in the database."
			-- Error code: 8
		indexing
			external_name: "WriteLockFoundDuringRetrievalDescription"
		end

	Read_lock_found_during_retrieval_description: STRING is "Retrieval has failed because another process is currently reading in the database."
			-- Error code: 9
		indexing
			external_name: "ReadLockFoundDuringRetrievalDescription"
		end
			
	Read_lock_creation_failed_description: STRING is "An error occurred while creating read lock. You may not have required permission or the given path may be invalid."
			-- Error code: 10			
		indexing
			external_name: "ReadLockCreationFailedDescription"
		end
			
	Write_lock_found_during_removal_description: STRING is "Assembly removal has failed because another process is currently writting in the database."
			-- Error code: 11
		indexing
			external_name: "WriteLockFoundDuringRemovalDescription"
		end

	Read_lock_found_during_removal_description: STRING is "Assembly removal has failed because another process is currently reading in the database."
			-- Error code: 12
		indexing
			external_name: "ReadLockFoundDuringRemovalDescription"
		end
	
	Invalid_assembly_qualified_name_description: STRING is "Type has an invalid assembly qualified name. Make sure that assembly defining type is in the global assembly cache. If not, you should use command: `gacutil -i assembly_name', where `assembly_name' is the name of the assembly you want to put in the cache."
			-- Error code: 13
		indexing
			external_name: "InvalidAssemblyQualifiedNameDescription"
		end

	Types_retrieval_failed_description: STRING is "Types retrieval has failed. The created list may be read-only."
			-- Error code: 14
		indexing
			external_name: "TypesRetrievalFailedDescription"
		end
		
end -- class ERROR_MESSAGES