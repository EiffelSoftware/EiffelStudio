note

	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class TASK_MANAGER_WINDOWS 

feature

	add_task (a_task: TASK_IMP)
		do
			if a_task /= Void then
				tasks.extend (a_task)
				application.enable_idle_action
			end
		end

	remove_task (a_task: TASK_IMP)
		do
			tasks.prune_all (a_task)
			if tasks.is_empty then
				application.disable_idle_action
			end
		end

	tasks: LINKED_LIST [TASK_IMP]
			-- Tasks executed by `idle_action'
		once
			create Result.make
		ensure
			result_exists: Result /= Void
		end

	application: WEL_APPLICATION
		deferred
		ensure
			result_exists: Result /= Void
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class TASK_MANAGER_WINDOWS

