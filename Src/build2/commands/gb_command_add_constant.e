indexing
	description: "Objects that represent the addition of a constant."
	date: "$Date$"
	revision: "$Revision$"

class
	GB_COMMAND_ADD_CONSTANT
	
inherit
	
	GB_COMMAND
		export
			{NONE} all
		end
	
	GB_SHARED_HISTORY
		export
			{NONE} all
		end
		
	GB_SHARED_TOOLS
		export
			{NONE} all
		end
	
	GB_SHARED_COMMAND_HANDLER
		export
			{NONE} all
		end
		
	GB_SHARED_CONSTANTS
		export
			{NONE} all
		end
		
	GB_CONSTANTS
		export
			{NONE} all
		end
	
create
	make
	
feature {NONE} -- Initialization

	make (constant: GB_CONSTANT) is
			-- Create `Current' with `child' to be removed from `parent' at
			-- position `position'.
		require
			constant_not_void: constant /= Void
		do
			history.cut_off_at_current_position
			internal_constant := constant
		ensure
			constant_recorded: internal_constant /= Void
		end

feature -- Basic Operation

	execute is
			-- Execute `Current'.
		local
			integer_constant: GB_INTEGER_CONSTANT
			string_constant: GB_STRING_CONSTANT
		do
			if internal_constant.type.is_equal (Integer_constant_type) then
				integer_constant ?= internal_constant
				Constants.add_integer (integer_constant)
			elseif internal_constant.type.is_equal (String_constant_type) then
				string_constant ?= internal_constant
				Constants.add_string (string_constant)
			end
			if not history.command_list.has (Current) then
				history.add_command (Current)
			end
			command_handler.update
		end
		
	undo is
			-- Undo `Current'.
			-- Calling `execute' followed by `undo' must restore
			-- the system to its previous state.
		do
			Constants.remove_constant (internal_constant)
			command_handler.update
		end
		
	textual_representation: STRING is
			-- Text representation of command exectuted.
		do
			Result := internal_constant.type + " constant named " + internal_constant.name + " added to project."
		end

feature {NONE} -- Implementation

	internal_constant: GB_CONSTANT
		-- Constant which is the subject of `Current'.

end -- class GB_COMMAND_ADD_CONSTANT
