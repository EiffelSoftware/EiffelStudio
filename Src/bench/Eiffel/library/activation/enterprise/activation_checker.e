indexing
	description:	"[
						Check whether product is correctly activated,
						decrement remaining executions counter otherwise.
						When counter reaches 0, product must be activated.
					]"
	revision:	"$$"
	date:		"$$"

class
	ACTIVATION_CHECKER
	
inherit
	EV_APPLICATION

	PRODUCT_INFO
		rename
			Name as Product_name,
			Version as Product_version
		export
			{NONE} all
		undefine
			default_create,
			copy
		end

feature -- Basic Operations

	check_activation is
			-- Check whether product can be started.
			-- Decrement remaining execution count
			-- if not activated.
			-- Set `can_run' to `True' if product can
			-- be started, `False' otherwise.
		local
			engine: KG_ENGINE
			validator_window: ACTIVATION_KEY_VALIDATOR_WINDOW
		do
			can_run := False
			create engine.make (Product_name, Product_version)
			if engine.is_initialized then
				can_run := engine.is_activated
				if not can_run then
					create validator_window.make (agent set_can_run (True))
					validator_window.show
					launch
				end
			end
		end

	can_run: BOOLEAN
			-- Can product be run?

feature {NONE} -- Implementation

	set_can_run (l_can_run: BOOLEAN) is
			-- Set `can_run' with `l_can_run'.
		do
			can_run := l_can_run
		ensure
			can_run_set: can_run = l_can_run
		end

end -- class ACTIVATION_CHECKER