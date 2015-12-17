note
	description: "[
		Multi-threaded implementation of {MULTI_THREADER_I}, using a mutex to synchorize access to
		resources of an object.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MULTI_THREADER_IMP

inherit
	MULTI_THREADER_I

create
	make

feature {NONE} -- Initialization

	make
			-- Initializes the multi-threader
		do
			create mutex.make
		end

feature {NONE} -- Access

	mutex: MUTEX
			-- A multi-thread access mutex.

feature {NONE} -- Basic operations

	perform (a_action: PROCEDURE)
			-- <Precursor>
		local
			l_locked: BOOLEAN
		do
			l_locked := True
			mutex.lock
			a_action.call (Void)
			l_locked := False
			mutex.unlock
		rescue
			if l_locked then
				check is_thread_capable: {PLATFORM}.is_thread_capable end
				l_locked := False
				mutex.unlock
			end
		end

	retrieve (a_action: FUNCTION [detachable ANY]): detachable ANY
			-- <Precursor>
		local
			l_locked: BOOLEAN
		do
			l_locked := True
			mutex.lock
			Result := a_action.item (Void)
			l_locked := False
			mutex.unlock
		rescue
			if l_locked then
				check is_thread_capable: {PLATFORM}.is_thread_capable end
				l_locked := False
				mutex.unlock
			end
		end

	test (a_action: PREDICATE; a_expected: BOOLEAN): BOOLEAN
			-- <Precursor>
		local
			l_locked: BOOLEAN
		do
			l_locked := True
			mutex.lock
			Result := (a_action.item (Void) = a_expected)
			l_locked := False
			mutex.unlock
		rescue
			if l_locked then
				check is_thread_capable: {PLATFORM}.is_thread_capable end
				l_locked := False
				mutex.unlock
			end
		end

invariant
	mutex_attached: mutex /= Void
	mutex_is_set: mutex.is_set

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
