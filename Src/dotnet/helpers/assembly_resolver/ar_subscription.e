indexing
	description: "[
		An assembly resolver subscription item.
		]"
	author     : "$Author$"
	date       : "$Date$"
	revision   : "$Revision$"

class
	AR_SUBSCRIPTION
	
create
	make
	
feature {NONE} -- Initialization

	make (a_domain: like app_domain; a_resolver: AR_RESOLVER) is
			-- Initialize subscription for `app_domain' by subscribing `a_resolver'
			-- to its resolver event
		require
			a_domain_not_void: a_domain /= VOid
			a_domain_not_unloading: not a_domain.is_finalizing_for_unload
			a_resolver_not_void: a_resolver /= Void
		do
			create internal_assembly_resolvers.make (1)
			app_domain := a_domain
			add_resolver (a_resolver)
		ensure
			add_domain_set: app_domain = a_domain
			assembly_resolvers_has_a_resolver: assembly_resolvers.has (a_resolver)
		end
	
feature -- Access

	app_domain: APP_DOMAIN
			-- App Domain `assembly_resolver' is subscribed to
			
	assembly_resolvers: LIST [AR_RESOLVER] is
			-- List of resolvers `app_domain' has subscribed to it
		do
			Result := internal_assembly_resolvers
		ensure
			result_not_void: Result /= Void
			not_result_is_empty: not Result.is_empty
		end
		
feature -- Extentions

	add_resolver (a_resolver: AR_RESOLVER) is
			-- Add `a_resolver' to list of `assembly_resolvers'
		require
			a_resolver_not_void: a_resolver /= Void
			app_domain_not_void: app_domain /= Void
			not_app_domain_is_unloading: not app_domain.is_finalizing_for_unload
		do
			app_domain.add_assembly_resolve (a_resolver.resolve_event_handler)
			internal_assembly_resolvers.extend (a_resolver)
		ensure
			a_resolver_added: assembly_resolvers.has (a_resolver)
		end
		
feature -- Removal

	remove_resolver (a_resolver: AR_RESOLVER) is
			-- Removes `a_resolver' from list of `assembly_resolvers'
		require
			a_resolver_not_void: a_resolver /= Void
			app_domain_not_void: app_domain /= Void
			not_assembly_resolvers_is_empty: not assembly_resolvers.is_empty
		do
			app_domain.remove_assembly_resolve (a_resolver.resolve_event_handler)
			internal_assembly_resolvers.extend (a_resolver)
		ensure
			a_resolver_removed: not assembly_resolvers.has (a_resolver)
		end
		
feature {NONE} -- Implementation

	internal_assembly_resolvers: ARRAYED_LIST [AR_RESOLVER]
			-- Internal list of assembly resolvers subscribed to `app_domain'

invariant
	add_domain_not_void: app_domain /= Void
	internal_assembly_resolvers_not_void: internal_assembly_resolvers /= Void
	not_internal_assembly_resolvers_is_empty: not internal_assembly_resolvers.is_empty

end -- class AR_SUBSCRIPTION
