indexing
	description: "C/C++ class function used in WIZARD_WRITER_C_CLASS and WIZARD_WRITER_CPP_CLASS"
	status: "See notice at end of class";
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
