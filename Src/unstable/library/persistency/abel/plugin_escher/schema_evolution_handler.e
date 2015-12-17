note
	description: "Summary description for {SCHEMA_EVOLUTION_HANDLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SCHEMA_EVOLUTION_HANDLER

	create
		make

feature{NONE} -- Versions matrix

	versions: ARRAYED_LIST [ARRAYED_LIST [HASH_TABLE [TUPLE [LIST [STRING], FUNCTION [LIST [ANY], ANY]], STRING]]]
		-- A matrix that contains the transformation functions to be used between 2 versions.
		-- The hash table contains the variables names as a key and a function to evaluate the new field as a value.

feature -- Creation features

	make
			-- Default creation feature
		do
			create versions.make (10)
		end


feature -- Basic operations

	set_conversion_function (from_v, to_v: INTEGER; funct: HASH_TABLE [TUPLE [LIST [STRING], FUNCTION [LIST [ANY], ANY]], STRING])
			-- Add a function to convert version `from_v' to version `to_v'.
		require
			funct_exists: funct /= Void
			from_and_to_different: from_v /= to_v
		local
			i: INTEGER
			tmp: ARRAYED_LIST [HASH_TABLE [TUPLE [LIST [STRING], FUNCTION [LIST [ANY], ANY]], STRING]]
		do
			if to_v >= versions.count then
				from i := versions.count until i >= to_v loop
					versions.force (create {ARRAYED_LIST [HASH_TABLE [TUPLE [LIST [STRING], FUNCTION [LIST [ANY], ANY]], STRING]]}.make (10))
					i := i + 1
				end
			end
			tmp := versions.i_th (to_v)
			if from_v >= tmp.count then
				from i := tmp.count until i >= from_v loop
					tmp.force (create {HASH_TABLE [TUPLE [LIST [STRING], FUNCTION [LIST [ANY], ANY]], STRING]}.make (10))
					i := i + 1
				end
			end
			tmp.put_i_th (funct, from_v)
		end

	create_schema_evolution_handler (to_v, from_v: INTEGER): HASH_TABLE [TUPLE [LIST [STRING], FUNCTION [LIST [ANY], ANY]], STRING]
			-- Returns the function to convert the version `from_v' to the version `to_v'.
		require
			from_and_to_different: from_v /= to_v
			conversion_function_available: conversion_function_available (to_v, from_v)
		local
			tmp: ARRAYED_LIST [HASH_TABLE [TUPLE [LIST [STRING],FUNCTION [LIST [ANY],ANY]],STRING]]
		do
			tmp := versions.i_th (to_v)
			Result := tmp.i_th (from_v)
		ensure
			can_convert_between_two_versions: Result /= Void
		end

	conversion_function_available (to_v, from_v: INTEGER): BOOLEAN
			-- Checks whether conversion function from version `from_v' to version `to_v' is available
		do
			Result := false
			if to_v <= versions.count then
				if from_v <= versions.i_th (to_v).count then
					Result := True
				end
			end
		end

invariant
	version_exists: versions /= Void

end
