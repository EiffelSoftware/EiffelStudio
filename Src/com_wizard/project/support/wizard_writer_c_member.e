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
			Result.append (tab)
			Result.append (C_open_comment_line)
			Result.append (New_line_tab)
			Result.append (comment)
			Result.append (New_line_tab)
			Result.append (C_close_comment_line)
			Result.append (New_line_tab)
			Result.append (result_type)
			Result.append (Space)
			Result.append (name)
			Result.append (Semicolon)
			Result.append (New_line)
		end

	can_generate: BOOLEAN is
			-- Can code be generated?
		do
			Result := (name /= Void and then not name.is_empty) and
						(result_type /= Void and then not result_type.is_empty) and
						(comment /= Void and then not comment.is_empty)
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
			result_type := clone (a_result_type)
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

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1988-1999 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support http://support.eiffel.com
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
  