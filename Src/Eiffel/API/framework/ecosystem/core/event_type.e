indexing
	description: "[
		A notion for a type of event.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

class
	EVENT_TYPE [EVENT_DATA -> TUPLE]

inherit
	SAFE_DISPOSABLE
		redefine
			default_create,
			safe_dispose
		end

feature {NONE} -- Initialization

	default_create is
			-- Default initialization
		do
			subscribers := create_subscribers
			subscribers.set_equality_tester (create {KL_EQUALITY_TESTER [PROCEDURE [ANY, EVENT_DATA]]})
			suicide_actions := create_subscribers
			suicide_actions.set_equality_tester (create {KL_EQUALITY_TESTER [PROCEDURE [ANY, EVENT_DATA]]})
		end

feature {NONE} -- Clean up

	safe_dispose (a_disposing: BOOLEAN) is
			-- Action to be executed just before garbage collection
			-- reclaims an object.
			--
			-- `a_disposing': True if Current is being explictly disposed of, False to indicate finalization.
		do
			if a_disposing then
					-- Remove all subscribers to prevent potential memory leaks.
				subscribers.wipe_out
				subscribers := Void
				suicide_actions.wipe_out
				suicide_actions := Void
			end
		ensure then
			subscribers_emptied: (old subscribers).is_empty
			subscribers_detached: subscribers = Void
			suicide_actions_emptied:  (old suicide_actions).is_empty
			suicide_actions_detached: suicide_actions = Void
		end

feature -- Query

	is_subscribed (a_action: PROCEDURE [ANY, EVENT_DATA]): BOOLEAN
			-- Determines if the event already has a subscription for a specified action
			--
			-- `a_action': An action to check an existing subscription for
			-- `Result': True if the action is already subscribed, False otherwise.
		require
			not_is_zombie: not is_zombie
		do
			Result := subscribers.has (a_action)
		end

feature -- Element change

	subscribe (a_action: PROCEDURE [ANY, EVENT_DATA]) is
			-- Subscribes an action to the event.
			--
			-- `a_action': The action to subscribe.
		require
			not_is_zombie: not is_zombie
			a_action_attached: a_action /= Void
			not_a_action_is_subscribed: not is_subscribed (a_action)
		do
			subscribers.force_last (a_action)
		ensure
			a_action_subscribed:
				is_subscribed (a_action) and then
				subscribers.count = old subscribers.count + 1
			subscribers_cursor_unmoved: subscribers.index = old subscribers.index
		end

	subscribe_for_single_notification (a_action: PROCEDURE [ANY, EVENT_DATA]) is
			-- Subscribes an action to the event for a single publication only.
			--
			-- `a_action': The action to subscribe.
		require
			not_is_zombie: not is_zombie
			a_action_attached: a_action /= Void
			not_a_action_is_subscribed: not is_subscribed (a_action)
		do
			suicide_actions.force_last (a_action)
			subscribe (a_action)
		ensure
			a_action_added_as_suicidal: suicide_actions.has (a_action)
			suicide_actions_cursor_unmoved: suicide_actions.index = old suicide_actions.index
			a_action_subscribed:
				is_subscribed (a_action) and then
				subscribers.count = old subscribers.count + 1
			subscribers_cursor_unmoved: subscribers.index = old subscribers.index
		end

	unsubscribe (a_action: PROCEDURE [ANY, EVENT_DATA]) is
			-- Unsubscribes an action from the event.
			--
			-- `a_action': A previously subscribed action to unsubscribe.
		require
			not_is_zombie: not is_zombie
			a_action_attached: a_action /= Void
			a_action_is_subscribed: is_subscribed (a_action)
		local
			l_subscribers: like subscribers
			i: INTEGER
		do
			l_subscribers := subscribers

			i := l_subscribers.index
			l_subscribers.start
			l_subscribers.search_forth (a_action)
			l_subscribers.remove_at
			if l_subscribers.valid_index (i) then
				l_subscribers.go_i_th (i)
			end
		ensure
			a_action_unsubscribed:
				not is_subscribed (a_action) and then
				subscribers.count = old subscribers.count - 1
			index_at_same_position:
				(old subscribers.after implies subscribers.after) and
				(not old subscribers.after implies subscribers.index = old subscribers.index)
		end

