indexing 
	description: "Eiffel representation of a namespace"
	date: "$$"
	revision: "$$"	

deferred class
	ECDP_NAMESPACE_INTERFACE

inherit
	ECDP_NAMED_ENTITY
		export
			{ECDP_FACTORY} set_from_eiffel
		redefine
			ready,
			set_name
		end

	ECDP_SHARED_DATA
		export
			{NONE} all
		undefine
			default_create,
			is_equal
		end

feature {NONE} -- Initialization

	make is
			-- | Call Precursor {ECDP_NAMED_ENTITY}
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

	imports: LINKED_LIST [ECDP_NAMESPACE]
			-- Imported namespaces

	types: ARRAYED_LIST [ECDP_GENERATED_TYPE]
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

	add_import (an_import: ECDP_NAMESPACE) is
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

	add_type (a_type: ECDP_GENERATED_TYPE) is
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

	add_created_file (a_path: STRING) is
			-- try to add file `a_path' to `temporary_files'.
		local
			rescued: BOOLEAN
		do
			if not rescued then
				temporary_files.add_file (a_path.to_cil, True)
			end
		rescue
			(create {ECDP_EVENT_MANAGER}).raise_event (feature {ECDP_EVENTS_IDS}.Rescued_exception, [feature {ISE_RUNTIME}.last_exception])
			rescued := True
			retry
		end	

	creation_file (a_file_name: STRING): STREAM_WRITER is
			-- create a file in write mode.
		require
			non_void_file_name: a_file_name /= Void
			not_empty_file_name: not a_file_name.is_empty
		local
			l_counter: INTEGER
			l_path: STRING
		do
			if l_counter < 10 then
				if Ace_file.path_to_generated_src.is_empty then
					Ace_file.set_path_to_generated_src ((create {EXECUTION_ENVIRONMENT}).current_working_directory)
				end
				if l_path = Void then
					create l_path.make (200)
					l_path.append (Ace_file.path_to_generated_src)
					l_path.append_character ((create {OPERATING_ENVIRONMENT}).Directory_separator)
					l_path.append (a_file_name)
					l_path.append (".e")
				else
					create l_path.make (200)
					l_path.append (Ace_file.path_to_generated_src)
					l_path.append_character ((create {OPERATING_ENVIRONMENT}).Directory_separator)
					l_path.append (a_file_name)
					l_path.append (l_counter.out)
					l_path.append (".e")
				end
				create Result.make_from_path (l_path)
			else
				Result := Void
			end
		rescue
			(create {ECDP_EVENT_MANAGER}).raise_event (feature {ECDP_EVENTS_IDS}.Rescued_exception, [feature {ISE_RUNTIME}.last_exception])
			l_counter := l_counter + 1
			retry
		end

invariant 
	non_void_imports: imports /= Void
	non_void_types: types /= Void

end -- class ECDP_NAMESPACE_INTERFACE
