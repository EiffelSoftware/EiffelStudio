note
	description: "Task Scheduler"
	legal: "See notice at end of class."
	status: "See notice at end of class."

class
	TASK_SCHEDULER

inherit
	ECOM_EXCEPTION

create

	make

feature -- Initialization

	make
			-- Create Task Scheduler.
		do
			create_task_scheduler
			run
		end

	run
			-- Run task Scheduler.
		local
			a_string: STRING
			retried: BOOLEAN
		do
			from
				menu
				io.read_line
			until
				io.last_string.item (1) = 'q'
			loop
				inspect
					io.last_string.item (1)
				when 'n', 'N' then
					io.putstring ("What is the task name?")
					io.put_new_line
					io.read_line
					a_string := io.last_string
					create_new_task (a_string)
					save_task

				when 's', 'S' then
					io.putstring ("What is the task Comment?")
					io.put_new_line
					io.readline
					a_string := io.last_string
					a_task.set_comment (a_string)
					save_task

				when 'c', 'C' then
					io.put_string (task_comment)
					io.put_new_line

				when 'a', 'A' then
					io.put_string (task_account_info)
					io.put_new_line

				when 'e', 'E' then
					edit_task

				else
				end
				menu
				io.read_line
			end
		rescue
			io.put_string (meaning (exception) + " " + tag_name)
			io.put_new_line
			retried := True
			retry
		end

feature -- Access

	clsid_ctask: STRING = "{148BD520-A2AB-11CE-B11F-00AA00530503}"
			-- Class ID of CTask coclass.

	iid_itask: STRING = "{148BD524-A2AB-11CE-B11F-00AA00530503}"
			-- Interface ID of ITask interface.

	task_scheduler: CTASK_SCHEDULER_PROXY
			-- Tast Scheduler Proxy.

	a_task: CTASK_PROXY
			-- Task.

	task_comment: STRING
			-- Task Comment.
		require
			non_void_task: a_task /= Void
		local
			result_cell: CELL [STRING]
			retried: BOOLEAN
		do
			if not retried then
				create result_cell.put (Void)
				a_task.get_comment (result_cell)
				Result := result_cell.item
			end
		rescue
			io.put_string (meaning (exception) + " " + tag_name)
			io.put_new_line
			retried := True
			create Result.make (0)
			retry
		end

	task_account_info: STRING
			-- Task Account information.
		require
			non_void_task: a_task /= Void
		local
			result_cell: CELL [STRING]
			retried: BOOLEAN
		do
			if not retried then
				create result_cell.put (Void)
				a_task.get_account_information (result_cell)
				Result := result_cell.item
			end
		rescue
			io.put_string (meaning (exception) + " " + tag_name)
			io.put_new_line
			retried := True
			create Result.make (0)
			retry
		end

feature -- Basic Operations

	create_task_scheduler
			-- Create task scheduler proxy.
		local
			retried: BOOLEAN
		do
			if not retried then
				create task_scheduler.make
			end
		rescue
			io.put_string (meaning (exception) + " " + tag_name)
			io.put_new_line
			retried := True
			retry
		end

	create_new_task (a_task_name: STRING)
			-- Create New Task.
		require
			non_void_task_scheduler: task_scheduler /= Void
			non_void_name: a_task_name /= Void
			valid_name: not a_task_name.empty
		local
			retried: BOOLEAN
			a_clsid_ctask, a_iid_itask: ECOM_GUID
			a_task_cell: CELL [ECOM_INTERFACE]
		do
			if not retried then
				create a_clsid_ctask.make_from_string (clsid_ctask)
				create a_iid_itask.make_from_string (iid_itask)

				create a_task_cell.put (Void)

				task_scheduler.new_work_item (a_task_name, a_clsid_ctask, a_iid_itask, a_task_cell)

				create a_task.make_from_other (a_task_cell.item)
			end
		rescue
			if is_developer_exception then
				if (hresult = -2147024816) then
					task_scheduler.activate (a_task_name, a_iid_itask, a_task_cell)
					create a_task.make_from_other (a_task_cell.item)
				end
			else
				io.put_string (meaning (exception) + " " + tag_name)
				io.put_new_line
			end
			retried := True
			retry
		end

	save_task
			-- Save task.
		require
			non_void_task: a_task /= Void
		local
			retried: BOOLEAN
		do
			if not retried then
				a_task.save (Void, 1)
			end
		rescue
			io.put_string (meaning (exception) + " " + tag_name)
			io.put_new_line
			retried := True
			retry
		end

	edit_task
			-- Edit task.
		require
			non_void_task: a_task /= Void
		local
			retried: BOOLEAN
		do
			if not retried then
				a_task.edit_work_item (default_pointer, 0)
			end
		rescue
			io.put_string (meaning (exception) + " " + tag_name)
			io.put_new_line
			retried := True
			retry
		end

feature {NONE} -- Implementation

	menu
			-- Menu.
		do
			io.put_new_line
			io.put_string ("n: Create new task.")
			io.put_new_line
			io.put_string ("s: Set Comment.")
			io.put_new_line
			io.put_string ("c: Task Comment.")
			io.put_new_line
			io.put_string ("a: Task Account Information.")
			io.put_new_line
			io.put_string ("e: Edit Task.")
			io.put_new_line
			io.put_string ("q: Quit")
			io.put_new_line

			io.put_new_line
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


end -- class TASK_SCHEDULER

