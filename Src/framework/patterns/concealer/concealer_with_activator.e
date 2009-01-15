note
	description: "[
		An implementation of the {CONCEALER_I} pattern interface to provided access to a concealed
		object using an activator function to retrieve the object.

	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class
	CONCEALER_WITH_ACTIVATOR [G -> ANY]

inherit
	CONCEALER_I [G]

create
	make

feature {NONE} -- Initialization

	make (a_activator: !like activator)
			-- Initialize concealer with activator function, use to retrieve a concealed object.
			--
			-- `a_activator': A function used to retrieve a concealed object on first use.
		do
			activator := a_activator
		ensure
			activator_set: activator = a_activator
		end

feature -- Access

	object: ?G
			-- <Precursor>
		local
			l_cache: like internal_object
			l_activator: like activator
		do
			l_cache := internal_object
			if l_cache = Void then
				l_activator := activator
				check l_activator_attached: l_activator /= Void end
				Result := activator.item (Void)
					-- Detach activator as it is no longer required
				activator := Void
				create internal_object.put (Result)
			else
				Result := l_cache.item
			end
		ensure then
			activator_detached: Result /= Void implies activator = Void
		end

feature {NONE} -- Access

	activator: ?FUNCTION [ANY, TUPLE, ?G]
			-- The function use to active an object for the first time
			-- Note: Once the object has been activated the function will not long be available.

feature {NONE} -- Implementation: Internal cache

	internal_object: ?CELL [?like object]
			-- Cached version of `object'.
			-- Note: Do not use directly!

invariant
	activator_attached: internal_object = Void implies activator /= Void
	activator_detached: internal_object /= Void implies activator = Void

note
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
