indexing
	description: "Eiffel deferred type"
	date: "$$"
	revision: "$$"	
	
class
	CODE_DEFERRED_TYPE
	
inherit
	CODE_GENERATED_TYPE
		redefine
			class_declaration
		end
		
create 
	make

feature -- Access

	is_interface: BOOLEAN
			-- Is generated type an interface?

feature -- Element Settings

	set_is_interface is
			-- Set `is_interface' to `True'.
		do
			is_interface := True
		ensure
			is_interface_set: is_interface
		end		

feature {NONE} -- Code Generation

	class_declaration: STRING is 
			-- Class declaration (including class name and qualifiers like deferred, expanded or frozen)
		do	
			create Result.make (120)
			Result.append ("deferred class%N%T")
			Result.append (name.twin)
			Result.append_character ('%N')
		end

end -- class CODE_DEFERRED_TYPE

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------