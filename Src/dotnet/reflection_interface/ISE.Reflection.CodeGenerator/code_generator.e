indexing
	description: "Generate XML files and/or Eiffel classes from instances of `EIFFELCLASS' built by the emitter."
	external_name: "ISE.Reflection.CodeGenerator"
	
deferred class
	CODE_GENERATOR
	
feature -- Basic Operations

	generate_code is
			-- Generate Eiffel or XML code.
		indexing
			external_name: "GenerateCode"
		deferred
		end
		
end -- class CODE_GENERATOR