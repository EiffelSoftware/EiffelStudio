indexing 
	description: "Eiffel representation of a namespace"
	date: "$$"
	revision: "$$"	

deferred class
	CODE_NAMESPACE_INTERFACE

inherit
	CODE_NAMED_ENTITY

feature {NONE} -- Initialization

	make is
			-- | Call Precursor {CODE_NAMED_ENTITY}
			-- | Initialize `imports' and `types'.

			-- Initialize attributes.
		do
			default_create
			create {ARRAYED_LIST [STRING]} imports.make (5)
			imports.compare_objects
			create {ARRAYED_LIST [CODE_GENERATED_TYPE]} types.make (128)
		ensure then
			non_void_imports: imports /= Void
			non_void_types: types /= Void
		end

feature -- Access

	imports: LIST [STRING]
			-- Imported namespaces

	types: LIST [CODE_GENERATED_TYPE]
			-- Namespace types

feature -- Basic Operations

	add_import (an_import: STRING) is
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

invariant 
	non_void_imports: imports /= Void
	non_void_types: types /= Void

end -- class CODE_NAMESPACE_INTERFACE

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------