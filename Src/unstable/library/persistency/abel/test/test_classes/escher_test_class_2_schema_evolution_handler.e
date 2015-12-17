note
	description: "Summary description for {APPLICATION_SCHEMA_EVOLUTION_HANDLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ESCHER_TEST_CLASS_2_SCHEMA_EVOLUTION_HANDLER

inherit
	SCHEMA_EVOLUTION_HANDLER
		redefine
				make
		end

create make

feature
	make
			--constructor
	do
		Precursor {SCHEMA_EVOLUTION_HANDLER}
		set_conversion_function (4,5,v4_to_v5)
		set_conversion_function (3,4,v3_to_v4)
		set_conversion_function (2,3,v2_to_v3)
		set_conversion_function (1,2,v1_to_v2)
	end

feature {NONE} --version 1
	v1_to_v2: HASH_TABLE [TUPLE [LIST [STRING], FUNCTION [LIST [ANY], ANY]], STRING]
			-- Conversion table from 1 to 2.
	local
		tmp: SCHEMA_EVOLUTION_DEFAULT_CONVERSION_FUNCTIONS
	do
		-- |auto-generated code
		create tmp
		create Result.make (10)


			-- New attribute of type INTEGER
			-- What is the default value?
			-- Please also check the class invariant!
			Result.force (tmp.variable_constant (0), "new_attr")

		-- |auto-generated code
	end

feature {NONE} --version 2
	v2_to_v3: HASH_TABLE [TUPLE [LIST [STRING], FUNCTION [LIST [ANY], ANY]], STRING]
			-- Conversion table from 2 to 3.
	local
		tmp: SCHEMA_EVOLUTION_DEFAULT_CONVERSION_FUNCTIONS
	do
		-- |auto-generated code
		create tmp
		create Result.make (10)


			-- Convert from INTEGER to STRING
			Result.force (tmp.variable_changed_type ("type_changed", agent tmp.to_string (?)), "type_changed")

		-- |auto-generated code
	end

feature {NONE} --version 3
	v3_to_v4: HASH_TABLE [TUPLE [LIST [STRING], FUNCTION [LIST [ANY], ANY]], STRING]
			-- Conversion table from 3 to 4.
	local
		tmp: SCHEMA_EVOLUTION_DEFAULT_CONVERSION_FUNCTIONS
	do
		-- |auto-generated code
		create tmp
		create Result.make (10)


			-- Change attribute name from test_int to test_string_2
			Result.force (tmp.variable_changed_name ("old_name"), "name_changed")

		-- |auto-generated code
	end

feature {NONE} --version 4
	v4_to_v5: HASH_TABLE [TUPLE [LIST [STRING], FUNCTION [LIST [ANY], ANY]], STRING]
			-- Conversion table from 4 to 5.
	local
		tmp: SCHEMA_EVOLUTION_DEFAULT_CONVERSION_FUNCTIONS
	do
		-- |auto-generated code
		create tmp
		create Result.make (10)


			Result.force (tmp.variable_constant (0), "new_attr")
			Result.force (tmp.variable_changed_type ("type_changed", agent tmp.to_string (?)), "type_changed")
			Result.force (tmp.variable_changed_name ("old_name"), "name_changed")

	end

end
