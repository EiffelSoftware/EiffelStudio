note
	description: "Root class for the SED Container example."
	date: "$Date$"
	revision: "$Revision$"

class
	SED_CONTAINER_EXAMPLE

create
	make

feature {NONE} -- Initialization

	make
		local
			data: like new_demo_data
			server: separate SED_SERVER_TASK
			server_lst: ARRAYED_LIST [separate SED_SERVER_TASK]
		do
			data := new_demo_data
			create server_lst.make (5)
			across 1 |..| server_lst.capacity as ic loop
				create server.make ("T." + ic.item.out)
				server_lst.force (server)
					-- Same data for all servers, except the "id" information.
				data.force ([ic.item, "Server#" + ic.item.out], "id")
				set_server_data (data, server)
				separate server as s do
					s.execute (5)
				end
			end
			across
				server_lst as ic
			loop
				wait_for_server_completion (ic.item)
			end
		end

feature {NONE} -- Implementation		

	set_server_data (d: like new_demo_data; server: separate SED_SERVER_TASK)
		do
			server.import_data (create {CP_SED_CONTAINER [ANY]}.put (d))
		end

	server_data (a_server: separate SED_SERVER_TASK): detachable ANY
		local
			cl: CP_SED_CONTAINER [ANY]
		do
			create cl
			a_server.export_data_to (cl)
			Result := cl.item
		end

	wait_for_server_completion (a_server: separate SED_SERVER_TASK)
		require
			execution_completed: a_server.completed
		do
			print ("Execution completed...%N")
			if attached {STRING_TABLE [ANY]} server_data (a_server) as d then
				across
					d as tb
				loop
					print (" - ")
					print (tb.key.out)
					print (" => ")
					if attached {TUPLE [int: INTEGER; str: STRING]} tb.item as l_tuple then
						print ("[ int:" + l_tuple.int.out + ", str:%"" + l_tuple.str + "%"]")
					else
						print (tb.item.out)
					end
					print ("%N")
				end
			else
				print ("not the expected data%N")
			end
		end

	new_demo_data: STRING_TABLE [TUPLE [int: INTEGER; str: STRING]]
		do
			create Result.make (3)
			Result ["one"] := [1, "a"]
			Result ["two"] := [2, "b"]
			Result ["three"] := [3, "c"]
		end

end
