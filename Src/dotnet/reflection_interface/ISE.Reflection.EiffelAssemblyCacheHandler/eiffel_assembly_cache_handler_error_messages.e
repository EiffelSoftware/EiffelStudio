indexing
	description: "Error messages for type XML code generation"
	external_name: "ISE.Reflection.EiffelAssemblyCacheHandlerErrorMessages"
--	attribute: create {SYSTEM_RUNTIME_INTEROPSERVICES_CLASSINTERFACEATTRIBUTE}.make_classinterfaceattribute (2) end

class
	EIFFEL_ASSEMBLY_CACHE_HANDLER_ERROR_MESSAGES

inherit
	ISE_REFLECTION_SUPPORTERRORMESSAGES
	
feature -- Access	

	Assembly_description_reading_failed: STRING is "Assembly description reading failed"
		indexing
			description: "Error name: Assembly description reading failed"
			external_name: "AssemblyDescriptionReadingFailed"
		end

	Assembly_description_reading_failed_message: STRING is "The reading of assembly description corresponding to this assembly has failed. The file may be corrupted or there may be a sharing violation."
		indexing
			description: "Error message when assembly description reading has failed"
			external_name: "AssemblyDescriptionReadingFailedMessage"
		end
		
		
	Assembly_description_update_failed: STRING is "Assembly description update failed"
		indexing
			description: "Error name: Assembly description update failed"
			external_name: "AssemblyDescriptionUpdateFailed"
		end

	Assembly_description_update_failed_message: STRING is "The update of assembly description corresponding to this assembly has failed. The file may be corrupted or there may be a sharing violation."
		indexing
			description: "Error message when assembly description update has failed"
			external_name: "AssemblyDescriptionUpdateFailedMessage"
		end
		
		
	Assembly_removal_failed: STRING is "Assembly removal failed"
		indexing
			description: "Error name: Assembly removal failed"
			external_name: "AssemblyRemovalFailed"
		end

	Assembly_removal_failed_message: STRING is "The removal of this assembly has failed. The repository may be corrupted or there may be a sharing violation."
		indexing
			description: "Error message when assembly removal has failed"
			external_name: "AssemblyRemovalFailedMessage"
		end
		
		
	Assembly_storage_failed: STRING is "Assembly storage failed"
		indexing
			description: "Error name: Assembly storage failed"
			external_name: "AssemblyStorageFailed"
		end

	Assembly_storage_failed_message: STRING is "The storage of this assembly has failed. There may be a sharing violation."
		indexing
			description: "Error message when assembly storage has failed"
			external_name: "AssemblyStorageFailedMessage"
		end
		
		
	Index_update_failed: STRING is "Index update failed"
		indexing	
			description: "Error name: Index update failed"
			external_name: "IndexUpdateFailed"
		end

	Index_update_failed_message: STRING is "The update of index listing all imported assemblies has failed. The file may be corrupted."
		indexing
			description: "Error message when index update has failed"
			external_name: "IndexUpdateFailedMessage"
		end
		
		
	Assembly_description_generation_failed: STRING is "Assembly description generation failed"
		indexing
			description: "Error name: Assembly description generation failed"
			external_name: "AssemblyDescriptionGenerationFailed"
		end

	Assembly_description_generation_failed_message: STRING is "The generation of XML file describing the assembly has failed. There may be a sharing violation."
		indexing
			description: "Error message when assembly description generation has failed"
			external_name: "AssemblyDescriptionGenerationFailedMessage"
		end
		
		
	Type_storage_failed: STRING is "Type storage failed"
		indexing
			description: "Error name: Type storage failed"
			external_name: "TypeStorageFailed"
		end

	Type_storage_failed_message: STRING is "The storage of this type has failed. There may be a sharing violation."
		indexing
			description: "Error message when type storage has failed"
			external_name: "TypeStorageFailedMessage"
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

		
	Write_lock_creation_failed: STRING is "Write lock creation failed"
		indexing
			description: "Error name: write lock creation failed"
			external_name: "WriteLockCreationFailed"
		end

	Write_lock_creation_failed_message: STRING is "Creation of a write lock in assembly repository has failed. The folder may be corrupted."
		indexing
			description: "Error message when a write lock creation has failed"
			external_name: "WriteLockCreationFailedMessage"
		end


	Assembly_directory_creation_failed: STRING is "Assembly directory creation failed"
		indexing
			description: "Error name: assembly directory creation failed"
			external_name: "AssemblyDirectoryCreationFailed"
		end

	Assembly_directory_creation_failed_message: STRING is "The creation of assembly repository has failed."
		indexing
			description: "Error message when assembly directory creation has failed"
			external_name: "AssemblyDirectoryCreationFailedMessage"
		end
		
end -- class EIFFEL_ASSEMBLY_CACHE_HANDLER_ERROR_MESSAGES