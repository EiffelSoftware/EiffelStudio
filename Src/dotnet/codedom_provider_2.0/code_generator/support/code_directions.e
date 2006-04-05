indexing
	description: "Argument direction support (in, out, inout)"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end -- class CODE_DIRECTIONS

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