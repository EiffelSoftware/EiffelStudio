indexing
	description: "Gets called when the timer event happens."
	author: "Vincent Brendel"

class
	E_TIMER_COMMAND

inherit
	EV_COMMAND

	FACILITIES

creation
	make

feature -- Initialization

	make(vw:VIEWER_WINDOW; data_file: STRING) is
			-- Initialize
		require
			not_void: vw /= Void and data_file /= Void
		local
			fn: FILE_NAME
			err: BOOLEAN
		do
			if not err then
				viewer := vw
				create fn.make_from_string(data_file)
				create file.make(fn)
				if file.exists then
					time_stamp := file.date
				end
			else
				warning("File does not exist","Please check that the path corresponds to a file", 
						vw)
			end
		ensure
			viewer_set: viewer = vw
			file_set: file /= Void
		rescue
			err := TRUE
			retry
		end

feature -- Actions

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Gets called when the timer event occurs.
		local
			temp: INTEGER
			err: BOOLEAN
		do
			if not err or counter<5 then
				-- Check for update of file...
				if file.exists then
					temp := file.date
					if temp > time_stamp then
						time_stamp := temp
						file.open_read
						file.read_line
						file.close
						viewer.set_selected_topic_by_id(file.last_string)
					end
					counter := 0
				end
			elseif counter=5 then
				warning("Can not read file","File unreadable%N, giving up... %N",viewer)
				counter := 6
			end
			rescue
				err := TRUE
				counter := counter + 1
		end

feature -- Implementation

	counter: INTEGER
			-- The number of times we ad an error.

	viewer: VIEWER_WINDOW
			-- The main window. Used to display the topic on.

	time_stamp: INTEGER
			-- The last time stamp of the file.

	file: RAW_FILE
			-- The file to check.

invariant
	E_TIMER_COMMAND_not_void: viewer /= Void and file /= Void and counter >=0

end -- class E_TIMER_COMMAND
