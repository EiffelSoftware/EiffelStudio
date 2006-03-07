indexing 
	description: "Evaluate and replace environment variables in strings"
	date: "$$"
	revision: "$$"

class
	CODE_ENV_INTERP

inherit
	ENV_INTERP
		redefine
			variable_value
		end

	CODE_DOM_PATH
		export
			{NONE} all
		end

feature {NONE} -- Implementation

	variable_value (a_name: STRING): STRING is
			-- Value of variable `a_name'
		do
			if a_name.as_lower.is_equal ("ise_codedom") then
				Result := Codedom_installation_path
			else
				Result := Precursor {ENV_INTERP} (a_name)
			end
		end

end -- class CODE_ENV_INTERP

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