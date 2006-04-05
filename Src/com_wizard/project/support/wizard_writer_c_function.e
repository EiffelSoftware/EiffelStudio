indexing
	description: "C/C++ class function used in WIZARD_WRITER_C_CLASS and WIZARD_WRITER_CPP_CLASS"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_WRITER_C_FUNCTION

inherit
	WIZARD_WRITER_C_MEMBER
		redefine
			generated_header_file
		end

creation
	make

feature -- Access

	signature: STRING
			-- Function signature
	
	is_pure_virtual: BOOLEAN
			-- Is function pure virtual?

	body: STRING
			-- Function body (without "{" and "}")

	generated_code: STRING is
			-- Generated code
		do
			create Result.make (10000)
			Result.append (generated_signature)
			Result.append ("%N%N")
			Result.append (generated_comment)
			Result.append ("{%N")
			Result.append (body)
			Result.append ("%N};")
		end

	generated_header_file: STRING is
			-- Generated header file
		do
			Result := generated_signature
			if is_pure_virtual then
				Result.prepend (" virtual ")
				Result.append (" = 0")
			end
			Result.prepend ("%T")
			Result.prepend (generated_comment)
			Result.append (";%N")
		end

feature -- Element Change

	set_signature (a_signature: like signature) is
			-- Set `signature' with `a_signature'.
		require
			non_void_signature: a_signature /= Void
		do
			signature := a_signature
		ensure
			signature_set: signature.is_equal (a_signature)
		end

	set_body (a_body: like body) is
			-- Set `body' with `a_body'.
		require
			non_void_body: a_body /= Void
		do
			body := a_body
		ensure
			body_set: body.is_equal (a_body)
		end

	set_pure_virtual is
			-- Set `is_pure_virtual' with `True'.
		do
			is_pure_virtual := True
		ensure
			pure_virtual: is_pure_virtual
		end

feature {NONE} -- Implementation

	generated_comment: STRING is
			-- Comment
		require
			can_generate: can_generate
		do
			create Result.make (100)
			Result.append ("%T/*-----------------------------------------------------------%N%T")
			Result.append (comment)
			Result.append ("%N%T-----------------------------------------------------------*/%N")
		end

	generated_signature: STRING is
			-- Signature
		require
			can_generate: can_generate
		do
			create Result.make (100)
			Result.append (result_type)
			Result.append (Space)
			Result.append (name)
			Result.append (Open_parenthesis)
			if signature /= Void then 
				Result.append (Space)
				Result.append (signature)
				Result.append (Space)
			end
			Result.append (Close_parenthesis)
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
end -- class WIZARD_WRITER_C_FUNCTION

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
