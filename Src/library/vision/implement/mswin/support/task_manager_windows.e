indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class TASK_MANAGER_WINDOWS 

feature

	add_task (a_task: TASK_IMP) is
		do
			if a_task /= Void then
				tasks.extend (a_task)
				application.enable_idle_action
			end
		end

	remove_task (a_task: TASK_IMP) is
		do
			tasks.prune_all (a_task)
			if tasks.is_empty then
				application.disable_idle_action
			end
		end

	tasks: LINKED_LIST [TASK_IMP] is
			-- Tasks executed by `idle_action'
		once
			create Result.make
		ensure
			result_exists: Result /= Void
		end

	application: WEL_APPLICATION is
		deferred
		ensure
			result_exists: Result /= Void
		end

end -- class TASK_MANAGER_WINDOWS

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

