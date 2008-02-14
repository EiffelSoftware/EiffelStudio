class
	EXCEPTION_MANAGER_FACTORY

feature -- Access

	exception_manager: EXCEPTION_MANAGER is
			-- Exception manager
		once
			create {ISE_EXCEPTION_MANAGER}Result
		end

end