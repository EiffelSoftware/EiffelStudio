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
			valid_syntax: not (a_body.item (1) = '%R') and not (a_body.item (1) = '#') and
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
			Result := Sharp.twin
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
			valid_syntax: not (a_body.item (1) = '%R') and not (a_body.item (1) = '#') and
							not (a_body.item (a_body.count) = '%N') 
		do
			body := a_body
		ensure
			body_set: body.is_equal (a_body)
		end

end -- class WIZARD_WRITER_C_DIRECTIVE

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
