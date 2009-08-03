note
	description: "Summary description for {TEST_VISION2}."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TEST_VISION2

inherit
	EQA_TEST_SET
		redefine
			on_prepare
		end


feature -- Access

	app: EV_APPLICATION

	on_prepare
		do
			precursor {EQA_TEST_SET}
			create app
		end

end
