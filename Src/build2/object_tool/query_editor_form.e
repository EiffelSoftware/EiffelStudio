indexing
	description: "Form containing a set of query properties used to generate %
				% the corresponding object editor."
	date: "$Date$"
	id: "$Id$"
	revision: "$Revision$"

deferred class
	QUERY_EDITOR_FORM

inherit

	EV_VERTICAL_BOX
		select
			is_equal
		end

	SHARED_CLASS_IMPORTER
		rename
			is_equal as old_is_equal
		undefine
			default_create, copy
		end

feature -- Creation

	make (a_name: STRING; a_parent: EV_CONTAINER; test_preconditions: BOOLEAN) is
			-- Create current form.
		do
			default_create
			create_interface (test_preconditions)
			a_parent.extend (Current)
		end

feature {NONE} -- GUI

	create_interface (test_preconditions: BOOLEAN) is
			-- Create the corresponding interface
		deferred
		end

	update_interface is
			-- Update interface after setting `query'.
		deferred
		end

feature -- Access

	set_query (a_query: APPLICATION_QUERY) is
			-- Set `query' to `a_query'.
		require
			query_not_void: a_query /= Void
		do
			query := a_query
			update_interface
		end

feature -- Attributes

	query: APPLICATION_QUERY
			-- Associated query

feature -- Command generation
		
	generate_eiffel_text (argument_namer: LOCAL_NAMER): STRING is
			-- Generate Eiffel text corresponding to the setting
			-- of the query correpsonding to `query'.
		deferred
		end
		
	generate_interface_elements: STRING is
		deferred
		end
		
	build_interface (parent_name: STRING): STRING is
		deferred
		end

feature

	is_real: BOOLEAN is
			-- Is the type of the query is real?
		do
			Result := query.query_type.is_equal ("REAL")
		end

	is_boolean: BOOLEAN is
			-- Is the type of the query is boolean?
		do
			Result := query.query_type.is_equal ("BOOLEAN")
		end

	is_integer: BOOLEAN is
			-- Is the type of the query is integer?
		do
			Result := query.query_type.is_equal ("INTEGER")
		end

	is_double: BOOLEAN is
			-- Is the type of the query is double?
		do
			Result := query.query_type.is_equal ("DOUBLE")
		end

	extension_to_add: STRING is
			-- Extension to add to match types.
		do
			create Result.make (0)
			if is_boolean then
				Result.append (".state")
			elseif is_double then
				Result.append (".to_double")
			elseif is_integer then
				Result.append (".to_integer")
			elseif is_real then
				Result.append (".to_real")
			end
		end

end -- class QUERY_EDITOR_FORM

