indexing
	description: "[
		A subscriber for use with subscribing/unsubscribing to AppDomain.ResolveAssembly events,
		called when the existing CLR assembly loading policy fails.
		]"
	author     : "$Author$"
	date       : "$Date$"
	revision   : "$Revision$"

class
	AR_RESOLVE_SUBSCRIBER
	
create
	make
	
feature {NONE} -- Initialization

	make is
			-- Initialize instance.
		do
			create subscriptions.make
		end
		
	
feature -- Access

	subscribed_domains: LIST [APP_DOMAIN] is
			-- List of subscribed domains.
		local
			l_res: ARRAYED_LIST [APP_DOMAIN]
			l_cursor: CURSOR
		do
			create l_res.make (subscriptions.count)
			from
				l_cursor := subscriptions.cursor
				subscriptions.start
			until
				subscriptions.after
			loop
				l_res.extend (subscriptions.item.app_domain)
				subscriptions.forth
			end
			subscriptions.go_to (l_cursor)
		ensure
			result_not_void: Result /= Void
			matched_subscriptions_count: subscriptions.count = Result.count
		end
		
	has_subscription (a_domain: APP_DOMAIN): BOOLEAN is
			-- Does `a_domain' already have a subscription?
		require
			a_domain_not_void: a_domain /= Void
		do
			Result := subscription (a_domain) /= Void
		end
		
	subscription (a_domain: APP_DOMAIN): AR_SUBSCRIPTION is
			-- Retrieve subscription for `a_domain'.
		require
			a_domain_not_void: a_domain /= Void
		local
			l_cursor: CURSOR
		do
			from
				l_cursor := subscriptions.cursor
				subscriptions.start
			until
				subscriptions.after or Result /= Void
			loop
				if subscriptions.item.app_domain = a_domain then
					Result := subscriptions.item
				else
					subscriptions.forth
				end
			end
			subscriptions.go_to (l_cursor)
		end

feature -- Subscribe

	subscribe (a_domain: APP_DOMAIN; a_resolver: AR_RESOLVER) is
			-- Subscribes `a_resolver' to `a_domain's resolver event.
		require
			a_domain_not_void: a_domain /= Void
			not_a_domain_is_unloading: not a_domain.is_finalizing_for_unload
			a_resolver_not_void: a_resolver /= Void
		local
			l_subscription: AR_SUBSCRIPTION
		do
			l_subscription := subscription (a_domain)
			if l_subscription = Void then
				l_subscription := create {AR_SUBSCRIPTION}.make (a_domain, a_resolver)
				subscriptions.extend (l_subscription)
			else
				check
					not_already_subscribed: not l_subscription.assembly_resolvers.has (a_resolver)
				end
				l_subscription.add_resolver (a_resolver)
			end
		end
		
	unsubscribe (a_domain: APP_DOMAIN; a_resolver: AR_RESOLVER) is
			-- Unsubscribes `a_resolver' from `a_domain's resolver event.
		require
			a_domain_not_void: a_domain /= Void
			a_resolver_not_void: a_resolver /= Void
		do
			a_domain.remove_domain_unload (create {EVENT_HANDLER}.make (Current, $unsubscribe_for_unload))
		end
		
feature {NONE} -- Implementation

	unsubscribe_for_unload (a_sender: SYSTEM_OBJECT; a_args: EVENT_ARGS) is
			-- Event handler for APP_DOMAIN.unload event.
		require
			a_sender_not_void: a_sender /= Void
			a_args_not_void: a_args /= Void
		local
			l_domain: APP_DOMAIN
		do
			l_domain ?= a_sender
			check
				invalid_sender: l_domain /= Void	
			end
		end
		
	subscriptions: LINKED_LIST [AR_SUBSCRIPTION]
			-- List of subscriptions.
			
invariant
	subscriptions_not_void: subscriptions /= Void
	
end -- AR_RESOLVE_SUBSCRIBER
