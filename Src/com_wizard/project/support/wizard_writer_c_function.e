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
			create Result.make (0)
			Result.append (generated_signature)
			Result.append (New_line)
			Result.append (New_line)
			Result.append (generated_comment)
			Result.append (Open_curly_brace)
			Result.append (New_line)
			Result.append (body)
			Result.append (New_line)
			Result.append (Close_curly_brace)
			Result.append (Semicolon)
		end

	generated_header_file: STRING is
			-- Generated header file
		do
			
			Result := generated_signature
			if is_pure_virtual then
				Result.prepend (Space)
				Result.prepend (clone (Virtual))
				Result.append (Pure_virtual_sufix)
			end
			Result.prepend (tab)
			Result.prepend (generated_comment)
			Result.append (Semicolon)
			Result.append (New_line)
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
			valid_syntax: not (a_body.item (1) = '%N') and not (a_body.item (1) = '{') and
							not (a_body.item (a_body.count) = '%N') and not (a_body.item (a_body.count) = '}')
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
			create Result.make (0)
			Result.append (tab)
			Result.append (C_open_comment_line)
			Result.append (New_line_tab)
			Result.append (comment)
			Result.append (New_line_tab)
			Result.append (C_close_comment_line)
			Result.append (New_line)
		end

	generated_signature: STRING is
			-- Signature
		require
			can_generate: can_generate
		do
			create Result.make (0)
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
  