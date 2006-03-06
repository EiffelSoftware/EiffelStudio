indexing
	description: "Eiffel sealed type"
	date: "$$"
	revision: "$$"	
	
class
	CODE_FROZEN_TYPE

inherit
	CODE_GENERATED_TYPE
		redefine
			class_declaration
		end

create 
	make

feature {NONE} -- Code Generation

	class_declaration: STRING is 
			-- Class declaration (including class name and qualifiers like deferred, expanded or frozen)
		do
			create Result.make (120)
			Result.append ("frozen class")
			Result.append (Line_return)
			Result.append ("%T")
			Result.append (name.twin)
			Result.append (Line_return)
		end
		
end -- class CODE_FROZEN_TYPE

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2006 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------