note
	description: "[
		Pattern interface for automating disposal of ancillary {DISPOSABLE}/{DISPOSABLE_I} objects.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	DISPOSABLE_AUTOMATION_I

inherit
	USABLE_I

feature -- Status report

	is_notified_on_disposing (a_action: PROCEDURE [ANY, TUPLE]): BOOLEAN
			-- Determines is an action is already recieving notification when disposing is taking place.
			--
			-- `a_action': The action to determine a notification status for.
			-- `Result'  : True if the action is already receiving a notification; False otherwise.
		require
			a_action_attached: a_action /= Void
		deferred
		end

	is_notified_on_disposed (a_action: PROCEDURE [ANY, TUPLE]): BOOLEAN
			-- Determines is an action is already recieving notification when a dispose has taken place.
			--
			-- `a_action': The action to determine a notification status for.
			-- `Result'  : True if the action is already receiving a notification; False otherwise.
		require
			a_action_attached: a_action /= Void
		deferred
		end

feature -- Notification

	notify_on_disposing (a_action: PROCEDURE [ANY, TUPLE])
			--
		require
			is_interface_usable: is_interface_usable
			a_action_attached: a_action /= Void
			not_is_notified_on_disposing: not is_notified_on_disposing (a_action)
		deferred
		ensure
			is_notified_on_disposing: is_notified_on_disposing (a_action)
		end

	ignore_on_disposing (a_action: PROCEDURE [ANY, TUPLE])
			--
		require
			is_interface_usable: is_interface_usable
			a_action_attached: a_action /= Void
			is_notified_on_disposing: is_notified_on_disposing (a_action)

		deferred
		ensure
			not_is_notified_on_disposing: not is_notified_on_disposing (a_action)
		end

	notify_on_disposed (a_action: PROCEDURE [ANY, TUPLE])
			--
		require
			is_interface_usable: is_interface_usable
			a_action_attached: a_action /= Void
			not_is_notified_on_disposed: not is_notified_on_disposed (a_action)
		deferred
		ensure
			is_notified_on_disposed: is_notified_on_disposed (a_action)
		end

	ignore_on_disposed (a_action: PROCEDURE [ANY, TUPLE])
			--
		require
			is_interface_usable: is_interface_usable
			a_action_attached: a_action /= Void
			is_notified_on_disposed: is_notified_on_disposed (a_action)
		deferred
		ensure
			not_is_notified_on_disposed: not is_notified_on_disposed (a_action)
		end

feature -- Basic operation

	auto_dispose (a_object: ANY)
			-- Automatically disposes of an object when Current is disposed of.
			--
			-- `a_object': Object to dispose of when Current is disposed.
		require
			is_interface_usable: is_interface_usable
			a_object_attached: a_object /= Void
		deferred
		end

	delayed_auto_dispose (a_action: FUNCTION [ANY, TUPLE, ANY])
			-- Automatically disposes of an object when Current is disposed of.
			-- Note: DO NOT create any objects in the performed action, this may be called
			--       during a real GC dispose.
			--
			-- `a_action': The action to retrieve a object for when Current is disposed.
			--             Warning: The action should not create any objects for Current
		require
			is_interface_usable: is_interface_usable
			a_action_attached: a_action /= Void
		deferred
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
