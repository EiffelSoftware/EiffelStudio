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
	{if isset="$APP_ROOT"}APPLICATION_LAUNCHER [{$APP_ROOT/}_EXECUTION]{/if}
	{unless isset="$APP_ROOT"}APPLICATION_LAUNCHER [APPLICATION_EXECUTION]{/if}

{literal}create
	make_and_launch

feature {NONE} -- Initialization
{/literal}
	initialize
			-- Initialize current service.
		do
			Precursor
			set_service_option ("port", {$WIZ.standalone_connector.port/})
		end


end
