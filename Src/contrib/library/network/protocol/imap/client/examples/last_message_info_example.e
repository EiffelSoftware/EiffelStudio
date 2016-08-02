note
	description: "An example of how to retrieve message info"
	author: "Basile Maret"

class
	LAST_MESSAGE_INFO_EXAMPLE

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
			print("** Login, select INBOX and print the last message **")
			io.put_new_line
			io.put_new_line

			imap.login (User_name, Password)
			if imap.get_current_state ~ {IL_NETWORK_STATE}.authenticated_state then
				-- We logged in successfully
				print (imap.get_last_response.information_message)
				io.put_new_line
				io.put_new_line

				if open_mailbox then
					get_last_message
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

		get_last_message
				-- Print the information of the last message
			require
				imap.get_current_state = {IL_NETWORK_STATE}.selected_state
			local
				messages: HASH_TABLE [IL_MESSAGE, NATURAL]
				message: IL_MESSAGE
			do
				messages := imap.fetch_messages (create {IL_SEQUENCE_SET}.make_last)

				across
					messages as fetch
				loop
					message := fetch.item
					print ("Message with sequence number ")
					print (message.sequence_number)
					print (" and uid ")
					print (message.uid)
					print (" :")
					io.put_new_line

					print ("From : ")
					print (message.from_address.name + " (" + message.from_address.address + ")")
					io.put_new_line

					print ("To : ")
					across
						message.to_address as to_address
					loop
						print (to_address.item.name + " (" + to_address.item.address + ") ")
					end
					io.put_new_line

					print ("Date : ")
					print (message.date.out)
					io.put_new_line

					print ("Content type (retrieved from header) : ")
					print (message.header_field ("Content-Type"))
					io.put_new_line

					print ("Subject : ")
					print (message.subject)
					io.put_new_line

					print ("Body text (size " + message.size.out + " B):")
					io.put_new_line
					print (message.body_text)
					io.put_new_line



				end
			end

feature {NONE} -- Constants

	From_field: STRING = "BODY[HEADER.FIELDS (FROM)]"
	Date_field: STRING = "BODY[HEADER.FIELDS (DATE)]"
	Subject_field: STRING = "BODY[HEADER.FIELDS (SUBJECT)]"
	Body_text_field: STRING = "BODY[TEXT]"

end
