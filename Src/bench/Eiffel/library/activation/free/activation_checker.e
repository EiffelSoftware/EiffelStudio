indexing
	description:	"[
						Check whether product is correctly activated,
						always true for free version.
					]"
	revision:	"$$"
	date:		"$$"

class
	ACTIVATION_CHECKER
	
feature -- Basic Operations

	check_activation is
			-- Free version, can always run.
		do
			can_run := True
		end

	can_run: BOOLEAN
			-- Can product be run?

end -- class ACTIVATION_CHECKER