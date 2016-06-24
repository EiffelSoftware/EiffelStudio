note
	description: "An example of how to list the mailboxes"
	author: "Basile Maret"

class
	LIST_MAILBOX_EXAMPLE

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

		do
			io.put_new_line
			print("** Login and list the mailboxes **")
			io.put_new_line
			io.put_new_line

			imap.login (User_name, Password)
			if imap.get_current_state ~ {IL_NETWORK_STATE}.authenticated_state then
				-- We logged in successfully
				print (imap.get_last_response.information_message)
				io.put_new_line
				io.put_new_line

				list_the_mailboxes

			else
				-- We could not log in
				print ("Error : ")
				print (imap.get_last_response.information_message)
				io.put_new_line
			end

			imap.logout
		end

		list_the_mailboxes
				-- Print a list of the mailboxes and their paths
			require
				imap.get_current_state = {IL_NETWORK_STATE}.authenticated_state
			local
				mailbox_list: LIST[IL_NAME]
			do
				mailbox_list := imap.get_list ("", "*")

				print("The available mailboxes are :")
				io.put_new_line
				across
					mailbox_list as mailbox
				loop
					print (mailbox.item.name)
					print (" in path : ")
					if mailbox.item.path.count = 0 then
						print(".")
					else
						across
							mailbox.item.path as path_level
						loop
							print(path_level.item + "/")
						end
					end

					io.put_new_line
				end
			end
end
