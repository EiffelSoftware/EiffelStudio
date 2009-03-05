note
	description: "[
		A support class to assisting in multi-threaded synchronized access to resources.
		
		The class can be used in non-multi-threaded systems without incident or any contract violations.
		Depending on the project's multi-threaded settings, different functionality is performed.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MULTI_THREADER

inherit
	BRIDGE [MULTI_THREADER_I]

	MULTI_THREADER_I

feature -- Basic operations

	perform (a_action: PROCEDURE [ANY, TUPLE])
			-- <Precursor>
		do
			bridge.perform (a_action)
		end

	retrieve (a_action: FUNCTION [ANY, TUPLE, detachable ANY]): detachable ANY
			-- <Precursor>
		do
			Result := bridge.retrieve (a_action)
		end

	test (a_action: PREDICATE [ANY, TUPLE]; a_expected: BOOLEAN): BOOLEAN
			-- <Precursor>
		do
			Result := bridge.test (a_action, a_expected)
		end

feature {NONE} -- Factory

	new_bridge: attached MULTI_THREADER_I
			-- <Precursor>
		do
			create {MULTI_THREADER_IMP} Result.make
		end

;note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
