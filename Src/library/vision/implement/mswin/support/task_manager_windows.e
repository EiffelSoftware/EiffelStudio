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
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

