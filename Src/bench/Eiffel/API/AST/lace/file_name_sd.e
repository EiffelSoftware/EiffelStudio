indexing
	description: "File name node in Ace";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	FILE_NAME_SD

inherit
	AST_LACE

feature {FILE_NAME_SD, LACE_AST_FACTORY} -- Initialization

	initialize (fn: like file__name) is
			-- Create a new FILE_NAME AST node.
		require
			fn_not_void: fn /= Void
		do
			file__name := fn
		ensure
			file__name: file__name = fn
		end

feature -- Properties

	file__name: ID_SD;
			-- File name

feature -- Duplication

	duplicate: like Current is
			-- Duplicate current object
		do
			Result := clone (Current)
			Result.initialize (file__name.duplicate)
		end

feature -- Comparison

	same_as (other: like Current): BOOLEAN is
			-- Is `other' same as Current?
		do
			Result := other /= Void and then file__name.same_as (other.file__name)
		end

feature -- Saving

	save (st: GENERATION_BUFFER) is
			-- Save current in `st'.
		do
			file__name.save (st)
		end

end -- class FILE_NAME_SD
