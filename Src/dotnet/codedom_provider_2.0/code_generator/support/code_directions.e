indexing
	description: "Argument direction support (in, out, inout)"
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_DIRECTIONS

feature -- Access

	in_argument, out_argument, inout_argument: INTEGER is unique
			-- Constants

	direction_from_dom (a_direction: SYSTEM_DLL_FIELD_DIRECTION): INTEGER is
			-- Value corresponding to `a_direction'
		do
			if a_direction = {SYSTEM_DLL_FIELD_DIRECTION}.In then
				Result := in_argument
			elseif a_direction = {SYSTEM_DLL_FIELD_DIRECTION}.Out then
				Result := out_argument
			elseif a_direction = {SYSTEM_DLL_FIELD_DIRECTION}.Ref then
				Result := inout_argument
			else
				check
					should_not_be_here: False
				end
				Result := in_argument
			end
		ensure
			valid_direction: is_valid_direction (Result)
		end

feature -- Status Report

	is_valid_direction (a_direction: INTEGER): BOOLEAN is
			-- Is `a_direction' a valid direction constant?
		do
			Result := a_direction = in_argument or a_direction = out_argument or a_direction = inout_argument
		end

end -- class CODE_DIRECTIONS

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