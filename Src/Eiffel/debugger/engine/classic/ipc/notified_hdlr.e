note
	legal: "See notice at end of class."
	status: "See notice at end of class."
class NOTIFIED_HDLR

inherit

	RQST_HANDLER_WITH_DATA

	SHARED_DEBUGGER_MANAGER

create

	make

feature

	make
			-- Create Current and pass addresses to C
		do
			request_type := Rep_notified;
			pass_addresses
		end;

	execute
			-- register termination of the controlled application
		local
			retried: BOOLEAN
			event_type: INTEGER
			event_data: INTEGER
			s: APPLICATION_STATUS
		do
			if not retried then
				debug ("debugger_ipc")
					io.error.put_string (generator + ": start %N")
				end
					--|--------------------------------|--
					--| Retrieve data sent by debuggee |--
					--|--------------------------------|--

					--| Reset pipe reader parsing
				reset_parsing

					--| Read feature name.
				read_integer
				event_type := last_integer

				read_integer
				event_data := last_integer

					--|----------------------------|--
					--| Data retrieved             |--
					--| Now process stopped state  |--
					--|----------------------------|--				

				s := Debugger_manager.application_status
				inspect
					event_type
				when notif_thr_created then
					debug ("debugger_ipc")
						print (generator + " : Thread created: " + event_data.to_hex_string + "%N")
					end
					s.add_thread_id (Default_pointer + event_data)

				when notif_thr_exited then
					debug ("debugger_ipc")
						print (generator + " : Thread exited: " + event_data.to_hex_string + "%N")
					end
					s.remove_thread_id (Default_pointer + event_data)
				else
					debug ("debugger_ipc")
						print ("EWB notified eventType="+ event_type.out + "eventData=" + event_data.out + "%N")
						print ("  -> data=" + detail + "%N")
					end
				end

				debug ("DEBUGGER_TRACE")
					io.error.put_string (generator + ": end %N")
				end
			end
		rescue
			retried := True
			retry
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
