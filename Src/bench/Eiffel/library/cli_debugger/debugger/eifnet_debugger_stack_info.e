indexing
	description: "Current stack information for dotnet debugging"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFNET_DEBUGGER_STACK_INFO

inherit
	ANY
		redefine
			is_equal
		end

feature -- Access

	current_stack_address: STRING
	current_stack_pseudo_depth: INTEGER
	current_module_name: STRING
	current_class_token: INTEGER
	current_feature_token: INTEGER
	current_il_offset: INTEGER
	current_il_code_size: INTEGER

	to_string: STRING is
		do
			Result := current_stack_pseudo_depth.out 
					+ ":"
					+ current_class_token.out -- to_hex_string
					+ "." 
					+ current_feature_token.out -- to_hex_string
					+ "@"
					+ current_il_offset.out -- to_hex_string
		end

feature -- Is Equal

	is_equal (other: like Current): BOOLEAN is
			-- Is `other' attached to an object considered
			-- equal to current object?
		do
			Result := 	 (current_stack_pseudo_depth 	= other.current_stack_pseudo_depth	)
				and then (current_class_token 			= other.current_class_token			)
				and then (current_feature_token 		= other.current_feature_token		)
				and then (current_il_offset		 		= other.current_il_offset			)
		end

feature -- Change

	set_current_stack_address (val: like current_stack_address) is
			-- Change value
		require
		do
			current_stack_address := val
		end

	set_current_stack_pseudo_depth (val: like current_stack_pseudo_depth) is
			-- Change value
		require
		do
			current_stack_pseudo_depth := val
		end

	set_current_module_name (val: like current_module_name) is
			-- Change value
		require
		do
			current_module_name := val
		end

	set_current_class_token (val: like current_class_token) is
			-- Change value
		require
		do
			current_class_token := val
		end

	set_current_feature_token (val: like current_feature_token) is
			-- Change value
		require
		do
			current_feature_token := val
		end

	set_current_il_offset (val: like current_il_offset) is
			-- Change value
		require
		do
			current_il_offset := val
		end

	set_current_il_code_size (val: like current_il_code_size) is
			-- Change value
		require
		do
			current_il_code_size := val
		end

feature

	reset is
		do
			current_stack_address         := Void
			current_stack_pseudo_depth	  := 0
			current_module_name           := Void
			current_class_token           := 0
			current_feature_token         := 0
			current_il_offset             := 0
			current_il_code_size		  := 0

--			current_callstack_initialized := False
		end



end -- class EIFNET_DEBUGGER_STACK_INFO
