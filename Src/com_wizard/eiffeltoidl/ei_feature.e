indexing
	description: "Feature"
	date: "$Date$"
	revision: "$Revision$"

class
	EI_FEATURE

inherit
	WIZARD_SPECIAL_SYMBOLS
		export
			{NONE} all
		end

	EI_APP_CONSTANTS
		export
			{NONE} all
		end

creation
	make
	
feature {NONE} -- Initialization

	make (r_name: STRING) is
			-- Initialize object.  Set 'name' to 'r_name'.
		require
			non_void_name: r_name /= Void
			valid_name: not r_name.is_empty
		do
			name := r_name.twin
			create {ARRAYED_LIST [EI_PARAMETER]} parameters.make (20)
			create result_type.make (0)
			create comment.make (0)
		ensure
			name_set: name.is_equal (r_name)		
		end

feature -- Access

	name: STRING
			-- Name

	comment: STRING
			-- Comment

	parameters: LIST [EI_PARAMETER]
			-- Parameters

	result_type: STRING
			-- Result type

feature -- Element change

	set_name (f_name: STRING) is
			-- Set 'name' to 'f_name'.
		require
			non_void_name: f_name /= Void
			valid_name: not f_name.is_empty
		do
			name := f_name.twin
		ensure
			name_set: name.is_equal (f_name)	
		end

	set_comment (new_comment: STRING) is
			-- Set 'comment' to 'new_comment'.
		require
			non_void_comment: new_comment /= Void
		do
			comment := new_comment.twin
		ensure
			comment_set: comment.is_equal (new_comment)
		end

	set_result_type (new_result_type: STRING) is
			-- Set 'result_type' to 'new_result_type'.
		require
			non_void_type: new_result_type /= Void
			valid_result_type: not new_result_type.is_empty
		do
			result_type := new_result_type.twin
		ensure
			result_type_set: result_type.is_equal (new_result_type)
		end

	add_parameter (para: EI_PARAMETER) is
			-- Add 'para' to 'parameters'.
		require
			non_void_parameter: para /= Void
		do
			parameters.extend (para)
		ensure
			parameter_added: parameters.has (para)
		end

invariant
	valid_name: name /= Void and then not name.is_empty
	non_void_comment: comment /= Void

end -- class EI_FEATURE
