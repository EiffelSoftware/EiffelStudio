indexing
	description: "C/C++ directive (e.g. #ifdef, #ifndef, #else, ...)"
	status: "See notice at end of class";
	date: "$ $"
	revision: "$  $"

class
	WIZARD_WRITER_C_DIRECTIVE

inherit
	WIZARD_WRITER

creation
	make

feature {NONE} -- Initialization

	make (a_body: STRING) is
			-- Set `body' with `a_body'.
		require
			non_void_body: a_body /= Void
			valid_syntax: not (a_body.item (1) = '%N') and not (a_body.item (1) = '#') and
							not (a_body.item (a_body.count) = '%N') 
		do
			body := a_body
		ensure
			body_set: body.is_equal (a_body)
		end
			
feature -- Access

	generated_code: STRING is
			-- Generated code
		do
			Result := clone (Sharp)
			Result.append (body)
		end

	can_generate: BOOLEAN is
			-- Can code be generated?
		do
			Result := body /= Void
		end

	body: STRING
			-- Directive body

feature -- Element Change

	set_body (a_body: like body) is
			-- Set `body' with `a_body'.
		require
			non_void_body: a_body /= Void
			valid_syntax: not (a_body.item (1) = '%N') and not (a_body.item (1) = '#') and
							not (a_body.item (a_body.count) = '%N') 
		do
			body := a_body
		ensure
			body_set: body.is_equal (a_body)
		end

end -- class WIZARD_WRITER_C_DIRECTIVE

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
  
