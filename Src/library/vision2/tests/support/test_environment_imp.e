note
	description: "Summary description for {TEST_ENVIRONEMENT_IMP}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_ENVIRONMENT_IMP

inherit
	EV_ENVIRONMENT_IMP
		redefine
			application_i
		end

create
	make

feature -- Access

	application_i: EV_APPLICATION_I
			-- Single application implementation object for system.
		local
			l_result: detachable EV_APPLICATION_I
		do
			l_result := application_cell.item
			if not attached l_result then
				application_cell.put (create {TEST_APPLICATION_IMP}.make)
				l_result := application_cell.item
			end
			check l_result /= Void end
			Result := l_result
		end

feature {TEST_APPLICATION} -- Access

	set_application_i (an_application_i: EV_APPLICATION_I)
			-- Specify `an_application_i' as the single application object for the
			-- system. Must be calles from TEST_APPLICATION when a new application object is created.
		require
			not_destroyed: not is_destroyed
		do
			application_cell.replace (an_application_i)
		ensure
			application_assigned: application_i = an_application_i
		end

end
