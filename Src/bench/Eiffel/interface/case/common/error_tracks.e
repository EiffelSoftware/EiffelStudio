indexing
	description: "Class responsible for keeping the error tracks"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	ERROR_TRACKS

inherit

	CONSTANTS

	ONCES

creation
	make

feature -- Creation

	make is do end


feature -- Implementation

	waiting_string : STRING
		-- and what if we do not succeed in writing on the file ...?

	error_with_add : BOOLEAN
		-- error when writing with add_message

feature -- Operations

	add_message ( s : STRING ) is 
		-- Add a message
	require
		string_exists: s /= Void
	local
		fi : PLAIN_TEXT_FILE
		fn : FILE_NAME
		err: BOOLEAN
	do
		if not error_with_add and Environment.project_directory/= Void and then
			Environment.project_directory.count>0 then	
		if not err then
			!! fn.make
			fn.extend(Environment.error_directory)	
			!! fi.make(fn)
			if fi.exists then
				fi.open_append
			else
				!! fi.make_create_read_write ( fn )
			end
			--!! fi.make_open_append(fn)
			if not fi.exists then
				if waiting_string= Void then
					!! waiting_string.make ( 20 )
				end
				waiting_string.append(s)		
			else
				if waiting_string/= VOid and then waiting_string.count >0 then
					fi.put_string(clone(waiting_string))
					waiting_string := Void
				end
				fi.put_string(s)
				fi.put_string("%N")
				fi.close
			end
		else
			if waiting_string= Void then
				!! waiting_string.make(20)
			end
			waiting_string.append(s)
		end
		end
	rescue
		err := TRUE
		error_with_add := TRUE
		retry
	end

end -- class ERROR_TRACKS
