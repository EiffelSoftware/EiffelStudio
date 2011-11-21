note
	description: "Parsed option."
	copyright: "Copyright (c) 2003 Paul Cohen."
	license: "Eiffel Forum License v2 (see license.txt)"
	author: "Paul Cohen"
	date: "$Date$"
	revision: "$Revision$"
	
class PARSED_OPTION
   
create
	{COMMAND_LINE_PARSER} make
   
feature {NONE} -- Initialization
	
	make (s: STRING; args: LIST [STRING])
			-- Create a new parsed option with the name `s'
			-- and arguments `args'. `args' may be Void. If `s'
			-- equals "-" the name is not set but `is_single_dash'
			-- will be True.
		require
			s_is_given: s /= Void
			s_not_empty: s /= Void implies s.count > 0 
			single_dash_has_no_arguments: s.is_equal ("-") implies args = Void
		do
			if s.is_equal ("-") then
				is_single_dash := True
			else
				name := s.twin
				if args /= Void then
					arguments := args.twin
				end
			end
		end
      
feature {COMMAND_LINE_PARSER} -- Access
	
	has_name: BOOLEAN
			-- Does this option have a name?
		do
			Result := name /= Void
		end
	
	name: STRING
			-- The name
	
	is_single_dash: BOOLEAN
			-- Is single dash
	
	has_arguments: BOOLEAN
			-- Does this option have any arguments?
		do
			Result := arguments /= Void and then arguments.count > 0 
		end
	
	arguments: LIST [STRING]
			-- Arguments. May be Void
	
	is_invalidly_grouped: BOOLEAN
			-- Is this option invalidly grouped with other options? 
	
feature {COMMAND_LINE_PARSER} -- Status setting
	
	add_argument (arg: STRING)
			-- Add the argument `arg'.
		require
			arg_not_void: arg /= Void
			arg_not_empty: arg.count > 0
		do
			if not has_arguments then
				create {LINKED_LIST [STRING]} arguments.make
			end
			arguments.extend (arg)
		end
	
	set_invalidly_grouped
			-- Set invalidly_grouped.
		do
			is_invalidly_grouped := True
		end
	
invariant
	single_dash_has_no_name: is_single_dash implies name = Void
	single_dash_has_no_arguments: is_single_dash implies not has_arguments
	
end -- class PARSED_OPTION

