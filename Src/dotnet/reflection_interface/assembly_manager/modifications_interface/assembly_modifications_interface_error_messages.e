indexing
	description: "Error messages for assembly modifications interface"
	external_name: "ISE.AssemblyManager.AssemblyModificationsInterface"

class
	ASSEMBLY_MODIFICATIONS_INTERFACE_ERROR_MESSAGES

inherit
	ISE_REFLECTION_SUPPORTERRORMESSAGES
	
feature -- Access	

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

	Assemblies_modifications_retrieval_failed: STRING is "Assemblies modifications retrieval failed"
			-- Error name: Assemblies modifications retrieval failed
		indexing
			external_name: "AssembliesModificationsRetrievalFailed"
		end

	Assemblies_modifications_retrieval_failed_message: STRING is "The retrieval of assemblies modifications has failed. There may be a sharing violation."
			-- Error message when assemblies retrieval has failed
		indexing
			external_name: "AssembliesModificationsRetrievalFailedMessage"
		end
		

	Assembly_modifications_descriptor_retrieval_failed: STRING is "Assembly modifications descriptor retrieval failed"
			-- Error name: Assembly modifications descriptor retrieval failed
		indexing
			external_name: "AssemblyModificationsDescriptorRetrievalFailed"
		end

	Assembly_modifications_descriptor_retrieval_failed_message: STRING is "The retrieval of modifications descriptor for this assembly has failed. There may be a sharing violation."
			-- Error message when assembly modifications descriptor retrieval has failed
		indexing
			external_name: "AssemblyModificationsDescriptorRetrievalFailedMessage"
		end		

	Assembly_modifications_descriptor_generation_failed: STRING is "Assembly modifications descriptor generation failed"
			-- Error name: Assembly modifications descriptor generation failed
		indexing
			external_name: "AssemblyModificationsDescriptorGenerationFailed"
		end
	
	Assembly_modifications_descriptor_generation_failed_message: STRING is "The generation of assembly modifications descriptor has failed. There may be a sharing violation or a file may be corrupted."
			-- Error message when the generation of assembly modifications descriptor has failed
		indexing
			external_name: "AssemblyModificationsDescriptorGenerationFailedMessage"
		end
	
end -- class ASSEMBLY_MODIFICATIONS_INTERFACE_ERROR_MESSAGES