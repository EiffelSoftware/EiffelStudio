indexing
	description: "Class storing references to popup windows "
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	POPUP_WINDOWS

inherit
	CONSTANTS

creation
	make

feature -- Initialization

	make is 
		-- Initialize
		do
			create key_messages.make(50)
			load_table
		end

	load_table is
		local
			file_name: FILE_NAME
			file: RAW_FILE
			s: STRING
			parser: XML_TREE_PARSER
		do	
	
			!! file_name.make_from_string("d:\Eiffel44\case\configurable\new_resources\general.xml")

			!! parser.make 
			!! file.make (file_name)
			if file.exists then
				file.open_read
				file.read_stream (file.count)
				!! s.make(file.count)
				s.append (file.last_string)
				parser.parse_string(s)
				parser.set_end_of_file
				file.close		
			end
		end

feature -- Access

	message(key,extra:STRING; caller: EV_WINDOW) is 
			-- Popup an information window with message.
		require
			key_possible: key /= Void and then not key.empty
			caller_possible: caller /= Void and then caller.shown
		local
			tmp: STRING
			message_dialog: EV_MESSAGE_DIALOG
		do
			if not messages.empty then
				tmp := result_string(key,extra, messages)
				if tmp /= Void then
					message_dialog := message_window (caller)

					message_dialog.set_message(tmp)
					message_dialog.show	
				end
			end			
		end

	error(key,extra:STRING; caller: EV_WINDOW) is 
			-- Popup an Error Window.
		require
			key_possible: key /= Void and then not key.empty
			caller_possible: caller /= Void and then caller.shown
		local
			tmp: STRING

			error_dialog: EV_ERROR_DIALOG
		do
			if not errors.empty then
				tmp := result_string(key,extra, errors)
				if tmp /= Void then
					error_dialog := error_window (caller)
		
					error_dialog.set_message(tmp)
					error_dialog.show	
				end
			end
		end;


	warning(key,extra:STRING; caller: EV_WINDOW) is 
			-- Popup a Warning Window.
		require
			key_possible: key /= Void and then not key.empty
			caller_possible: caller /= Void and then caller.shown
		local
			tmp: STRING
			warning_dialog: EV_WARNING_DIALOG
		do
			if not warnings.empty then
				tmp := result_string(key,extra, warnings)
				if tmp /= Void then
					warning_dialog := warning_window (caller)
					warning_dialog.set_message(tmp)
					warning_dialog.show	
				end
			end
		end

	clear_all is
		-- clear all the popuped dialogs
		do
			-- Since they are exclusive, nothing to put here. 
		end

feature -- Implementation

	message_window (w: EV_WINDOW) : EV_WARNING_DIALOG is
			-- Message Window.
		local
			com: EV_ROUTINE_COMMAND
			arg: EV_ARGUMENT1 [ EV_MESSAGE_DIALOG ]
		once
			!! Result.make(w)
			!! com.make ( ~close )
			!! arg.make ( Result )
			Result.add_ok_command ( com,arg)
			Result.set_title ("Message")
		end

	error_window (w: EV_WINDOW): EV_ERROR_DIALOG is
			-- Error Window.
		local
			com: EV_ROUTINE_COMMAND
			arg: EV_ARGUMENT1 [ EV_MESSAGE_DIALOG ]
		once
			!! Result.make(w)
			!! com.make ( ~close )
			!! arg.make ( Result )
			Result.add_ok_command ( com,arg)
			Result.set_title ("Error")
		end


	warning_window (w: EV_WINDOW) : EV_WARNING_DIALOG is
			-- Warning Window.
		local
			com: EV_ROUTINE_COMMAND
			arg: EV_ARGUMENT1 [ EV_MESSAGE_DIALOG ]
		do
			!! Result.make(w)
			!! com.make ( ~close )
			!! arg.make ( Result )
			Result.add_ok_command ( com,arg)
			Result.set_title ("Warning")
		end

	messages: HASH_TABLE [ STRING, STRING ] is
			-- Messages messages
		once
			!! Result.make (0)
			read_messages_in (Environment.messages_file, Result)
		end

	warnings: HASH_TABLE [ STRING, STRING ] is
			-- Warning messages
		once
			!! Result.make (0)
			read_messages_in (Environment.warnings_file, Result)
		end


	errors: HASH_TABLE [ STRING, STRING ] is
			-- Error messages hashed on error keys.
		once
			!! Result.make (20)
			read_messages_in (Environment.errors_file, Result)
		end

	key_messages: HASH_TABLE [ STRING, STRING ]
		-- Messages that may be popup.

feature -- Operations

	close(args: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Close the window.
		local
			arg: EV_ARGUMENT1 [ EV_MESSAGE_DIALOG ]
		do
			arg ?= args
		end

	read_messages_in (file_named: STRING; msgs: like messages)  is
			-- Read file named 'file_named' and initialize 'messages'
		require
			has_name: file_named /= Void
		local
			file_name: FILE_NAME;
			file: PLAIN_TEXT_FILE;
			line: STRING;
			i: INTEGER;
			key, text: STRING;
			count: INTEGER
			file2: RAW_FILE
			s: STRING
			parser: XML_TREE_PARSER
		do
			!! file_name.make_from_string (file_named)
			!!file.make (file_name)

			-- New part
			--!! parser.make 
			--!! file.make (file_name)
			--if file.exists then
			--	file.open_read
			--	file.read_stream (file.count)
			--	!! s.make(file.count)
			--	s.append (file.last_string)
			--	parser.parse_string(s)
			--	parser.set_end_of_file
			--	file.close		
			--end
			
			if file.exists and then file.is_readable then
				file.open_read;	
				from
					file.readline;
				until
					file.end_of_file
				loop
					line := file.laststring;
					check
						line_exists: line /= Void;
					end;
					count := line.count;
					from
						i := 1
					until
						i > count or else line.item (i) = '/' 
					loop
						i := i + 1
					end;
					if i <= count then
						check
							i_greater_than_1: i > 1;
							i_less_than_line_length :
									i < line.count
						end;
						key := line.substring (1, i - 1);
						text := line.substring (i + 1, line.count);
						text.prune_all	( '%R'	)
						msgs.put (text, key);
					end;
					file.readline
				end;
				file.close
			else
				io.error.putstring ("Can't read messages file: ");
				io.error.putstring (file_name);
				io.error.putstring ("%N")
			end
		end 

	result_string(key,extra: STRING;table: HASH_TABLE[STRING,STRING]):STRING  is
			-- Find the message associated with 'key'
			-- Return Void if not found.
		require
			key_possible: key /= Void and then not key.empty
			table_possible: table /= Void and then not table.empty
		do
			if table.has (key) then
					!! Result.make (0)
					Result.append (table.item (key))
					Result.replace_substring_all ("\", "%N")
					if extra /= Void then
						Result.replace_substring_all ("%%X", extra)
					end	
				else
					io.error.putstring ("Can not find information keyword ")
					io.error.putstring (key)
					io.error.putstring ("%NPlease Contact I.S.E")
					io.error.new_line
				end
		end

invariant
	key_messages_exists: key_messages /= Void
end -- class POPUP_WINDOWS
