indexing
	description: "Eiffel value type"
	date: "$$"
	revision: "$$"	
	
class
	CODE_FROZEN_EXPANDED_TYPE

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
			create Result.make (100)
			Result.append (dictionary.Frozen_keyword)
			Result.append (dictionary.Space)
			Result.append (dictionary.Expanded_keyword)
			Result.append (dictionary.Space)
			Result.append (dictionary.Class_keyword)
			Result.append (dictionary.New_line)
			Result.append (dictionary.Tab)
			Result.append (name.twin)
			Result.append (dictionary.New_line)
		end

end -- class CODE_FROZEN_EXPANDED_TYPE

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