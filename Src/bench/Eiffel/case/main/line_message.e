indexing

	description: "Store interactive messages.";
	date: "$Date$";
	revision: "$Revision $"

deferred class LINE_MESSAGE

inherit

	CONSTANTS

feature {NONE} -- Implementation properties

	messages: HASH_TABLE [STRING, STRING] is
			-- Lines of read messages
		deferred
		end;

	read_messages_in (file_named: STRING)  is
			-- Read file named 'file_named' and initialize 'messages'
		require
			has_name: file_named /= Void
		local
			file_name: FILE_NAME;
			file: PLAIN_TEXT_FILE;
			line: STRING;
			i: INTEGER;
			key, text: STRING;
			count: INTEGER;
			msgs: like messages
		do
			!! file_name.make_from_string (file_named);
			!!file.make (file_name);
			if file.exists and then file.is_readable then
				file.open_read;	
				msgs := messages;
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
	
end -- class LINE_MESSAGE
