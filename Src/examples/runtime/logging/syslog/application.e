note
	description:	"Example application that illustrates how one can use the syslog daemon on Unix"
	legal:			"See note at the end of this class"
	status:			"See notice at the end of this class"
	date:			"$Date$"
	revision:		"$Revision$"

class
	APPLICATION

inherit
	PLATFORM

create
	make

feature {NONE} -- Initialization

	make
			-- Make an instance of APPLICATION, and run the application
		do
				--| Initialize the logging facility
			create log.make
			if is_windows then
				io.error.putstring ("Sorry, this example only works on %
					%non-Windows machines")
			else

					--| Enable system log output
				log.enable_default_system_log

					--| Write an informational message
				log.write_information ("The application is starting up...")
			end
		end

feature {NONE} -- Attributes

	log: attached LOG_LOGGING_FACILITY;
			-- General Eiffel Log Facility

note
	copyright:	"Copyright (C) 2010 by ITPassion Ltd, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (See http://www.eiffel.com/licensing/forum.txt)"
	source:		"[
					ITPassion Ltd.
					5 Anstice Close, Chiswick, Middlesex, W4 2RJ, United Kingdom
					Telephone 0044-208-742-3422 Fax 0044-208-742-3468
					Website http://www.itpassion.com
					Customer Support http://powerdesk.itpassion.com
				]"

end
