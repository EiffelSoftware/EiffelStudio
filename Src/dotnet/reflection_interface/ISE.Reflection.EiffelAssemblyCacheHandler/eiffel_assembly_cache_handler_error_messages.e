indexing
	description: "Error messages for type XML code generation"
	external_name: "ISE.Reflection.EiffelAssemblyCacheHandlerErrorMessages"

class
	EIFFEL_ASSEMBLY_CACHE_HANDLER_ERROR_MESSAGES

inherit
	ISE_REFLECTION_SUPPORTERRORMESSAGES
	
feature -- Access	

	Assembly_removal_failed: STRING is "Assembly removal failed"
			-- Error name: Assembly removal failed
		indexing
			external_name: "AssemblyRemovalFailed"
		end

	Assembly_removal_failed_message: STRING is "The removal of this assembly has failed. The repository may be corrupted or there may be a sharing violation."
			-- Error message when assembly removal has failed
		indexing
			external_name: "AssemblyRemovalFailedMessage"
		end
		
		
	Assembly_storage_failed: STRING is "Assembly storage failed"
			-- Error name: Assembly storage failed
		indexing
			external_name: "AssemblyStorageFailed"
		end

	Assembly_storage_failed_message: STRING is "The storage of this assembly has failed. There may be a sharing violation."
			-- Error message when assembly storage has failed
		indexing
			external_name: "AssemblyStorageFailedMessage"
		end
		
		
	Index_update_failed: STRING is "Index update failed"
			-- Error name: Index update failed
		indexing
			external_name: "IndexUpdateFailed"
		end

	Index_update_failed_message: STRING is "The update of index listing all imported assemblies has failed. The file may be corrupted."
			-- Error message when index update has failed
		indexing
			external_name: "IndexUpdateFailedMessage"
		end
		
		
	Assembly_description_generation_failed: STRING is "Assembly description generation failed"
			-- Error name: Assembly description generation failed
		indexing
			external_name: "AssemblyDescriptionGenerationFailed"
		end

	Assembly_description_generation_failed_message: STRING is "The generation of XML file describing the assembly has failed. There may be a sharing violation."
			-- Error message when assembly description generation has failed
		indexing
			external_name: "AssemblyDescriptionGenerationFailedMessage"
		end
		
		
	Type_storage_failed: STRING is "Type storage failed"
			-- Error name: Type storage failed
		indexing
			external_name: "TypeStorageFailed"
		end

	Type_storage_failed_message: STRING is "The storage of this type has failed. There may be a sharing violation."
			-- Error message when type storage has failed
		indexing
			external_name: "TypeStorageFailedMessage"
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

		
	Write_lock_creation_failed: STRING is "Write lock creation failed"
			-- Error name: write lock creation failed
		indexing
			external_name: "WriteLockCreationFailed"
		end

	Write_lock_creation_failed_message: STRING is "Creation of a write lock in assembly repository has failed. The folder may be corrupted."
			-- Error message when a write lock creation has failed
		indexing
			external_name: "WriteLockCreationFailedMessage"
		end


	Assembly_directory_creation_failed: STRING is "Assembly directory creation failed"
			-- Error name: assembly directory creation failed
		indexing
			external_name: "AssemblyDirectoryCreationFailed"
		end

	Assembly_directory_creation_failed_message: STRING is "The creation of assembly repository has failed."
			-- Error message when assembly directory creation has failed
		indexing
			external_name: "AssemblyDirectoryCreationFailedMessage"
		end
		
end -- class EIFFEL_ASSEMBLY_CACHE_HANDLER_ERROR_MESSAGES