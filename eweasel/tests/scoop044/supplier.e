note
	description: "Test exceptions on separate callbacks."
	author: "Florian Besser, Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	SUPPLIER

feature

	execute_callback (a_client: separate CLIENT)
			-- Execute separate callbacks on `a_client'.
		local
			retried: BOOLEAN
		do
			if not retried then
				print ("OK: Start of {SUPPLIER}.execute_callback.%N")
				a_client.fail
				print ("ERROR: In {SUPPLIER}.execute_callback, after separate callback failed.%N")
			else
				print ("OK: Retry of {SUPPLIER}.execute_callback.%N")
				a_client.succeed
				print ("OK: In {SUPPLIER}.execute_callback, after separate callback succeeded.%N")
			end
		rescue
			print ("OK: In rescue of {SUPPLIER}.execute_callback.%N")
			retried := True
			retry
		end

	execute_callback_sync (a_client: separate CLIENT)
			-- Execute separate callbacks on `a_client' with subsequent synchronization.
			-- This should yield the same behaviour as `execute_callback' because
			-- separate callbacks are synchronous anyway.
		local
			sync: BOOLEAN
			retried: BOOLEAN
		do
			if not retried then
				print ("OK: Start of {SUPPLIER}.execute_callback_sync.%N")
				a_client.fail
				sync := a_client.sync
				print ("ERROR: In {SUPPLIER}.execute_callback_sync, after separate callback failed.%N")
			else
				print ("OK: Retry of {SUPPLIER}.execute_callback_sync.%N")
				a_client.succeed
				sync := a_client.sync
				print ("OK: In {SUPPLIER}.execute_callback_sync, after separate callback succeeded.%N")
			end
		rescue
			print ("OK: In rescue of {SUPPLIER}.execute_callback_sync.%N")
			retried := True
			retry
		end

	execute_callback_fail (a_client: separate CLIENT)
			-- Execute a separate callback on `a_client' 
		do
			print ("OK: Start of {SUPPLIER}.execute_callback_fail.%N")
			a_client.fail
			print ("ERROR: In {SUPPLIER}.execute_callback_fail, after separate callback failed.%N")
		rescue
			print ("OK: In rescue of {SUPPLIER}.execute_callback_fail.%N")
		end

end
