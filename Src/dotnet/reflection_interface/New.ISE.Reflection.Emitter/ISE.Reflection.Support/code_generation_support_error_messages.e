indexing
	description: "Error messages for code generation support"
--	attribute: create {SYSTEM_RUNTIME_INTEROPSERVICES_CLASSINTERFACEATTRIBUTE}.make_classinterfaceattribute (2) end

class
	CODE_GENERATION_SUPPORT_ERROR_MESSAGES

inherit
	SUPPORT_ERROR_MESSAGES
	
feature -- Access	

	Write_lock: STRING is "Write lock"
		indexing
			description: "Error name: there is a write lock in currently examined folder"
		end

	Write_lock_message: STRING is "The Eiffel repository is being written by another process. No access is possible. Please try later."
		indexing
			description: "Error message when there is a write lock in currently examined folder"
		end
		
		
	Read_lock: STRING is "Read lock"
		indexing
			description: "Error name: there is a read lock in currently examined folder"
		end

	Read_lock_message: STRING is "The Eiffel repository is being read by another process. No access is possible. Please try later."
		indexing
			description: "Error message when there is a read lock in currently examined folder"
		end
		
		
	Eiffel_class_generation_failed: STRING is "Eiffel class generation from XML failed."	
		indexing
			description: "Error name: Eiffel class generation from XML has failed"
		end
	
	Eiffel_class_generation_failed_message: STRING is "The Eiffel class generation from XML type description has failed."	
		indexing
			description: "Error message when Eiffel class generation from XML has failed"
		end	
		
	
	Eiffel_assembly_generation_failed: STRING is "Eiffel assembly generation from XML failed."	
		indexing
			description: "Error name: Eiffel assembly generation from XML has failed"
		end
	
	Eiffel_assembly_generation_failed_message: STRING is "The Eiffel assembly generation from XML assembly description has failed."	
		indexing
			description: "Error message when Eiffel assembly generation from XML has failed"
		end	


	Class_header_generation_failed: STRING is "Class header generation failed"
		indexing
			description: "Error name: class header generation failed"
		end

	Class_header_generation_failed_message: STRING is "The generation of class header from XML code has failed."
		indexing
			description: "Error message when class header generation from XML has failed"
		end


	Generic_derivation_generation_failed: STRING is "Generic derivations generation failed."
		indexing
			description: "Error name: generic derivation generation failed"
		end
		
	Generic_derivation_generation_failed_message: STRING is "The generation of the derivations of this generic class from XML code has failed."
		indexing
			description: "Error message when generic derivations generation from XML has failed"
		end
		
	Class_parents_generation_failed: STRING is "Class parents generation failed"
		indexing
			description: "Error name: class parents generation failed"
		end

	Class_parents_generation_failed_message: STRING is "The generation of class parents from XML code has failed."
		indexing
			description: "Error message when class parents generation from XML has failed"
		end


	Class_body_generation_failed: STRING is "Class body generation failed"
		indexing
			description: "Error name: class body generation failed"
		end

	Class_body_generation_failed_message: STRING is "The generation of class body from XML code has failed."
		indexing
			description: "Error message when class body generation from XML has failed"
		end


	Class_features_generation_failed: STRING is "Class features generation failed"
		indexing
			description: "Error name: class features generation failed"
		end

	Class_features_generation_failed_message: STRING is "The generation of class features from XML code has failed."
		indexing
			description: "Error message when class features generation from XML has failed"
		end


	Class_feature_info_generation_failed: STRING is "Class feature generation failed"
		indexing
			description: "Error name: class feature generation failed"
		end

	Class_feature_info_generation_failed_message: STRING is "The generation of class feature corresponding to XML code has failed."
		indexing
			description: "Error message when class feature generation from XML has failed"
		end


	Class_feature_arguments_generation_failed: STRING is "Class feature arguments generation failed"
		indexing
			description: "Error name: class feature arguments generation failed"
		end

	Class_feature_arguments_generation_failed_message: STRING is "The generation of class feature arguments from XML code has failed."
		indexing
			description: "Error message when class feature arguments from XML generation has failed"
		end


	Class_feature_comments_generation_failed: STRING is "Class feature comments generation failed"
		indexing
			description: "Error name: class feature comments generation failed"
		end

	Class_feature_comments_generation_failed_message: STRING is "The generation of class feature comments from XML code has failed."
		indexing
			description: "Error message when class feature comments generation from XML has failed"
		end


	Class_feature_assertions_generation_failed: STRING is "Class feature assertions generation failed"
		indexing
			description: "Error name: class feature assertions generation failed"
		end

	Class_feature_assertions_generation_failed_message: STRING is "The generation of class feature assertions from XML code has failed."
		indexing
			description: "Error message when class feature assertions generation from XML code has failed"
		end


	Class_footer_generation_failed: STRING is "Class footer generation failed"
		indexing
			description: "Error name: class footer generation failed"
		end

	Class_footer_generation_failed_message: STRING is "The generation of class footer from XML code has failed."
		indexing
			description: "Error message when class footer generation from XML code has failed"
		end
		
end -- class CODE_GENERATION_SUPPORT_ERROR_MESSAGES	