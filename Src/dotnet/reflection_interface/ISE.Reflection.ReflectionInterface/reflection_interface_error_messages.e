indexing
	description: "Error messages for reflection"
	external_name: "ISE.Reflection.ReflectionInterfaceErrorMessages"
--	attribute: create {SYSTEM_RUNTIME_INTEROPSERVICES_CLASSINTERFACEATTRIBUTE}.make_classinterfaceattribute (2) end

class
	REFLECTION_INTERFACE_ERROR_MESSAGES

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
		
		
	Has_write_lock: STRING is "Has write lock"
		indexing
			description: "Error name: Has write lock"
			external_name: "HasWriteLock"
		end

	Has_write_lock_message: STRING is "This assembly is currently accessed (for writing) by another process. Please try to access Eiffel repository later."
		indexing
			description: "Error message when there is a write lock"
			external_name: "HasWriteLockMessage"
		end
		
		
	Has_read_lock: STRING is "Has read lock"
		indexing
			description: "Error name: has read lock"
			external_name: "HasReadLock"
		end

	Has_read_lock_message: STRING is "This assembly is currently accessed (for reading) by another process. Please try to access Eiffel repository later."
		indexing
			description: "Error message when there is a read lock"
			external_name: "HasReadLockMessage"
		end

		
	Read_lock_creation_failed: STRING is "Read lock creation failed"
		indexing
			description: "Error name: read lock creation failed"
			external_name: "ReadLockCreationFailed"
		end

	Read_lock_creation_failed_message: STRING is "Creation of a read lock in assembly repository has failed. The folder may be corrupted."
		indexing
			description: "Error message when a write lock creation has failed"
			external_name: "ReadLockCreationFailedMessage"
		end

	
	No_assembly: STRING is "No assembly"
		indexing
			description: "Error name: No assembly"
			external_name: "NoAssembly"
		end

	No_assembly_message: STRING is "There is no assembly in the Eiffel Assembly Cache."
		indexing
			description: "Error message when there is no assembly in the EAC"
			external_name: "NoAssemblyMessage"
		end
		

	No_index: STRING is "No index"
		indexing
			description: "Error name: No index"
			external_name: "NoIndex"
		end

	No_index_message: STRING is "There is no index file listing the assemblies in the Eiffel Assembly Cache."
		indexing
			description: "Error message when there is no index file listing the assemblies in the EAC"
			external_name: "NoIndexMessage"
		end
		
		
	No_such_assembly: STRING is "No such assembly"
		indexing
			description: "Error name: No such assembly"
			external_name: "NoSuchAssembly"
		end

	No_such_assembly_message: STRING is "The Eiffel Assembly Cache does not contain this assembly."
		indexing
			description: "Error message when `index.xml' lists assemblies, which are not in the EAC"
			external_name: "NoSuchAssemblyMessage"
		end
		
		
	Assembly_retrieval_failed: STRING is "Assembly retrieval failed"
		indexing
			description: "Error name: Assembly retrieval failed"
			external_name: "AssemblyRetrievalFailed"
		end

	Assembly_retrieval_failed_message: STRING is "The retrieval of this assembly from Eiffel repository has failed. There may be a sharing violation."
		indexing
			description: "Error message when assembly retrieval has failed"
			external_name: "AssemblyRetrievalFailedMessage"
		end		


	Type_retrieval_failed: STRING is "Type retrieval failed"
		indexing
			description: "Error name: Type retrieval failed"
			external_name: "TypeRetrievalFailed"
		end

	Type_retrieval_failed_message: STRING is "The retrieval of this type from Eiffel repository has failed. There may be a sharing violation."
		indexing
			description: "Error message when assembly retrieval has failed"
			external_name: "TypeRetrievalFailedMessage"
		end	


	No_such_type: STRING is "No such type"
		indexing
			description: "Error name: No such type"
			external_name: "NoSuchType"
		end

	No_such_type_message: STRING is "The Eiffel Assembly Cache does not contain this type."
		indexing
			description: "Error message when `assembly_description.xml' lists types, which are not in the EAC"
			external_name: "NoSuchTypeMessage"
		end
		
		
	Assembly_removal_failed: STRING is "Assembly removal failed"
		indexing
			description: "Error name: Assembly removal failed"
			external_name: "AssemblyRemovalFailed"
		end

	Assembly_removal_failed_message: STRING is "The removal of this assembly from Eiffel repository has failed. There may be a sharing violation."
		indexing
			description: "Error message when assembly removal has failed"
			external_name: "AssemblyRemovalFailedMessage"
		end	


	Invalid_assembly_qualified_name: STRING is "Invalid assembly qualified name"
		indexing
			description: "Error name: Invalid assembly qualified name"
			external_name: "InvalidAssemblyQualifiedName"
		end

	Invalid_assembly_qualified_name_message: STRING is "The assembly qualified name of this type is invalid."
		indexing
			description: "Error message when the assembly qualified name is invalid"
			external_name: "InvalidAssemblyQualifiedNameMessage"
		end

end -- class REFLECTION_INTERFACE_ERROR_MESSAGES