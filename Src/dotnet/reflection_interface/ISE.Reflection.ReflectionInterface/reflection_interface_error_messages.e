indexing
	description: "Error messages for reflection"
	external_name: "ISE.Reflection.ReflectionInterfaceErrorMessages"

class
	REFLECTION_INTERFACE_ERROR_MESSAGES

inherit
	ISE_REFLECTION_SUPPORTERRORMESSAGES
	
feature -- Access	

	File_access_failed: STRING is "File access failed"
			-- Error name: File access failed
		indexing
			external_name: "FileAccessFailed"
		end

	File_access_failed_message: STRING is "The XML file access has failed. There may be a sharing violation or the path may be invalid."
			-- Error message when an XML file access has failed
		indexing
			external_name: "FileAccessFailedMessage"
		end
		
		
	Has_write_lock: STRING is "Has write lock"
			-- Error name: Has write lock
		indexing
			external_name: "HasWriteLock"
		end

	Has_write_lock_message: STRING is "This assembly is currently accessed (for writing) by another process. Please try to access Eiffel repository later."
			-- Error message when there is a write lock
		indexing
			external_name: "HasWriteLockMessage"
		end
		
		
	Has_read_lock: STRING is "Has read lock"
			-- Error name: has read lock
		indexing
			external_name: "HasReadLock"
		end

	Has_read_lock_message: STRING is "This assembly is currently accessed (for reading) by another process. Please try to access Eiffel repository later."
			-- Error message when there is a read lock
		indexing
			external_name: "HasReadLockMessage"
		end

		
	Read_lock_creation_failed: STRING is "Read lock creation failed"
			-- Error name: read lock creation failed
		indexing
			external_name: "ReadLockCreationFailed"
		end

	Read_lock_creation_failed_message: STRING is "Creation of a read lock in assembly repository has failed. The folder may be corrupted."
			-- Error message when a write lock creation has failed
		indexing
			external_name: "ReadLockCreationFailedMessage"
		end

	
	Assemblies_retrieval_failed: STRING is "Assemblies retrieval failed"
			-- Error name: Assemblies retrieval failed
		indexing
			external_name: "AssembliesRetrievalFailed"
		end

	Assemblies_retrieval_failed_message: STRING is "The retrieval of assemblies from Eiffel repository has failed. There may be a sharing violation."
			-- Error message when assemblies retrieval has failed
		indexing
			external_name: "AssembliesRetrievalFailedMessage"
		end
		

	Assembly_retrieval_failed: STRING is "Assembly retrieval failed"
			-- Error name: Assembly retrieval failed
		indexing
			external_name: "AssemblyRetrievalFailed"
		end

	Assembly_retrieval_failed_message: STRING is "The retrieval of this assembly from Eiffel repository has failed. There may be a sharing violation."
			-- Error message when assembly retrieval has failed
		indexing
			external_name: "AssemblyRetrievalFailedMessage"
		end		


	Type_retrieval_failed: STRING is "Type retrieval failed"
			-- Error name: Type retrieval failed
		indexing
			external_name: "TypeRetrievalFailed"
		end

	Type_retrieval_failed_message: STRING is "The retrieval of this type from Eiffel repository has failed. There may be a sharing violation."
			-- Error message when assembly retrieval has failed
		indexing
			external_name: "TypeRetrievalFailedMessage"
		end	


	Assembly_removal_failed: STRING is "Assembly removal failed"
			-- Error name: Assembly removal failed
		indexing
			external_name: "AssemblyRemovalFailed"
		end

	Assembly_removal_failed_message: STRING is "The removal of this assembly from Eiffel repository has failed. There may be a sharing violation."
			-- Error message when assembly removal has failed
		indexing
			external_name: "AssemblyRemovalFailedMessage"
		end	


	Invalid_assembly_qualified_name: STRING is "Invalid assembly qualified name"
			-- Error name: Invalid assembly qualified name
		indexing
			external_name: "InvalidAssemblyQualifiedName"
		end

	Invalid_assembly_qualified_name_message: STRING is "The assembly qualified name of this type is invalid."
			-- Error message when the assembly qualified name is invalid
		indexing
			external_name: "InvalidAssemblyQualifiedNameMessage"
		end

end -- class REFLECTION_INTERFACE_ERROR_MESSAGES