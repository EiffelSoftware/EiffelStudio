indexing
	description: "Warning in an Eiffel class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EIFFEL_WARNING

inherit
	WARNING
		redefine
			has_associated_file
		end

feature -- Properties

	associated_class: CLASS_C
			-- Class where the error is encountered

	file_name: STRING is
			-- File where error is encountered
		do
			Result := associated_class.file_name
		end
		
	has_associated_file: BOOLEAN is True
			-- Current is associated to a file/class

invariant
	associated_class_not_void: associated_class /= Void

end