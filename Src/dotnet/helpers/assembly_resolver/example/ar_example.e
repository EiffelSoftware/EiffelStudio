indexing
	description: "[
		Example usage for default assembly resolver, making use of tracing
		provided by resolver.
		]"
	author     : "$Author$"
	date       : "$Date$"
	revision   : "$Revision$"
	
class
	AR_EXAMPLE

inherit
	AR_SHARED_SUBSCRIBER
		export
			{NONE} all
		end
		
	SYSTEM_DLL_TRACE_LISTENER
		rename
			make as make_listener
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Entry point.
		local
			l_resolver: AR_RESOLVER
			l_assembly: ASSEMBLY
			i: INTEGER
		do
				-- Add trace listener to display what resolver is looking for.
			make_from_name ("TestListener")
			i := feature {SYSTEM_DLL_TRACE}.listeners.add (Current)
			
				-- Create a resolver
			create l_resolver.make_with_name ("Test Resolver")
			
				-- Subscribe `l_resolver' to current app domain
			resolve_subscriber.subscribe (feature {APP_DOMAIN}.current_domain, l_resolver)
			
				-- Attempt to resolve a reference
			l_assembly := feature {ASSEMBLY}.load ("TestAssembly, Version=1.0.0.0, Culture=neutral, PublickKeyToken=null")
			
				-- Optionally unsubscribe.
				-- Unsubscribing in handled automatically when subscribed app domain unloads
			resolve_subscriber.unsubscribe (feature {APP_DOMAIN}.current_domain, l_resolver)
			
				-- Exit
			print ("%N%NPress Enter to Exit")
			io.read_line
		end

feature {SYSTEM_DLL_TRACE_LISTENER} -- {SYSTEM_DLL_TRACE_LISTENER} Trace Output

	write (message: SYSTEM_STRING) is
			-- Write `message'
		do
			feature {SYSTEM_CONSOLE}.write (message)
		end
		
	write_line (message: SYSTEM_STRING) is
			-- Write `message'
		do
			feature {SYSTEM_CONSOLE}.write_line (message)
		end

end -- class AR_EXAMPLE
