indexing
	description: "C/C++ class function used in WIZARD_WRITER_C_CLASS and WIZARD_WRITER_CPP_CLASS"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_WRITER_C_MEMBER

inherit
	WIZARD_WRITER
		rename
			generated_code as generated_header_file
		end

creation
	make
	
feature {NONE} -- Initialization

	make is
			-- Initialize data.
		do
		end

feature -- Access

	name: STRING
			-- Function name
		
	result_type: STRING
			-- Function result_type
			
	comment: STRING
			-- Function comment
	
	generated_header_file: STRING is
			-- Generated header file
		do
			create Result.make (100)
			Result.append ("%T/*-----------------------------------------------------------%R%N%T")
			Result.append (comment)
			Result.append ("%R%N%T-----------------------------------------------------------*/%R%N%T")
			Result.append (result_type)
			Result.append (" ")
			Result.append (name)
			Result.append (";%R%N")
		end

	can_generate: BOOLEAN is
			-- Can code be generated?
		do
			Result := name /= Void and then not name.is_empty and result_type /= Void and then not result_type.is_empty and comment /= Void
		end

feature -- Element Change

	set_name (a_name: like name) is
			-- Set `name' with `a_name'.
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.is_empty
		do
			name := a_name
		ensure
			name_set: name.is_equal (a_name)
		end
	
	set_result_type (a_result_type: like result_type) is
			-- Set `result_type' with `a_result_type'.
		require
			non_void_result_type: a_result_type /= Void
			valid_result_type: not a_result_type.is_empty
		do
			result_type := a_result_type.twin
		ensure
			result_type_set: result_type.is_equal (a_result_type)
		end
	
	set_comment (a_comment: like comment) is
			-- Set `comment' with `a_comment'.
		require
			non_void_comment: a_comment /= Void
		do
			comment := a_comment
		ensure
			comment_set: comment.is_equal (a_comment)
		end

end -- class WIZARD_WRITER_C_MEMBER

--+----------------------------------------------------------------
--| EiffelCOM Wizard
--| Copyright (C) 1999-2005 Eiffel Software. All rights reserved.
--| Eiffel Software Confidential
--| Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+----------------------------------------------------------------
