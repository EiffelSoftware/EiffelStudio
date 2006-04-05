indexing
	description: "[
		Example usage for default assembly resolver, making use of tracing
		provided by resolver.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

indexing
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


end -- class AR_EXAMPLE
