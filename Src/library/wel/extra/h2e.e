class
	H2E

inherit
	MESSAGE_BOX
		export 
			{NONE} all
		end

creation
	make

feature -- Initialization

	make (arguments: ARRAY [STRING]) is
			-- Reads the command-line, and creates the converter.
		local
			conv: CONVERTER 
			file_as_classname: STRING
			message_box_message: STRING
		do
			if arguments.count < 3 then
				display_help
			elseif arguments.count > 3 then
				if file_exists(arguments.item (2)) and not arguments.item(3).empty then
					message_box_message := "Start-run h2e.exe%NInputfile: "
					message_box_message.append_string(arguments.item(2))
					message_box_message.append_string("%NOutputfile: ")
					message_box_message.append_string(arguments.item(3))
					message_box_ok (message_box_message, "h2e - Information", Mb_iconinformation)
					!! conv.make (arguments.item (1), arguments.item(3))
					conv.convert (arguments.item (2))
					conv.close_file
					message_box_ok ("End-run h2e.exe%N%
						%%NCopyright (C) 1995, Interactive Software Engineering, Inc.", "h2e - Information",
						Mb_iconinformation)
				else
					message_box_ok ("Inputfile does not exist!%N%
						%%NCopyright (C) 1995, Interactive Software Engineering, Inc.", "h2e - Error",
						Mb_iconstop)
					display_help
				end
			else
				if file_exists (arguments.item(2)) then
					message_box_message := "Start-run h2e.exe%NInputfile: "
					message_box_message.append_string(arguments.item(2))
					message_box_message.append_string("%NOutputfile: ")
					message_box_message.append_string(arguments.item(1))
					message_box_message.append_string(".e (default)")
					message_box_ok (message_box_message, "h2e - Information", Mb_iconinformation)
					file_as_classname := clone(arguments.item(1))
					file_as_classname.append_string(".e")
					!! conv.make (arguments.item(1), file_as_classname)
					conv.convert (arguments.item(2))
					conv.close_file
					message_box_ok ("End-run h2e.exe%N%
						%%NCopyright (C) 1995, Interactive Software Engineering, Inc.", "h2e - Information",
						Mb_iconinformation)
				else
					message_box_ok ("Inputfile does not exist!%N%
						%%NCopyright (C) 1995, Interactive Software Engineering, Inc.", "h2e - Error",
						Mb_iconstop)
					display_help
				end
			end
		end

feature {NONE} -- Status report

	file_exists (filename: STRING): BOOLEAN is
			-- Does `filename' exist?
		require
			filename_not_void: filename /= Void
		local
			a_file: PLAIN_TEXT_FILE
		do
			!! a_file.make (filename)
			Result := a_file.exists
		end

	display_help is
			-- Put help-information on screen
		do
			message_box_ok ("Usage: h2e <classname> <inputfile> [outputfile]%N%
				%%NBoth classname and inputfile must be given at the command-line.%N%
				%The outputfile is optional, and is default set as: <classname>.e%N%
				%%NExample: h2e windowconstants windows.h windows.e%N%
				%%NCopyright (C) 1995, Interactive Software Engineering, Inc.", "h2e - Help",
				Mb_iconexclamation)
		end

end -- class H2E

--|--------------------------------------------------------------
--| Copyright (C) 1995, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|--------------------------------------------------------------
