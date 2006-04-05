indexing
	description: "C/C++ class function used in WIZARD_WRITER_C_CLASS and WIZARD_WRITER_CPP_CLASS"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
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
			Result.append ("%T/*-----------------------------------------------------------%N%T")
			Result.append (comment)
			Result.append ("%N%T-----------------------------------------------------------*/%N%T")
			Result.append (result_type)
			Result.append (" ")
			Result.append (name)
			Result.append (";%N")
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
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
