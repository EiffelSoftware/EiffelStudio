indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class TASK_MANAGER_WINDOWS 

feature

	add_task (a_task: TASK_WINDOWS) is
		do
			if a_task /= Void then
				tasks.extend (a_task)
				application.enable_idle_action
			end
		end

	remove_task (a_task: TASK_WINDOWS) is
		do
			tasks.prune_all (a_task)
			if tasks.empty then
				application.disable_idle_action
			end
		end

	tasks: LINKED_LIST [TASK_WINDOWS] is
			-- Tasks executed by `idle_action'
		once
			!! Result.make
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
--| Copyright (C) 1986-1997 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
