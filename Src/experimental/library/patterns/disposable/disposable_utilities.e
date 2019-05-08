note
	description: "[
		Operations for use with {DISPOSABLE_I} and {DISPOSABLE} objects.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

frozen class
	DISPOSABLE_UTILITIES

feature -- Basic operations

	dispose (a_object: ANY)
			-- Disposes of an object, if it implemented {DISPOSABLE_I} or {DISPOSABLE}.
			--
			-- `a_object': An object to dispose of.
		require
			a_object_attached: a_object /= Void
		do
			if attached {DISPOSABLE_I} a_object as l_disposable_safe then
				l_disposable_safe.dispose
			elseif attached {DISPOSABLE} a_object as l_disposable then
				l_disposable.dispose
			end
		end

	perform (a_object: ANY; a_action: PROCEDURE)
			-- Performs an action on with a supplied object and then cleans up the supplied object.
			-- Note: In the interest of safety `a_object' should not be held on to by any other object
			--       because it will be disposed of.
		require
			a_object_attached: a_object /= Void
			a_action_attached: a_action /= Void
		local
			l_disposed: BOOLEAN
		do
			a_action.call (Void)
			l_disposed := True
			dispose (a_object)
		rescue
			if not l_disposed then
				dispose (a_object)
			end
		end

;note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
