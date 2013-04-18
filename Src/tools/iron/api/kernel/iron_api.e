note
	description: "Summary description for {IRON_API}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	IRON_API

inherit
	SHARED_EXECUTION_ENVIRONMENT

feature {NONE} -- Initialization

	make
		do
			make_with_layout (create {IRON_LAYOUT}.make_default)
		end

	make_with_layout (a_layout: like layout)
		do
			layout := a_layout
			initialize
		end

	initialize
		do
		end

feature -- Access

	layout: IRON_LAYOUT

feature {NONE} -- Implementation

	file_content (p: PATH): detachable STRING
		local
			f: RAW_FILE
		do
			create f.make_with_path (p)
			if f.exists and then f.is_access_readable then
				f.open_read
				create Result.make (1_024)
				from
				until
					f.exhausted
				loop
					f.read_stream (1_024)
					Result.append (f.last_string)
				end
				f.close
			end
		end


end