feature -- Publication

	publish (a_args: EVENT_DATA) is
			-- Publish all not suspended actions from the subscription list.
			--
			-- `a_args': Public context arguments to forward to all subscribers
		require
			not_is_zombie: not is_zombie
			a_args_attached: a_args /= Void
		local
			l_actions: like suicide_actions
		do
			if not is_suspended then
					-- We cache the suicide actions because a subscriber may dispose of Current while publishing.
				l_actions := suicide_actions
				subscribers.do_all (agent {PROCEDURE [ANY, EVENT_DATA]}.call (a_args))
				if not l_actions.is_empty then
						-- Remove actions
					l_actions.do_all (agent unsubscribe)
					l_actions.wipe_out
				end
			end
		ensure
			subscribers_index_unmoved: not is_zombie implies (subscribers.index = old subscribers.index)
			suicide_actions_index_unmoved: not is_zombie implies (suicide_actions.index = old suicide_actions.index)
		end

feature {NONE} -- Access

	suspension_count: NATURAL_16
			-- Number of clients requesting event publising be suspsend.
			-- Note: Publication will be suspended as long as a single client request suspension

feature -- Status report

	is_suspended: BOOLEAN
			-- Is the publication of all actions from the subscription list suspended?
			-- (Answer: no by default.)	
		do
			Result := suspension_count > 0
		end

feature -- Status settings

	suspend_subscription is
			-- Ignore the call of all actions from the subscription list,
			-- until feature `restore_subscription' is called.
			--
			-- Note: Suspension is based on a stacked number of calls. 3 calls to `suspend_subscription'
			--       must be match with 3 calls to `restore_subscription' for publication to occur.
		require
			not_is_zombie: not is_zombie
		do
			suspension_count := suspension_count + 1
		ensure
			subscription_suspended: is_suspended
			suspension_count_incremented: suspension_count = old suspension_count + 1
		end

	restore_subscription is
			-- Consider again the call of all actions from the subscription list,
			-- until feature `suspend_subscription' is called.
			--
			-- Note: see `suspend_subscription' for information on stacked suspension.
		require
			not_is_zombie: not is_zombie
			is_suspended: is_suspended
		do
			suspension_count := suspension_count - 1
		ensure
			suspension_count_incremented: suspension_count = old suspension_count - 1
		end

	perform_suspended_action (a_action: PROCEDURE [ANY, TUPLE])
			-- Performs a action whilst suspending subscriptions from recieve a publication
			--
			-- `a_action': Action to call while the event is suspended.
		require
			not_is_zombie: not is_zombie
		do
			suspend_subscription
			a_action.call ([])
			restore_subscription
		ensure
			suspension_count_unchanged: suspension_count = old suspension_count
		rescue
				-- In case call raises and exception, restore the subscription
			restore_subscription
		end

feature {NONE} -- Factory

	create_subscribers: like subscribers
			-- Create a new subscriber list.
			-- Note: Redefine to use an alternative list structure suited to specific needs.
			--
			-- `Result': A list structure used to store subscribers in.
		do
			create {DS_LINKED_LIST [PROCEDURE [ANY, EVENT_DATA]]}Result.make
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Implementation

	frozen subscribers: DS_LIST [PROCEDURE [ANY, EVENT_DATA]]
			-- List of actions currently subscribed to the event

	frozen suicide_actions: DS_LIST [PROCEDURE [ANY, EVENT_DATA]]
			-- List of actions that will be removed after they have been called for the first time

invariant
	subscribers_attached: not is_zombie implies subscribers /= Void
	suicide_actions_attached: suicide_actions /= Void
	subscribers_equality_tester_attached: not is_zombie implies subscribers.equality_tester /= Void
	suicide_actions_tester_attached: not is_zombie implies suicide_actions.equality_tester /= Void
	is_suspended_implies_has_suspensions: is_suspended implies suspension_count > 0
	not_is_suspended_implies_has_no_suspensions: not is_suspended implies suspension_count = 0

;indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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
