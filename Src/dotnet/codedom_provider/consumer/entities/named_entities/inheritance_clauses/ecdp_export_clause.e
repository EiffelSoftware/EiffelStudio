indexing 
	description: "Eiffel export inheritance clause"
	date: "$$"
	revision: "$$"	
	
class
	ECDP_EXPORT_CLAUSE

inherit
	ECDP_INHERITANCE_CLAUSE
		redefine
			ready
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- | Call `Precursor {ECDP_INHERITANCE_CLAUSE}.

			-- Initialize `exports'.	
		do
			default_create
			create exports.make
		ensure then
			non_void_exports: exports /= Void
		end
		
feature -- Access

	exports: LINKED_LIST [ECDP_TYPE]
			-- List of types feature is exported to

	code: STRING is
			-- Eiffel code of export clause
		do
			create Result.make (160)
			Result := dictionary.Opening_brace_bracket
			from
				exports.start
				if not exports.after then
					Result.append (exports.item.name.as_upper)
					exports.forth
				end
			until
				exports.after
			loop
				Result.append (dictionary.Comma)
				Result.append (dictionary.Space)
				Result.append (exports.item.name.as_upper)
				exports.forth
			end
			Result.append (dictionary.Closing_brace_bracket)
			Result.append (dictionary.Space)

			Result.append (name)
		end

feature -- Status Report

	ready: BOOLEAN is
			-- Is export clause ready to be generated?
		do
			Result := Precursor {ECDP_INHERITANCE_CLAUSE} and exports /= Void
		end

feature -- Status Setting

	set_exports (a_list: like exports) is
			-- Set `exports' with `a_list'.
		require
			non_void_list: a_list /= Void
		do
			exports := a_list
		ensure
			exports_set: exports = a_list
		end
		
invariant
	non_void_exports: exports /= Void
	
end -- class ECDP_EXPORT_CLAUSE

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