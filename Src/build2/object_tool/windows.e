class
	WINDOWS 
	
	--| FIXME extracted from Build and
	--| all redundent code (a lot) removed.

feature {NONE}

	object_tool_generator: OBJECT_TOOL_GENERATOR is
			-- `Result' is the object tool generator.
		once
			create Result.make ("Object tool")
		end

end
