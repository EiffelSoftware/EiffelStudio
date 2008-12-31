note
	description: "Mutex base lock to prevent mutlitple processes from concurrent access to IO sensitive functions."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

frozen class
	CACHE_MUTEX_GUARD

inherit
	SYSTEM_OBJECT

	CACHE_SETTINGS
		export
			{NONE} all
		end

	DISPOSABLE

create
	default_create

feature -- Basic Operation

	lock
			-- lock cache
		do
			internal_count.set_item (count + 1)
			if count = 1 then
					-- first lock
				perform_locking
			end
		ensure
			count_incremented: count = old count + 1
			is_locked: is_locked
		end

	unlock
			-- lock cache
		require
			count_positive: count > 0
			is_locked: is_locked
		do
			internal_count.set_item (count - 1)
			if count = 0 then
				perform_unlocking
			end
		ensure
			count_decremented: count = old count - 1
		end

feature -- Access

	count: INTEGER
			-- number of locks
		do
			Result := internal_count.item
		ensure
			count_positive: count >= 0
		end

	is_locked: BOOLEAN
			-- is cache locked?
		do
			Result := count > 0
		end

	notifier: NOTIFIER
			-- Notifier used to inform user of locks

feature -- Element change

	set_notifier (a_notifier: like notifier)
			-- Set `notifier' to `a_notifier'.
		do
			notifier := a_notifier
		ensure
			notifier_set: notifier = a_notifier
		end

feature -- DISPOSABLE

	dispose
			-- clean up
		do
			check
				not_is_locked: not is_locked
				zero_count: count = 0
			end
		end

feature {NONE} -- Implementation

	perform_locking
			-- performs locking
		local
			l_wait: BOOLEAN
			l_notifier: like notifier
		do
			l_notifier := notifier
			if l_notifier /= Void then
				l_notifier.notify_info ("The assembly cache is currently locked by another consumer%N%NWaiting for access...")
			end
			l_wait := guard.wait_one
			if l_notifier /= Void then
				l_notifier.restore_last_notification
			end
		ensure
			is_locked: is_locked
		end

	perform_unlocking
			-- performs locking
		do
			guard.release_mutex
		ensure
			not_locked: not is_locked
		end

	guard: SYSTEM_MUTEX
			-- guard implementation
		once
			create Result.make (False, "Global\" + create {STRING}.make_from_cil (cache_lock_id))
			setup_mutex (Result)
		ensure
			result_not_void: Result /= Void
		end

	internal_count: INTEGER_REF
			-- internal count
		once
			create Result
		end

	setup_mutex (a_mutex: SYSTEM_MUTEX)
			-- Setup `a_mutex' to be shared among various users of a machine.
		require
			a_mutex_not_void: a_mutex /= Void
		local
			retried: BOOLEAN
			l_security: MUTEX_SECURITY
			l_rule: MUTEX_ACCESS_RULE
			l_account: NT_ACCOUNT
			l_identity: IDENTITY_REFERENCE
		do
			if not retried then
				create l_account.make ("Everyone")
				if l_account.is_valid_target_type ({SECURITY_IDENTIFIER}) then
						-- In theory the following code should always succeed since we check for its validity
						-- just before, but on a swedish version of Windows it simply crashes with a
						-- IdentityNotMappedException exception. This is why we have the rescue clause.
						-- If it fails it simply keeps the default access control.
					l_identity := l_account.translate ({SECURITY_IDENTIFIER})
					l_security := a_mutex.get_access_control
					create l_rule.make (l_identity, {MUTEX_RIGHTS}.Full_control, {ACCESS_CONTROL_TYPE}.Allow)
					l_security.add_access_rule (l_rule)
					a_mutex.set_access_control (l_security)
				end
			end
		rescue
			retried := True
			retry
		end

note
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


end -- class CACHE_MUTEX_GUARD
