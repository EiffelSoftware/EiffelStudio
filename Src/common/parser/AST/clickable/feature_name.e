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
		rename
			feature_name as internal_name
		undefine
			is_equal, internal_name
		redefine
			is_feature
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

end -- class FEATURE_NAME
