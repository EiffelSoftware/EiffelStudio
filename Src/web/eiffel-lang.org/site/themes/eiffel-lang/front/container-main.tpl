						<h1>
							<span class="tooltip-label" data-tooltip="A tooltip!"><a href="{$site_url/}/launch_codeboard">Play with Eiffel</span>
                		</h1>
						<!--<div>
			  				<img src="/theme/images/eiffel_source.png">
						</div> -->
						<pre class="prettyprint lang-eiffel">
note
	description : "hello_world application root class"
	date        : "$Date$"
	revision    : "$Revision$"

class
	HELLO_WORLD
inherit
	ARGUMENTS
create
	make
feature {NONE} -- Initialization

	make
			-- Run application.
		do
			--| Add your code here
			print ("Hello Eiffel World!%N")
		end
end
	</pre>

