
deferred class DEBUG_VALUE

inherit

	SHARED_WORKBENCH

feature

	append_value (cw: CLICK_WINDOW) is deferred end;

	set_hector_addr is
			-- Convert the physical addresses received from the application
			-- to hector addresses. (should be called only once just after
			-- all the information has been received from the application.)
		do
		end;

end
