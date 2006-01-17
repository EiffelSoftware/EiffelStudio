indexing
	description: "Current stack information for dotnet debugging"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

create
	default_create, make_copy 
	
feature {NONE} -- Initialization

	make_copy (other: like Current) is
		do
			copy (other)
			
--| FIXME JFIAT: check if some info can be void, at the copy time.
--			is_synchronized            := other.is_synchronized
--
--			current_stack_address      := other.current_stack_address.twin
--			current_stack_pseudo_depth := other.current_stack_pseudo_depth
--			
--			current_module_name        := other.current_module_name.twin
--			
--			current_class_token        := other.current_class_token
--			current_feature_token      := other.current_feature_token
--			current_il_offset          := other.current_il_offset
--			current_il_code_size       := other.current_il_code_size
		end		
	
feature -- Access

	is_synchronized: BOOLEAN

	current_stack_address: STRING
	current_stack_pseudo_depth: INTEGER
	current_module_name: STRING
	current_class_token: INTEGER
	current_feature_token: INTEGER
	current_il_offset: INTEGER
	current_il_code_size: INTEGER

	to_string: STRING is
			-- String representation
			-- debug purpose only
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

feature -- Properties

	set_synchronized (val: BOOLEAN) is
			-- Change is_synchronized.
		do
			is_synchronized := val
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
			-- Reset values
		do
			current_stack_address         := Void
			current_stack_pseudo_depth	  := 0
			current_module_name           := Void
			current_class_token           := 0
			current_feature_token         := 0
			current_il_offset             := 0
			current_il_code_size		  := 0
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class EIFNET_DEBUGGER_STACK_INFO
