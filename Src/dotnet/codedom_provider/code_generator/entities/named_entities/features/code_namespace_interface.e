indexing 
	description: "Eiffel representation of a namespace"
	date: "$$"
	revision: "$$"	

deferred class
	CODE_NAMESPACE_INTERFACE

inherit
	CODE_NAMED_ENTITY
		redefine
			ready,
			set_name
		end

	CODE_SHARED_EVENT_MANAGER
		export
			{NONE} all
		undefine
			default_create,
			is_equal
		end

feature {NONE} -- Initialization

	make is
			-- | Call Precursor {CODE_NAMED_ENTITY}
			-- | Initialize `imports' and `types'.

			-- Initialize attributes.
		do
			default_create
			create imports.make
			create types.make (128)
		ensure then
			non_void_imports: imports /= Void
			non_void_types: types /= Void
		end

feature -- Access

	imports: LINKED_LIST [CODE_NAMESPACE]
			-- Imported namespaces

	types: ARRAYED_LIST [CODE_GENERATED_TYPE]
			-- Namespace types

feature -- Status Report

	ready: BOOLEAN is
			-- Is named entity ready to be generated?
		do
			Result := True
		end

feature -- Status Setting

	set_name (a_name: like name) is
			-- Redefinition of preconditions of set_name.
		require else
			non_void_name: a_name /= Void
		do
			name := a_name
		end

feature -- Basic Operations

	add_import (an_import: CODE_NAMESPACE) is
			-- Add `an_import' to `imports'.
		require
			non_void_import: an_import /= Void
		do
			if not imports.has (an_import) then
				imports.extend (an_import)
			end
		ensure
			an_import_added: imports.has (an_import)
		end

	add_type (a_type: CODE_GENERATED_TYPE) is
			-- Add `a_type' to `types'.
		require
			non_void_type: a_type /= Void
		do
			if not types.has (a_type) then
				types.extend (a_type)
			end
		ensure
			a_type_added: types.has (a_type)
		end

	creation_file (a_file_name: STRING): STREAM_WRITER is
			-- create a file in write mode.
		require
			non_void_file_name: a_file_name /= Void
			not_empty_file_name: not a_file_name.is_empty
		local
			l_counter: INTEGER
		do
		rescue
			Event_manager.raise_event (feature {CODE_EVENTS_IDS}.Rescued_exception, [feature {ISE_RUNTIME}.last_exception])
			l_counter := l_counter + 1
			retry
		end

invariant 
	non_void_imports: imports /= Void
	non_void_types: types /= Void

end -- class CODE_NAMESPACE_INTERFACE
