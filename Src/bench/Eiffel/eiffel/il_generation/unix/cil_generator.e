indexing
	description: "Special object responsible for generating IL byte code"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CIL_GENERATOR

inherit
	IL_GENERATOR

create
	make

feature {NONE} -- Initialization

	make (deg_output: DEGREE_OUTPUT) is
			-- Generate a COM+ assembly.
		do
		end

feature -- Generation

	generate is
			-- Generate a .NET assembly
		do
		end

	deploy is
			-- Copy local assemblies if needed to `Generation_directory/Assemblies' and
			-- copy configuration file to load local assemblies.
		do
		end

end -- class CIL_GENERATOR
