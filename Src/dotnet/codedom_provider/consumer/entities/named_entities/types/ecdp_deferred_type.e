indexing
	description: "Eiffel deferred type"
	date: "$$"
	revision: "$$"	
	
class
	ECDP_DEFERRED_TYPE
	
inherit
	ECDP_GENERATED_TYPE
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
			Result.append (dictionary.Deferred_keyword)
			Result.append (dictionary.Space)
			Result.append (dictionary.Class_keyword)
			Result.append (dictionary.New_line)
			Result.append (dictionary.Tab)
			Result.append (name.twin)
			Result.append (dictionary.New_line)
		end

end -- class ECDP_DEFERRED_TYPE

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