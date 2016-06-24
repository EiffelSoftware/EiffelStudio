note
	description: "An example of how to retrieve mailbox info"
	author: "Basile Maret"

class
	MAILBOXES_INFO_EXAMPLE

inherit
	EXAMPLE

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
		local
				mailbox_list: LIST[IL_NAME]
		do
			io.put_new_line
			print("** Login and show info for every mailbox **")
			io.put_new_line
			io.put_new_line

			imap.login (User_name, Password)
			if imap.get_current_state ~ {IL_NETWORK_STATE}.authenticated_state then
				-- We logged in successfully
				print (imap.get_last_response.information_message)
				io.put_new_line
				io.put_new_line

				get_mailboxes_info (imap.get_list ("", "*"))

			else
				-- We could not log in
				print ("Error : ")
				print (imap.get_last_response.information_message)
				io.put_new_line
			end

			imap.logout
		end

		get_mailboxes_info (a_mailbox_list: LIST[IL_NAME])
				-- Get info about every mailbox in `a_mailbox_list'
			require
				imap.get_current_state = {IL_NETWORK_STATE}.authenticated_state
			local
				status: STRING_TABLE [INTEGER]
				data_needed: LINKED_LIST [STRING]
			do
				create data_needed.make
				data_needed.extend (imap.message_status)
				data_needed.extend (imap.unseen_status)
				across
					a_mailbox_list as mailbox
				loop
					status := imap.get_status (mailbox.item.raw_path, data_needed)
					print (mailbox.item.raw_path)
					print (" has : ")
					io.put_new_line

					across
						status as data
					loop
						print (data.key)
						print (" : ")
						print (data.item)
						io.put_new_line
					end
					io.put_new_line
				end
			end
end
