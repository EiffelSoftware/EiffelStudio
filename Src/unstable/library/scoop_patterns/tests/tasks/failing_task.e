note
	description: "Summary description for {FAILING_TASK}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FAILING_TASK

inherit
	CP_DEFAULT_TASK

create
	default_create, make_from_separate

feature {CP_DYNAMIC_TYPE_IMPORTER} -- Initialization

	make_from_separate (other: separate like Current)
			-- <Precursor>
		do
			promise := other.promise
		end

feature

	run
			-- <Precursor>
		local
			l_exception: DEVELOPER_EXCEPTION
		do
			create l_exception
			l_exception.set_description ("failing_task_test")
			l_exception.raise
		end

end
