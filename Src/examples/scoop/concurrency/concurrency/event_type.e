note
	description: "[
		Notion of event type ; extended to provide SCOOP support
		Original class by Volkan Arslan; SCOOP extensions by Piotr Nienaltowski					
					
		This is a SCOOP-enabled version of EVENT_TYPE. The original class, proposed
		by Arslan et al, provided synchronous event publication and notification of 
		subscribed objects. The new version supports fully asynchronous semantics 
		of both operations; see section 10.2.4 for a detailed discussion and 
		examples.
	]"
	author: "Piotr Nienaltowski"
	date: "$Date$"
	revision: "$Revision$"

class
--	EVENT_TYPE [detachable EVENT_DATA -> separate TUPLE create default_create end] --orignal
	EVENT_TYPE [EVENT_DATA ->  TUPLE create default_create end]

inherit
	LINKED_LIST [detachable separate ROUTINE [ANY, EVENT_DATA]] --orignal
--	LINKED_LIST [detachable separate ROUTINE [ANY, separate EVENT_DATA]]
		redefine
			default_create
		end

	CONCURRENCY
		undefine
			is_equal,
			copy,
			default_create
		end

feature {NONE} -- Initialization

	default_create
			-- <Precursor>
		do
			make
			compare_objects
		end

feature -- Element change

	subscribe (an_action: detachable separate ROUTINE [ANY, EVENT_DATA])
			-- Add an action to subscription list .
		require
			an_action_not_void: an_action /= Void
			an_action_not_yet_subscribed: not has (an_action)
		do
			extend (an_action)
		ensure
			an_action_subscribed: count = old count + 1 and has (an_action)
			index_at_same_position: index = old index
		end

	unsubscribe (an_action: detachable separate ROUTINE [ANY, EVENT_DATA])
			-- Remove an action from subscription list .
		require
			an_action_not_void: an_action /= Void
			an_action_subscribed: has (an_action)
		local
			pos: INTEGER
		do
			pos := index
			start
			search (an_action)
			remove
			go_i_th (pos)
		ensure
			an_action_unsubscribed: count = old count - 1 and not has (an_action)
			index_has_not_moved: index = old index
		end

feature -- Event publication

	publish (arguments: EVENT_DATA)
			-- Notify all actions from subscription list .
		require
			arguments_not_void: arguments /= Void
		do
			if not is_suspended then
				from
					start
				until
					after
				loop
					if attached {separate ROUTINE [ANY, EVENT_DATA]} item as action then
						asynch (agent action.call (arguments))
						-- Full asynchrony; no waiting here
					end
					forth
				end
			end
		end

feature -- Status report

	is_suspended: BOOLEAN
			-- Is publication of all actions suspended? (Default: no.)

feature -- Status change

	suspend_subscription
			-- Ignore actions in subscription list
			-- until restore subscription is called.
		do
			is_suspended := True
		ensure
			subscription_suspended: is_suspended
		end

	restore_subscription
			-- Consider again actions from subscription list
			-- until suspend subscription is called.
		do
			is_suspended := False
		ensure
			subscription_not_suspended: not is_suspended
		end

end
