indexing 
	description: "Eiffel representation of a namespace"
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_NAMESPACE

inherit
	CODE_NAMESPACE_INTERFACE

	CODE_SHARED_CLASS_SEPARATOR
		export
			{NONE} all
		undefine
			default_create,
			is_equal
		end

create
	make

feature -- Access

	code: STRING is
			-- | Loop on `types': call `type.code' on each item.
			-- Eiffel code for a namespace
		local
			l_type: CODE_GENERATED_TYPE
		do
			from
				types.start
				create Result.make (8192)
			until
				types.after
			loop
				l_type := types.item
				if l_type /= Void then
					Result.append (l_type.code)
					Result.append (Class_separator)
				end
				types.forth
			end
		end

end -- class CODE_NAMESPACE

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
