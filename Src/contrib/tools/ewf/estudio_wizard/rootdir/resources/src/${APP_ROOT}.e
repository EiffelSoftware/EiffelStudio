note
	description: "[
				application service
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	{if isset="$APP_ROOT"}{$APP_ROOT/}{/if}
	{unless isset="$APP_ROOT"}APPLICATION{/unless}

inherit
	WSF_LAUNCHABLE_SERVICE
		redefine
			initialize
		end
{if condition="$WIZ.routers.use_router ~ $WIZ_YES"}
	WSF_ROUTED_SERVICE{/if}

	APPLICATION_LAUNCHER

{literal}create
	make_and_launch

feature {NONE} -- Initialization
{/literal}
	initialize
			-- Initialize current service.
		do
			Precursor
			set_service_option ("port", {$WIZ.standalone_connector.port/})
{unless condition="$WIZ.routers.use_router ~ $WIZ_YES"}
		end

feature -- Execution

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
		do
		end{/unless}
{if condition="$WIZ.routers.use_router ~ $WIZ_YES"}{literal}
			initialize_router
		end

	setup_router
			-- Setup `router'
		local
			fhdl: WSF_FILE_SYSTEM_HANDLER
		do
			router.handle_with_request_methods ("/doc", create {WSF_ROUTER_SELF_DOCUMENTATION_HANDLER}.make (router), router.methods_GET)
			create fhdl.make_hidden ("www")
			fhdl.set_directory_index (<<"index.html">>)
			router.handle_with_request_methods ("", fhdl, router.methods_GET)
		end{/literal}{/if}

end
