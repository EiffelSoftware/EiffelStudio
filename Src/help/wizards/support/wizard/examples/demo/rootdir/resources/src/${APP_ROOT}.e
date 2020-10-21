note
	description: "[
				application 
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	{if isset="$APP_ROOT"}{$APP_ROOT/}{/if}
	{unless isset="$APP_ROOT"}APPLICATION{/unless}

{if condition="$WIZ.use_arguments ~ $WIZ_YES"}inherit
	ARGUMENTS_32{/if}

{literal}create
	make_and_launch

feature {NONE} -- Initialization
{/literal}
	make_and_launch
			-- Initialize current service.
		do
			print ("Create ...%N")
			print ("Launch ...%N")
			print ("Hello Eiffel Demo World%N")
{if condition="$WIZ.use_arguments ~ $WIZ_YES"}print ("Argument count=" + argument_count.out + "%N"){/if}
			print ("Finished ...%N")
		end

end
