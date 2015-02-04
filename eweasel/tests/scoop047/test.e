note
	description: "Test if exception objects are correctly imported."
	author: "Florian Besser, Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"
	original_source: "http://se.inf.ethz.ch/student_projects/florian_besser/code.zip"
	original_test: "SCOOP testsuite/Small Tests/WebFileTransfer"

class
	TEST

create
	make

feature -- Access

	exception_manager: ISE_EXCEPTION_MANAGER

feature {NONE} -- Initialization

	make
			-- Run the test
		local
			i: INTEGER
			server: separate WEBSERVER
		do
			create exception_manager
			create server

			do_request (server, 0, Void) -- Simulated request: no exception.
			do_request (server, 1, Void) -- Simulated request: NOT_FOUND_EXCEPTION - description ok.
			do_request (server, 2, Void) -- Simulated request: TIMEOUT_EXCEPTIION - description ok.
			do_request (server, 1, "hello") -- Simulated request: NOT_FOUND_EXCEPTION - description ok.
			do_request (server, 2, "world") -- Simulated request: TIMEOUT_EXCEPTIION - description ok.
		rescue
			print ("ERROR: Exception in root feature.%N")
		end

	do_request (webserver: separate WEBSERVER; type: INTEGER; str: detachable STRING)
			-- Put a request on `webserver'.
		local
			retried, sync: BOOLEAN
		do
			if not retried then 
				sync := webserver.simulate_request (type, str)
				print ("Simulated request: no exception.%N")
			end
		rescue
			print ("Simulated request: ")

			if attached {NOT_FOUND_EXCEPTION} exception_manager.last_exception then
				print ("NOT_FOUND_EXCEPTION")
			elseif attached {TIMEOUT_EXCEPTION} exception_manager.last_exception then
				print ("TIMEOUT_EXCEPTION")
			elseif attached exception_manager.last_exception then
				print ("(unknown exception)")
			else
				print ("(exception void)")
			end

			if 
				attached exception_manager.last_exception as excpt 
				and then excpt.description ~ str
			then
				print (" - description ok.%N")
			else
				print (" - description wrong.%N")
			end
			retried := True
			retry
		end
end
