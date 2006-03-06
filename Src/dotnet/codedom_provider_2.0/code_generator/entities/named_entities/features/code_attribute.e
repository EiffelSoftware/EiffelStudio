indexing 
	description: "Eiffel attribute"
	date: "$$"
	revision: "$$"	

class
	CODE_ATTRIBUTE

inherit
	CODE_FEATURE

create
	make

feature -- Access

	code: STRING is
			-- | call 'generated_attribute' then 'generated_comments'
			-- | Result := "feature [{exports,...}] -- feature_type
			-- |				[frozen] `attribute_name': `type'
			-- |					[-- comments ..."]
			
			-- Eiffel code of attribute
		do
			create Result.make (100)
			increase_tabulation
			Result.append (indent_string)
			if line_pragma /= Void then
				Result.append (line_pragma.code)
				Result.append (Line_return)
			end
			if is_frozen then
				Result.append ("frozen ")
			end
			Result.append (eiffel_name)
			Result.append (": ")
			if result_type /= Void then
				Result.append (result_type.eiffel_name)
			else
				Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_return_type, ["Attribute " + name + " (" + eiffel_name + ")"])
				Result.append ("ANY")
			end
			Result.append (Line_return)
			Result.append (comments_code)
			Result.append (indexing_clause)
			decrease_tabulation
			Result.append (Line_return)
		end

end -- class CODE_ATTRIBUTE

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