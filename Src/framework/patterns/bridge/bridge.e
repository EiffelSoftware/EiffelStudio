note
	description: "[
		Rudimentary implementation of a bridge pattern.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	BRIDGE [G -> ANY]

feature {NONE} -- Access

	frozen bridge: !G
			-- Bridge implementation.
		require
			is_interface_usable: {l_usable: USABLE_I} Current implies l_usable.is_interface_usable
		local
			l_result: like internal_bridge
		do
			l_result := internal_bridge
			if l_result = Void then
				Result := new_bridge
				internal_bridge := Result
			else
				Result := l_result
			end
		ensure
			result_consistent: Result = bridge
		end

feature {NONE} -- Factory

	new_bridge: !G
			-- Creates a new implementation instance.
		require
			is_interface_usable: {l_usable: USABLE_I} Current implies l_usable.is_interface_usable
			internal_bridge_detached: internal_bridge = Void
		deferred
		end

feature {NONE} -- Implementation: Internal cache

	frozen internal_bridge: ?like bridge
			-- Cached version of `bridge'
			-- Note: Do not use directly!

;note
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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

end
