indexing
	description: "Error messages during class edition"
	external_name: "ISE.AssemblyManager.EditErrorMessages"

class
	EDIT_ERROR_MESSAGES

feature -- Access

	Class_exists_error: STRING is "A class of the assembly has the same name. Please choose another name."
			-- Error message in case the class name already exists.
		indexing
			external_name: "ClassExistsError"
		end
	
	Empty_class_name: STRING is "The class name is empty. Please fill this text field."
		indexing
			description: "Error message when class name is empty"
			external_name: "EmptyClassName"
		end
		
	Feature_exists_error: STRING is "The feature name already exists in the current class or one of its descendants. Please choose another name."
			-- Error message in case the feature name is the name of an existing feature of the class or of the children
		indexing
			external_name: "FeatureExistsError"
		end

	Clash_with_feature_name: STRING is "The argument has the same name of an existing feature of the class or one of its descendant. Please choose another name."
			-- Error message in case of clash between argument and features names
		indexing
			external_name: "ClashWithFeatureName"
		end	

	Empty_feature_name: STRING is "The feature name is empty. Please fill this text field."
		indexing
			description: "Error message when a feature name is empty"
			external_name: "EmptyFeatureName"
		end
	
	Feature_clash_with_reserved_word: STRING is "The feature name is an Eiffel reserved word. Please choose another one."
		indexing
			description: "Error message when new feature name is an Eiffel reserved word"
			external_name: "FeatureClashWithReservedWord"
		end
		
	Empty_argument_name: STRING is "The argument name is empty. Please fill this text field."
		indexing
			description: "Error message when an argument name is empty"
			external_name: "EmptyArgumentName"
		end
		
	Argument_name_exists: STRING is "The feature already has an argument with the same name. Please choose another name."
			-- Error message in case the feature already has an argument with the same name
		indexing
			external_name: "ArgumentNameExists"
		end

	Argument_clash_with_reserved_word: STRING is "The argument name is an Eiffel reserved word. Please choose another one."
		indexing
			description: "Error message when new argument name is an Eiffel reserved word"
			external_name: "ArgumentClashWithReservedWord"
		end	

end -- class EDIT_ERROR_MESSAGES
