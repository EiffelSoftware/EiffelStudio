deferred class TEST_SETUP

inherit
	$THREAD

feature {NONE} -- Status

	has_assertions: BOOLEAN is $HAS_ASSERTIONS
			-- Does system support assertions?

end
