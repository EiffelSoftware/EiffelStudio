indexing
	description: "Objects used to store and retrieve data for IL Debug Information"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	IL_DEBUG_INFO_STORAGE

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize `Current'.
		do
			modules_debugger_info := Void
			class_types_debugger_info := Void
			entry_point_token := 0
		end

feature -- Data

	modules_debugger_info: HASH_TABLE [IL_DEBUG_INFO_FROM_MODULE, STRING]

	class_types_debugger_info: HASH_TABLE [IL_DEBUG_INFO_FROM_CLASS_TYPE, INTEGER]

	entry_point_token: INTEGER

feature -- Change

	set_modules_debugger_info (val: like modules_debugger_info) is
			-- Change value
		require
		do
			modules_debugger_info := val
		end

	set_class_types_debugger_info (val: like class_types_debugger_info) is
			-- Change value
		require
		do
			class_types_debugger_info := val
		end

	set_entry_point_token (val: like entry_point_token) is
			-- Change value
		require
		do
			entry_point_token := val
		end

end
