indexing
	description: "C++ Constructor Writer"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	 WIZARD_WRITER_CPP_CONSTRUCTOR

inherit
	WIZARD_WRITER

creation
	make

feature {NONE} -- Initialization

	make is
			-- Initialize data.
		do
		end

feature -- Access

	generated_code: STRING is
			-- Generated code
		do
			Result := clone (Open_parenthesis)
			if signature /= Void then
				Result.append (Space)
				Result.append (signature)
				Result.append (Space)
			end
			Result.append (clone (Close_parenthesis))
			Result.append (New_line)
			Result.append (Open_curly_brace)
			Result.append (New_line)
			if body /= Void then
				Result.append (body)
				Result.append (New_line)
			end
			Result.append (Close_curly_brace)
			Result.append (Semicolon)
		end

	can_generate: BOOLEAN is
			-- Can code be generated?
		do
			Result := True
		end

	signature: STRING
			-- Constructor signature
	
	body: STRING
			-- Code of body

feature -- Element Change

	set_signature (a_signature: like signature) is
			-- Set `signature' with `a_signature'.
		require
			signature_not_void: a_signature /= Void
		do
			signature := clone (a_signature)
		ensure
			signature_set: signature.is_equal (a_signature)
		end

	set_body (a_body: like body) is
			-- Set `body' with `a_body'
		require
			body_not_void: a_body /= Void
		do
			body := clone (a_body)
		ensure
			body_set: body.is_equal (a_body)
		end
	
end -- class WIZARD_WRITER_CPP_CONSRUCTOR

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
  