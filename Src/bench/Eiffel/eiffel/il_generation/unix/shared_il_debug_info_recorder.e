indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_IL_DEBUG_INFO_RECORDER

feature -- Token Recorder

	il_debug_info_recorder: IL_DEBUG_INFO_RECORDER is
		once
			create Result.make
		end

end -- class SHARED_IL_DEBUG_INFO_RECORDER
