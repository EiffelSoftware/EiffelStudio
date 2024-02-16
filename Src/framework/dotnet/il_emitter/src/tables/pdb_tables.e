note
	description: "[
					These are the indexes to the tables for PDB content.   
					They are in order as they will appear in the PE file (if they do appear in the PE file)
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	PDB_TABLES

feature -- PDB tables

	tDocument: NATURAL_32 = 48 -- 0x30
		-- The Document table

	tMethodDebugInformation: NATURAL_32 = 49 -- 0x31

	tLocalScope: NATURAL_32 = 50 -- 0x32

	tLocalVariable: NATURAL_32 = 51 -- 0x33

	tLocalConstant: NATURAL_32 = 52 -- 0x34

	tImportScope: NATURAL_32 = 53 -- 0x35

	tStateMachineMethod: NATURAL_32 = 54 -- 0x36

	tCustomDebugInformation: NATURAL_32 = 55 -- 0x37

feature -- Instances

	instances: ITERABLE [NATURAL_32]
			-- All known indexes to PE_TABLES.
		do
			Result := <<
					tDocument,
					tMethodDebugInformation,
					tLocalScope,
					tLocalVariable,
					tLocalConstant,
					tImportScope,
					tStateMachineMethod,
					tCustomDebugInformation
				>>
		ensure
			instance_free: class
		end

	index_of (a_value: NATURAL_32): NATURAL_8
			-- Index of first occurrence of item identical to `a_value'.
			-- -1 if none.
		local
			l_area: SPECIAL [NATURAL_32]
		do
			l_area := (create {ARRAYED_LIST [NATURAL_32]}.make_from_iterable (instances)).area
			Result := l_area.index_of (a_value, l_area.lower).to_natural_8
		ensure
			instance_free: class
		end

feature -- Helper

	tKnownTablesMask: NATURAL_64
			-- this is naively ignoring the various CIL tables that aren't supposed to be in the file
			-- may have to revisit that at some point.
		do
			Result := ({NATURAL_64} 1 |<< tDocument.to_integer_32)
					| ({NATURAL_64} 1 |<< tMethodDebugInformation.to_integer_32)
					| ({NATURAL_64} 1 |<< tLocalScope.to_integer_32)
					| ({NATURAL_64} 1 |<< tLocalVariable.to_integer_32)
					| ({NATURAL_64} 1 |<< tLocalConstant.to_integer_32)
					| ({NATURAL_64} 1 |<< tImportScope.to_integer_32)
					| ({NATURAL_64} 1 |<< tStateMachineMethod.to_integer_32)
					| ({NATURAL_64} 1 |<< tCustomDebugInformation.to_integer_32)
		end

end
