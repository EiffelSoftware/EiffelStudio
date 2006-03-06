indexing
	description	: "Expose `load_eiffel_types_from_assembly' required for .NET/consumer bug workaround."

class
	CODE_INTERNAL

inherit
	INTERNAL
		export
			{ANY} load_eiffel_types_from_assembly
		end

feature -- None

end -- CODE_INTERNAL

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
