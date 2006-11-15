indexing
	description: "Implementation of PROCESS_INFO"
	date: "$Date$"
	revision: "$Revision$"

class
	PROCESS_INFO_IMP

inherit
	PROCESS_INFO

feature -- Access

	process_id: INTEGER is
			-- Process ID of current process
		local
			l_prc: SYSTEM_DLL_PROCESS
		do
			create l_prc.make
			l_prc := l_prc.get_current_process
			Result := l_prc.id
		end

end
