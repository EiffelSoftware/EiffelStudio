indexing
	description: "Worker thread that execute work and calls GUI processing when%
					%events are posted by worker threads. Uses mutex to synchronize%
					%worker thread with GUI."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_THREAD_WORKER

inherit
	EV_THREAD_SEVERITY_CONSTANTS
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize instance.
		do
			create events_queue.make (20)
			create mutex
			create environment
		end

feature -- Status Report

	done: BOOLEAN
			-- Is worker thread done?

feature -- Basic Operation

	do_work (a_job: like job; a_event_handler: ROUTINE [ANY, TUPLE [EV_THREAD_EVENT]]) is
			-- Start `a_job' in a new thread, synchronize with GUI thread when thread
			-- post events and call `a_event_handler' to handle these events.
			-- Note: this feature is blocking although the GUI will still be responsive.
		require
			non_void_job: a_job /= Void
			non_void_event_handler: a_event_handler /= Void
		local
			l_thread: WORKER_THREAD
			l_event: EV_THREAD_EVENT
		do
			job := a_job
			done := False
			create l_thread.make (agent do_job)
			l_thread.launch
			from
			until
				done
			loop
				environment.application.process_events
				mutex.lock
				from
				until
					events_queue.is_empty
				loop
					l_event := events_queue.item
					done := l_event.severity = Stop
					a_event_handler.call ([l_event])
					events_queue.remove
					check
						no_more_events_if_done: done implies events_queue.is_empty
					end
				end
				mutex.unlock
			end
		end
	
	post_event (a_event: EV_THREAD_EVENT) is
			-- Send `a_event' to GUI thread.
			-- Used by worker thread to post events.
		require
			not_done: not done
		do
			mutex.lock
			events_queue.put (a_event)
			mutex.unlock
		end
		
feature {NONE} -- Implementation

	mutex: MUTEX
			-- Mutex used to synchronize worker thread with GUI thread

	events_queue: ARRAYED_QUEUE [EV_THREAD_EVENT]
			-- Events queue
	
	environment: EV_ENVIRONMENT
			-- EiffelVision2 environment, used to access application object

	do_job is
			-- Execute job
			-- Pass `process_event' agent as argument so that job can call back GUI thread
			-- for event processing.
		do
			job.call ([agent post_event])
		end
	
	job: PROCEDURE [ANY, TUPLE [ROUTINE [ANY, TUPLE [EV_THREAD_EVENT]]]]
			-- Job to be executed
			-- Routine's argument is used to call back GUI thread for event processing.
	
invariant
	non_void_events_queue: events_queue /= Void

end -- class EV_THREAD_WORKER
