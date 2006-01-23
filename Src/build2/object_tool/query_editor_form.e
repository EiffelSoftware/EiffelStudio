indexing
	description: "Form containing a set of query properties used to generate %
				% the corresponding object editor."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class QUERY_EDITOR_FORM

