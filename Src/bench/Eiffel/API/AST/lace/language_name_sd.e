indexing
	description: "Description of a language name in Ace"
	date: "$Date$"
	revision: "$Revision$"

class LANGUAGE_NAME_SD

inherit

	AST_LACE

feature {LANGUAGE_NAME_SD, LACE_AST_FACTORY} -- Initialization

	initialize (ln: like language_name) is
			-- Create a new LANGUAGE_NAME AST node.
		require
			ln_not_void: ln /= Void
		do
			language_name := ln
			language_name.to_lower
		ensure
			language_name_set: language_name = ln
		end

feature -- Properties

	language_name: ID_SD
			-- Language name

	is_c: BOOLEAN is
			-- Is the language "C"?
		do
			Result := c_name.is_equal (language_name)
		end

	is_make: BOOLEAN is
			-- Is the language "Make"?
		do
			Result := make_name.is_equal (language_name)
		end

	is_object: BOOLEAN is
			-- Is the language "Object"?
		do
			Result := object_name.is_equal (language_name)
		end

	is_include_path: BOOLEAN is
			-- Is the language "Include_path"?
		do
			Result := include_name.is_equal (language_name)
		end

	is_assembly: BOOLEAN is
			-- Is the language "Assembly"?
		do
			Result := assembly_name.is_equal (language_name)
		end

feature -- Duplication

	duplicate: like Current is
			-- Do a full copy of Current and its sub-ojects.
		do
			create Result
			Result.initialize (language_name.duplicate)
		end

feature -- Comparison

	same_as (other: like Current): BOOLEAN is
			-- Is `other' same as Current?
		do
			Result := other /= Void and then language_name.same_as (other.language_name)
		end

feature -- Saving

	save (st: GENERATION_BUFFER) is
			-- Save current in `st'.
		do
			st.putstring (language_name)
		end

feature {NONE} -- Constants

	c_name: STRING is "c"
			-- C language name.

	make_name: STRING is "make"
			-- Make language name.

	object_name: STRING is "object"
			-- Object language name.

	include_name: STRING is "include_path"
			-- Include path specification.

	assembly_name: STRING is "assembly"
			-- Assembly name.

end -- class LANGUAGE_NAME_SD
