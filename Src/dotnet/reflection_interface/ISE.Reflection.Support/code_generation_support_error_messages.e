indexing
	description: "Error messages for code generation support"
	external_name: "ISE.Reflection.CodeGenerationSupportErrorMessages"

class
	CODE_GENERATION_SUPPORT_ERROR_MESSAGES

inherit
	SUPPORT_ERROR_MESSAGES
	
feature -- Access	

	Write_lock: STRING is "Write lock"
			-- Error name: there is a write lock in currently examined folder
		indexing
			external_name: "WriteLock"
		end

	Write_lock_message: STRING is "The Eiffel repository is being written by another process. No access is possible. Please try later."
			-- Error message when there is a write lock in currently examined folder
		indexing
			external_name: "WriteLockMessage"
		end
		
		
	Read_lock: STRING is "Read lock"
			-- Error name: there is a read lock in currently examined folder
		indexing
			external_name: "ReadLock"
		end

	Read_lock_message: STRING is "The Eiffel repository is being read by another process. No access is possible. Please try later."
			-- Error message when there is a read lock in currently examined folder
		indexing
			external_name: "ReadLockMessage"
		end
		
		
	Eiffel_class_generation_failed: STRING is "Eiffel class generation from XML failed."	
			-- Error name: Eiffel class generation from XML has failed
		indexing
			external_name: "EiffelClassGenerationFailed"
		end
	
	Eiffel_class_generation_failed_message: STRING is "The Eiffel class generation from XML type description has failed."	
			-- Error message when Eiffel class generation from XML has failed
		indexing
			external_name: "EiffelClassGenerationFailedMessage"
		end	
		
	
	Eiffel_assembly_generation_failed: STRING is "Eiffel assembly generation from XML failed."	
			-- Error name: Eiffel assembly generation from XML has failed
		indexing
			external_name: "EiffelAssemblyGenerationFailed"
		end
	
	Eiffel_assembly_generation_failed_message: STRING is "The Eiffel assembly generation from XML assembly description has failed."	
			-- Error message when Eiffel assembly generation from XML has failed
		indexing
			external_name: "EiffelAssemblyGenerationFailedMessage"
		end	


	Class_header_generation_failed: STRING is "Class header generation failed"
			-- Error name: class header generation failed
		indexing
			external_name: "ClassHeaderGenerationFailed"
		end

	Class_header_generation_failed_message: STRING is "The generation of class header from XML code has failed."
			-- Error message when class header generation from XML has failed
		indexing
			external_name: "ClassHeaderGenerationFailedMessage"
		end


	Class_parents_generation_failed: STRING is "Class parents generation failed"
			-- Error name: class parents generation failed
		indexing
			external_name: "ClassParentsGenerationFailed"
		end

	Class_parents_generation_failed_message: STRING is "The generation of class parents from XML code has failed."
			-- Error message when class parents generation from XML has failed
		indexing
			external_name: "ClassParentsGenerationFailedMessage"
		end


	Class_body_generation_failed: STRING is "Class body generation failed"
			-- Error name: class body generation failed
		indexing
			external_name: "ClassBodyGenerationFailed"
		end

	Class_body_generation_failed_message: STRING is "The generation of class body from XML code has failed."
			-- Error message when class body generation from XML has failed
		indexing
			external_name: "ClassBodyGenerationFailedMessage"
		end


	Class_features_generation_failed: STRING is "Class features generation failed"
			-- Error name: class features generation failed
		indexing
			external_name: "ClassFeaturesGenerationFailed"
		end

	Class_features_generation_failed_message: STRING is "The generation of class features from XML code has failed."
			-- Error message when class features generation from XML has failed
		indexing
			external_name: "ClassFeaturesGenerationFailedMessage"
		end


	Class_feature_info_generation_failed: STRING is "Class feature generation failed"
			-- Error name: class feature generation failed
		indexing
			external_name: "ClassFeatureInfoGenerationFailed"
		end

	Class_feature_info_generation_failed_message: STRING is "The generation of class feature corresponding to XML code has failed."
			-- Error message when class feature generation from XML has failed
		indexing
			external_name: "ClassFeatureInfoGenerationFailedMessage"
		end


	Class_feature_arguments_generation_failed: STRING is "Class feature arguments generation failed"
			-- Error name: class feature arguments generation failed
		indexing
			external_name: "ClassFeatureArgumentsGenerationFailed"
		end

	Class_feature_arguments_generation_failed_message: STRING is "The generation of class feature arguments from XML code has failed."
			-- Error message when class feature arguments from XML generation has failed
		indexing
			external_name: "ClassFeatureArgumentsGenerationFailedMessage"
		end


	Class_feature_comments_generation_failed: STRING is "Class feature comments generation failed"
			-- Error name: class feature comments generation failed
		indexing
			external_name: "ClassFeatureCommentsGenerationFailed"
		end

	Class_feature_comments_generation_failed_message: STRING is "The generation of class feature comments from XML code has failed."
			-- Error message when class feature comments generation from XML has failed
		indexing
			external_name: "ClassFeatureCommentsGenerationFailedMessage"
		end


	Class_feature_assertions_generation_failed: STRING is "Class feature assertions generation failed"
			-- Error name: class feature assertions generation failed
		indexing
			external_name: "ClassFeatureAssertionsGenerationFailed"
		end

	Class_feature_assertions_generation_failed_message: STRING is "The generation of class feature assertions from XML code has failed."
			-- Error message when class feature assertions generation from XML code has failed
		indexing
			external_name: "ClassFeatureAssertionsGenerationFailedMessage"
		end


	Class_footer_generation_failed: STRING is "Class footer generation failed"
			-- Error name: class footer generation failed
		indexing
			external_name: "ClassFooterGenerationFailed"
		end

	Class_footer_generation_failed_message: STRING is "The generation of class footer from XML code has failed."
			-- Error message when class footer generation from XML code has failed
		indexing
			external_name: "ClassFooterGenerationFailedMessage"
		end
		
end -- class CODE_GENERATION_SUPPORT_ERROR_MESSAGES	