indexing
	description: "Eiffel assertion used in WIZARD_WRITER classes"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_WRITER_ASSERTION

inherit
	WIZARD_WRITER

creation
	make

feature {NONE} -- Initialization

	make (a_tag, a_body: STRING) is
			-- Initialize data.
		require
			non_void_tag: a_tag /= Void
			non_void_body: a_body /= Void
			valid_tag: not a_tag.is_empty
			valid_body: not a_body.is_empty
		do
			tag := a_tag
			body := a_body
		ensure
			tag_set: tag.is_equal (a_tag)
			body_set: body.is_equal (a_body)
		end
	
feature -- Access

	generated_code: STRING is
			-- Generated code
		do
			Result :=  tag.twin
			Result.append (Colon)
			Result.append (Space)
			Result.append (body)
		end

	can_generate: BOOLEAN is
			-- Can code be generated?
		do
			Result := (tag /= Void and then not tag.is_empty) and (body /= Void and then not body.is_empty)
		end
		
	tag: STRING
			-- Assertion tag
	
	body: STRING
			-- Assertion body

feature -- Element Change

	set_tag (a_tag: like tag) is
			-- Set `tag' with `a_tag'.
		require
			non_void_tag: a_tag /= Void
			valid_tag: not a_tag.is_empty
		do
		ensure
			tag_set: tag.is_equal (a_tag)
		end
	
	set_body (a_body: like body) is
			-- Set `body' with `a_body'.
		require
			non_void_body: a_body /= Void
			valid_body: not a_body.is_empty
		do
		ensure
			body_set: body = a_body
		end

end -- class WIZARD_WRITER_ASSERTION

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
