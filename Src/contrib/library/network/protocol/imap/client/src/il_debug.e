note
	description: "A debugger to format and display messages"
	author: "Basile Maret"

class
	IL_DEBUG

create
	make

feature {NONE} -- Initialization

	make
			-- Create the debugger with the default value
		do
			debug_mode := Show_warning
		end

feature -- Basic operation

	debug_print (a_tag: STRING; message: STRING)
			-- Print message if debugging is active
		do
			if debug_mode = Show_all then
				print (Debug_tag + a_tag + message)
				io.put_new_line

			elseif debug_mode = Show_info and a_tag /~ Debug_receiving and a_tag /~ Debug_sending then
				print (Debug_tag + a_tag + message)
				io.put_new_line

			elseif debug_mode = Show_warning and a_tag /~ Debug_info and a_tag /~ Debug_receiving and a_tag /~ Debug_sending then
				print (Debug_tag + a_tag + message)
				io.put_new_line
			end


		end

	set_debug (mode: NATURAL)
			-- Set the debugging mode to `mode'
		require
			correct_mode: mode >= 1 and mode <= 4
		do
			debug_mode := mode
		ensure
			debug_on_set: debug_mode = mode
		end

feature -- Constants

	Debug_info: STRING = "INFO: "

	Debug_warning: STRING = "WARNING: "

	Debug_receiving: STRING = "RECEIVING: "

	Debug_sending: STRING = "SENDING: "


	Show_all: NATURAL = 1
	Show_info: NATURAL = 2
	Show_warning: NATURAL = 3
	Show_nothing: NATURAL = 4


	Server_response_not_ok: STRING = "The server response was not an ok response"

	Could_not_parse_response: STRING = "The response manager could not parse the server response"

feature {NONE} -- Implementation

	debug_mode: NATURAL

	Debug_tag: STRING = "%TDEBUG: "

note
	copyright: "2015-2016, Maret Basile, Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
