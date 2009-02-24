note
	description: "[
		Represents a notion of an event, supplying means to subscribe and unsubscribe to the event.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

frozen class
	EVENT_TYPE [EVENT_DATA -> TUPLE]

inherit
	EVENT_TYPE_I [EVENT_DATA]
		redefine
			default_create
		end

	EVENT_TYPE_PUBLISHER_I [EVENT_DATA]
		redefine
			default_create
		end

	DISPOSABLE_SAFE
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create
			-- Default initialization
		do
			create subscribers.make (0)
			subscribers.set_equality_tester (create {KL_EQUALITY_TESTER [detachable PROCEDURE [ANY, EVENT_DATA]]})
			create suicide_actions.make (0)
			suicide_actions.set_equality_tester (create {KL_EQUALITY_TESTER [detachable PROCEDURE [ANY, EVENT_DATA]]})
		end

feature {NONE} -- Clean up

	safe_dispose (a_explicit: BOOLEAN)
			-- <Precursor>
		do
			if a_explicit then
					-- Remove all subscribers to prevent potential memory leaks.
				subscribers.wipe_out
				suicide_actions.wipe_out
			end
		ensure then
			subscribers_is_empty: a_explicit implies subscribers.is_empty
			suicide_actions_is_empty: a_explicit implies suicide_actions.is_empty
		end

feature {NONE} -- Access

	frozen subscribers: !DS_HASH_SET [detachable PROCEDURE [ANY, EVENT_DATA]]
			-- List of actions currently subscribed to the event.

	frozen suicide_actions: !DS_HASH_SET [detachable PROCEDURE [ANY, EVENT_DATA]]
			-- List of actions that will be removed after they have been called for the first time.
			--|This list is a subset of `subscribers'

	suspension_count: NATURAL_16
			-- Number of clients requesting event publising be suspsend.
			-- Note: Publication will be suspended as long as a single client request suspension.

feature -- Status report

	is_subscribed (a_action: !PROCEDURE [ANY, EVENT_DATA]): BOOLEAN
			-- <Precursor>
		do
			Result := subscribers.has (a_action)
		end

	is_suspended: BOOLEAN
			-- <Precursor>
		do
			Result := suspension_count > 0
		end

	is_publishing: BOOLEAN
			-- Is a publication currently being run?

feature -- Status settings

	suspend_subscriptions
			-- <Precursor>
		do
			suspension_count := suspension_count + 1
		ensure then
			suspension_incremented: suspension_count = old suspension_count + 1
		end

	restore_subscriptions
			-- <Precursor>
		do
			suspension_count := suspension_count - 1
		ensure then
			suspension_incremented: suspension_count = old suspension_count - 1
		end

feature -- Subscription

	subscribe (a_action: !PROCEDURE [ANY, EVENT_DATA])
			-- <Precursor>
		do
			subscribers.force_last (a_action)
		ensure then
			subscribers_incremented: subscribers.count = old subscribers.count + 1
		end

	subscribe_for_single_notification (a_action: !PROCEDURE [ANY, EVENT_DATA])
			-- <Precursor>
		do
			suicide_actions.force_last (a_action)
			subscribe (a_action)
		ensure then
			a_action_added_as_single: suicide_actions.has (a_action)
			subscribers_incremented: subscribers.count = old subscribers.count + 1
			suicide_actions_incremented: suicide_actions.count = old suicide_actions.count + 1
		end

	unsubscribe (a_action: !PROCEDURE [ANY, EVENT_DATA])
			-- <Precursor>
		local
			l_actions: like suicide_actions
		do
				-- Remove subscriber
			subscribers.remove (a_action)

				-- Attempt to remove any single subscribers
			l_actions := suicide_actions
			if l_actions.has (a_action) then
				l_actions.remove (a_action)
			end
		ensure then
			subscribers_decremented:
				subscribers.count = old subscribers.count - 1
			suicide_actions_decremented:
				old suicide_actions.has (a_action) implies
				suicide_actions.count = old suicide_actions.count - 1
		end

feature -- Publication

	publish (a_args: detachable EVENT_DATA)
			-- <Precursor>
		do
			publish_internal (a_args, Void)
		end

	publish_if (a_args: detachable EVENT_DATA; a_predicate: !PREDICATE [ANY, EVENT_DATA])
			-- <Precursor>
		do
			publish_internal (a_args, a_predicate)
		end

feature {NONE} -- Publication

	publish_internal (a_args: detachable EVENT_DATA; a_predicate: detachable PREDICATE [ANY, EVENT_DATA])
			-- Publishes the event, if the subscriptions have not been suspended.
			--
			-- `a_args': Public context arguments to forward to all subscribers.
			-- `a_predicate': The predicate to use to determine if a subscriber should recieve a published event.
		require
			is_interface_usable: is_interface_usable
			not_is_publishing: not is_publishing
		local
			l_actions: like suicide_actions
			l_action: detachable PROCEDURE [ANY, EVENT_DATA]
			l_subscribers: like subscribers
			l_suspended: BOOLEAN
		do
			if not is_suspended then
					-- We cache the suicide actions because a subscriber may dispose of Current while publishing.
				suspend_subscriptions
				l_suspended := True
				is_publishing := True
				l_subscribers := subscribers
				if not l_subscribers.is_empty then
						-- A twin of the suicide actions is performed to prevent issues related to extension during
						-- publication. The issue could cause newly subscribed suicide actions to be removed even
						-- though they have not been called.
					l_subscribers := l_subscribers.twin

					if a_predicate = Void then
						from l_subscribers.start until l_subscribers.after loop
							l_action := l_subscribers.item_for_iteration
							if attached l_action then
								l_action.call (a_args)
							end
							l_subscribers.forth
						end
					else
						from l_subscribers.start until l_subscribers.after loop
							if a_predicate = Void or else a_predicate.item (a_args) then
								l_action := l_subscribers.item_for_iteration
								if attached l_action then
									l_action.call (a_args)
								end
							end
							l_subscribers.forth
						end
					end

						-- Unsubscribe those marked as a suicide action.
					l_actions := suicide_actions
					if not l_actions.is_empty then
							-- A twin of the suicide actions is performed to prevent issues related to extension during
							-- publication. The issue could cause newly subscribed suicide actions to be removed even
							-- though they have not been called.
						l_actions := suicide_actions.twin

						from l_actions.start until l_actions.after loop
							l_action := l_actions.item_for_iteration
							if attached l_action then
								check is_subscribed: is_subscribed (l_action) end
								unsubscribe (l_action)
							end
							l_actions.forth
						end
					end
				end

				is_publishing := False
				l_suspended := False
				restore_subscriptions
			end
		ensure
			is_publishing_unchanged: is_publishing = old is_publishing
		rescue
			is_publishing := False
			if l_suspended then
				restore_subscriptions
			end
		end

invariant
	subscribers_contains_attached_items: not subscribers.has (Void)
	suicide_actions_contains_attached_items: not suicide_actions.has (Void)
	subscribers_contains_suicide_actions: suicide_actions.is_subset (subscribers)
	is_suspended_implies_has_suspensions: is_suspended implies suspension_count > 0
	not_is_suspended_implies_has_no_suspensions: not is_suspended implies suspension_count = 0

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
