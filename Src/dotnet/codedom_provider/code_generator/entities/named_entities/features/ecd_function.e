indexing 
	description: "Eiffel function"
	date: "$$"
	revision: "$$"	

class
	ECD_FUNCTION

inherit
	ECD_ROUTINE
		redefine
			make,
			signature
		end

create 
	make

feature {NONE} -- Initialization

	make is
			-- | Call Precursor {ECD_ROUTINE}
			-- Initialize `returned_type'.
		do
			Precursor {ECD_ROUTINE}
			create returned_type.make_empty
		ensure then
			non_void_returned_type: returned_type /= Void
		end

feature -- Access

	returned_type: STRING
			-- return type

	is_array_returned_type: BOOLEAN
			-- Is returned_type a NATIVE_ARRAY?

feature {NONE} -- Implementation

	signature: STRING is
			-- | Result := "`function_name' [(attributes,...)]: `returned_type'"
			-- Routine signature (without `is' keyword)
		local
			l_type_name: STRING
		do
			Result := Precursor {ECD_ROUTINE}
			Result.append (Dictionary.Colon)
			Result.append (Dictionary.Space)
			l_type_name := Resolver.eiffel_type_name (returned_type)
			if is_array_returned_type then
				Result.append ("NATIVE_ARRAY [")
				Result.append (l_type_name)
				Result.append ("]")
			else
				Result.append (l_type_name)
			end
		end
		
feature -- Status Setting
	
	set_returned_type (a_type: like returned_type) is
			-- Set `returned_type' with `a_type'
		require
			non_void_type: a_type /= Void
			positive_type: not a_type.is_empty
		do
			returned_type := a_type
		ensure
			returned_type_set: returned_type = a_type
		end

	set_is_array_returned_type (a_bool: like is_array_returned_type) is
			-- Set `is_array_returned_type' with `a_bool'.
		do
			is_array_returned_type := a_bool
		ensure
			is_array_returned_type_set: is_array_returned_type = a_bool
		end

invariant
	non_void_returned_type: returned_type /= Void

end -- class ECD_FUNCTION

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