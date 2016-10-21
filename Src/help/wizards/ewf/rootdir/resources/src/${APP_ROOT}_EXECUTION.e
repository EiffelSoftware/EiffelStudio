note
	description: "[
				application execution
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	{if isset="$APP_ROOT"}{$APP_ROOT/}_EXECUTION{/if}
	{unless isset="$APP_ROOT"}APPLICATION_EXECUTION{/unless}

inherit
{unless condition="$WIZ.routers.use_router ~ $WIZ_YES"}
  {unless condition="$WIZ.filters.use_filter ~ $WIZ_YES"}
	WSF_EXECUTION{/unless}
  {if condition="$WIZ.filters.use_filter ~ $WIZ_YES"}
	WSF_FILTERED_EXECUTION{/if}
{/unless}
{if condition="$WIZ.routers.use_router ~ $WIZ_YES"}
  {unless condition="$WIZ.filters.use_filter ~ $WIZ_YES"}
	WSF_ROUTED_EXECUTION{/unless}
  {if condition="$WIZ.filters.use_filter ~ $WIZ_YES"}
	WSF_FILTERED_ROUTED_EXECUTION{/if}
{/if}

{literal}create
	make

feature {NONE} -- Initialization
{/literal}
{unless condition="$WIZ.routers.use_router ~ $WIZ_YES"}{literal}
feature -- Execution

	execute
			-- Use `request' to get data for the incoming http request
			-- and `response' to send response back to the client
		local
			mesg: WSF_PAGE_RESPONSE
		do
				--| As example, you can use {WSF_PAGE_RESPONSE}
				--| To send back easily a simple plaintext message.
			create mesg.make_with_body ("Hello Eiffel Web")
			response.send (mesg)
		end
{/literal}{/unless}
{if condition="$WIZ.filters.use_filter ~ $WIZ_YES"}{literal}
feature -- Filter

	create_filter
			-- Create `filter'
		do
				--| Example using Maintenance filter.
			create {WSF_MAINTENANCE_FILTER} filter
		end

	setup_filter
			-- Setup `filter'
		local
			f: like filter
		do
			create {WSF_CORS_FILTER} f
			f.set_next (create {WSF_LOGGING_FILTER})

				--| Chain more filters like {WSF_CUSTOM_HEADER_FILTER}, ...
				--| and your owns filters.

			filter.append (f)
		end
{/literal}{/if}
{if condition="$WIZ.routers.use_router ~ $WIZ_YES"}{literal}
feature -- Router

	setup_router
			-- Setup `router'
		local
			fhdl: WSF_FILE_SYSTEM_HANDLER
		do
				--| As example:
				--|   /doc is dispatched to self documentated page
				--|   /* are dispatched to serve files/directories contained in "www" directory

				--| Self documentation
			router.handle ("/doc", create {WSF_ROUTER_SELF_DOCUMENTATION_HANDLER}.make (router), router.methods_GET)

				--| Files publisher
			create fhdl.make_hidden ("www")
			fhdl.set_directory_index (<<"index.html">>)
			router.handle ("", fhdl, router.methods_GET)
		end{/literal}{/if}

end
