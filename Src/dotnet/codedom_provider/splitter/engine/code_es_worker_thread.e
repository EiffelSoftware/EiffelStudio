indexing
	description: "Worker thread that execute work and calls GUI processing when%
					%events are posted by worker threads. Uses mutex to synchronize%
					%worker thread with GUI."
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_ES_WORKER_THREAD

inherit
	CODE_ES_SEVERITY_CONSTANTS
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
			stop_processing_agent := agent (environment.application).stop_processing
		end

feature -- Access

	events_queue: ARRAYED_QUEUE [CODE_ES_EVENT]
			-- Events queue
	
	mutex: MUTEX
			-- Mutex used to synchronize worker thread with GUI thread

	done: BOOLEAN
			-- Is worker thread done?

	environment: EV_ENVIRONMENT
			-- EiffelVision2 environment class, used to access application object.

feature -- Basic Operation

	do_work (a_job: like job; a_event_handler: ROUTINE [ANY, TUPLE [CODE_ES_EVENT]]) is
			-- Start `a_job' in a new thread, synchronize with GUI thread when thread
			-- post events and call `a_event_handler' to handle these events.
			-- Note: this feature is blocking although the GUI will still be responsive.
		require
			non_void_job: a_job /= Void
			non_void_event_handler: a_event_handler /= Void
		local
			l_thread: WORKER_THREAD
			l_application: EV_APPLICATION
		do
			l_application := environment.application
			job := a_job
			done := False
			create l_thread.make (agent do_job)
			l_thread.launch
			from
			until
				done
			loop
				from
					l_application.process_events_until_stopped
					mutex.lock
				until
					events_queue.is_empty
				loop
					done := events_queue.item.severity = Stop
					a_event_handler.call ([events_queue.item])
					events_queue.remove
					check
						empty_if_done: done implies events_queue.is_empty
					end
				end
				mutex.unlock
			end
		end
	
	post_event (a_event: CODE_ES_EVENT) is
			-- Send `a_event' to GUI thread.
			-- Used by worker thread to post events.
		do
			mutex.lock
			events_queue.put (a_event)
			mutex.unlock
			stop_processing_agent.call (Void)
		end
		
feature {NONE} -- Implementation

	do_job is
			-- Execute job
			-- Pass `process_event' agent as argument so that job can call back GUI thread
			-- for event processing.
		do
			job.call ([agent post_event])
		end
	
	job: PROCEDURE [ANY, TUPLE [ROUTINE [ANY, TUPLE [CODE_ES_EVENT]]]]
			-- Job to be executed
			-- Routine's argument is used to call back GUI thread for event processing.

	stop_processing_agent: ROUTINE [ANY, TUPLE[]]
			-- Agent on `{EV_APPLICATION}.stop_processing' used by worker thread
			-- to synchronize with GUI thread.
	
invariant
	non_void_queue: events_queue /= Void

end -- class CODE_ES_WORKER_THREAD
