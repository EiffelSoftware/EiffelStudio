indexing

	description:
		"Abstract class for an Eiffel feature name: id or %
		%infix/prefix notation."
	date: "$Date$"
	revision: "$Revision$"

deferred class FEATURE_NAME

inherit
	AST_EIFFEL
		undefine
			is_equal
		end

	COMPARABLE

	CLICKABLE_AST
		undefine
			is_equal
		redefine
			is_feature, associated_feature_name
		end

	SHARED_NAMES_HEAP
		export
			{NONE} all
		undefine
			is_equal
		end

-- Undefined is_equal of AST_EIFFEL and CLICKABLE_AST because these are
-- not consistent with infix < operator
-- < is defined by the terms of < of feature name and is_equal 
-- (from ANY is c_standard_is_equal)

feature -- Stoning

	internal_name_id: INTEGER is
			-- `internal_name' ID in NAMES_HEAP.
		local
			l_names_heap: like Names_heap
		do
			l_names_heap := Names_heap
			l_names_heap.put (internal_name)
			Result := l_names_heap.found_item
		end

	internal_name: ID_AS is
			-- Internal name used by the compiler.
		deferred
		ensure
			internal_name_not_void: Result /= Void
		end

	associated_feature_name: STRING is
		do
			Result := internal_name
		end

feature -- Location

	start_location: LOCATION_AS is
			-- Starting point for current construct.
		do
			Result := internal_name.start_location
		end
		
	end_location: LOCATION_AS is
			-- Ending point for current construct.
		do
			Result := internal_name.end_location
		end

feature -- Properties

	is_frozen: BOOLEAN
			-- Is the name of the feature frozen ?

	is_infix: BOOLEAN is
			-- Is the feature name an infixed notation ?
		do
		end

	is_prefix: BOOLEAN is
			-- Is the feature name a prefixed notation ?
		do
		end

	is_valid: BOOLEAN is
			-- is the feature name valid ?
		do
			Result := True
		end

	is_feature: BOOLEAN is True
			-- Does the Current AST represent a feature?

	visual_name: STRING is
			-- Named used in Eiffel code
		do	
			Result := internal_name
		end

feature -- Comparison

	infix "<" (other: FEATURE_NAME): BOOLEAN is
		deferred
		end

feature {COMPILER_EXPORTER}

	set_is_frozen (b: BOOLEAN) is
		do
			is_frozen := b
		end

feature {FEATURE_AS} -- Formatting

	offset: INTEGER is
		do
			if is_frozen then
					--| offset for frozen routines
				Result := 7
			end
		end

	end_offset: INTEGER is
		do
			Result := 0
		end

feature {NONE} -- Implementation

	code_table: HASH_TABLE [STRING, STRING] is
			-- Corrsepondance table for infix/prefix notation
		once
			create Result.make (20)
			Result.put ("plus", "+")
			Result.put ("minus", "-")
			Result.put ("star", "*")
			Result.put ("slash", "/")
			Result.put ("lt", "<")
			Result.put ("gt", ">")
			Result.put ("le", "<=")
			Result.put ("ge", ">=")
			Result.put ("and", "and")
			Result.put ("or", "or")
			Result.put ("implies", "implies")
			Result.put ("xor", "xor")
			Result.put ("not", "not")
			Result.put ("mod", "\\")
			Result.put ("div", "//")
			Result.put ("power", "^")
			Result.put ("and_then", "and then")
			Result.put ("or_else", "or else")
		end

end -- class FEATURE_NAME
