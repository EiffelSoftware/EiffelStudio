indexing
	description: "Objects that represent a Vision2 action sequence class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_EV_ACTION_SEQUENCE
	
inherit
	ANY
	
	GB_CONSTANTS
		export {NONE}
			all
		end

feature -- Access

	count: INTEGER is
			-- Number of arguments
		do
			Result := argument_types.count
		end
		
	argument_types: ARRAYED_LIST [STRING] is
			-- All argument types of action sequence represented by `Current'.
		deferred
		end

	argument_names: ARRAYED_LIST [STRING] is
			-- All argument names of action sequence represented by `Current'.
		deferred
		end
		
	argument_types_as_string: STRING is
			-- `Result' is string representing argument types
			-- of `Current'. i.e. BOOLEAN INTEGER INTEGER
			-- Void if `count' = 0 (No arguments).
		do
			if count > 0 then
				create Result.make (0)
				from
					argument_types.start
				until
					argument_types.off
				loop
					Result := Result + "argument_types.item"
					if not (argument_types.index = count) then
						Result := Result + " "
					end
					argument_types.forth
				end
			end
		ensure
			result_void_implies_count_zero: Result = Void implies count = 0
			result_not_void_implies_count_valid: Result /= Void implies count > 0
		end
	
	open_arguments: STRING is
			--`Result' is string representing open arguments
			-- of `Current'. i.e. ?, ?, ?
			-- Void if `count' = 0 (No arguments).
		do
			if count > 0 then
				create Result.make (0)
				from
					argument_types.start
				until
					argument_types.off
				loop
					Result := Result + "?"
					if not (argument_types.index = count) then
						Result := Result + ", "
					end
					argument_types.forth
				end
			end
		ensure
			result_void_implies_count_zero: Result = Void implies count = 0
			result_not_void_implies_count_valid: Result /= Void implies count > 0
		end
		
	parameter_list: STRING is
			-- `Result' is string representatiion of paramters.
			-- i.e. an_x, a_y: INTEGER; count: DOUBLE
			-- Void if `count' = 0 (No arguments).
		do
			if count > 0 then
				create Result.make (0)
				from
					argument_types.start
					argument_names.start
				until
					argument_types.off
				loop
					Result := Result + argument_names.item
					if argument_types.index /= argument_types.count then
						if (argument_types @ (argument_types.index + 1)).is_equal (argument_types.item) then
							Result := Result + ", "
						else
							Result := Result  + ": " + argument_types.item + "; "
						end
					else
						Result := Result + ": " + argument_types.item
					end
					argument_types.forth
					argument_names.forth
				end
			end
		ensure
			result_void_implies_count_zero: Result = Void implies count = 0
			result_not_void_implies_count_valid: Result /= Void implies count > 0
		end
		
	debugging_info: STRING is
			-- `Result' is a string representation
			-- which when compiled will generate debugging
			-- information for `Current'.
		do
			create Result.make (0)
			from
				argument_names.start
			until
				argument_names.off
			loop
				Result := Result + "io.putstring (%"" + argument_names.item + " : %" + " + argument_names.item
					-- Now add newlines for last output of `Current'.
				if argument_names.index = count then
					Result := Result + ".out + %"%%N%%N%%N%")"
				else
					Result := Result + ".out + %"%%N%")" + indent
				end
				argument_names.forth
			end
		end

end -- class GB_EV_ACTION_SEQUENCE
