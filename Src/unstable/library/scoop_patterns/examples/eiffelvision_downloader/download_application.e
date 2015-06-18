note
	description: "An example with a simple GUI using the patterns library for background downloads."
	author: "Roman Schmocker."
	date: "$Date$"
	revision: "$Revision$"

class
	DOWNLOAD_APPLICATION

create
	make

feature {NONE} -- Initialization

	make
			-- Start the download application example.
		local
			app: EV_APPLICATION
			main_window: MAIN_WINDOW
			worker_pool: separate CP_TASK_WORKER_POOL
		do
				-- Create a worker pool which can be used to execute background downloads.
			create worker_pool.make (10, 1)
			create executor.make (worker_pool)

				-- Create application and main window.
			create app
			create main_window.make (executor)

				-- Don't forget to tear down the worker pool at the end.
			app.destroy_actions.extend (agent executor.stop)

				-- This prevents a bug where the main window suddenly vanishes...
				-- A garbage collection issue?
			app.destroy_actions.extend (agent main_window.do_nothing)

				-- Start the GUI.
			main_window.show
			app.launch
		end

feature -- Access

	executor: CP_EXECUTOR_PROXY
			-- The worker pool for background tasks.

end
