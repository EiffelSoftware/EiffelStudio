note
	description: "An example of how to poll for changes in a mailbox"
	author: "Basile Maret"

class
	CHECK_MESSAGES_EXAMPLE

inherit
	EXAMPLE

	EXECUTION_ENVIRONMENT

create
	make

feature -- Initialization

	make
			-- Create the example
		do
			create imap.make_ssl_with_address (Server_name)
			--imap.debugger.set_debug (imap.debugger.show_all)
			imap.connect
		end

feature -- Basic operation

	run_example
			-- Run the example
		do
			io.put_new_line
			print("** Login, select INBOX and poll until a change happens **")
			io.put_new_line
			io.put_new_line

			imap.login (User_name, Password)
			if imap.get_current_state ~ {IL_NETWORK_STATE}.authenticated_state then
				-- We logged in successfully
				print (imap.get_last_response.information_message)
				io.put_new_line
				io.put_new_line

				if open_mailbox then
					print ("INBOX selected")
					io.put_new_line
					print("Number of messages in the mailbox : ")
					print(imap.current_mailbox.exists)
					io.put_new_line
					print("Number of recent messages : ")
					print (imap.current_mailbox.recent)
					io.put_new_line
					poll_for_messages
				end

			else
				-- We could not log in
				print ("Error : ")
				print (imap.get_last_response.information_message)
				io.put_new_line
			end

			imap.logout
		end

		open_mailbox: BOOLEAN
				-- Open the mailbox INBOX and return true iff the mailbox was opened successfuly
			require
				authenticated_state: imap.get_current_state = {IL_NETWORK_STATE}.authenticated_state
			do
				imap.select_mailbox ("INBOX")
				Result := imap.get_last_response.status ~ imap.Command_ok_label
			ensure
				correct_result: Result = (imap.get_current_state = {IL_NETWORK_STATE}.selected_state)
			end

		poll_for_messages
				-- Check mailbox until there was a change
				-- This should normally not been done in the main thread
			require
				selected_state: imap.get_current_state = {IL_NETWORK_STATE}.selected_state
			local
				interval_in_seconds: INTEGER
			do
				print ("Waiting for changes")
				io.put_new_line

				interval_in_seconds := 1

				from
				until
					imap.check_for_changes
				loop
					sleep (interval_in_seconds * 1000000000)
					print (".")
				end
				io.put_new_line

				print("Number of messages in the mailbox : ")
				print(imap.current_mailbox.exists)
				io.put_new_line

				print("Number of recent messages : ")
				print (imap.current_mailbox.recent)
				io.put_new_line

				print("Expunged messages : ")
				across
					imap.current_mailbox.get_recent_expunge as expunge
				loop
					print(expunge.item.out + " ")
				end
				io.put_new_line
				print("Flag fetches : ")
				across
					imap.current_mailbox.get_recent_flag_fetches as flags
				loop
					print(flags.key.out + " : ")
					across
						flags.item as flag
					loop
						print(flag.item + " ")
					end
				end
				io.put_new_line

			end
end
