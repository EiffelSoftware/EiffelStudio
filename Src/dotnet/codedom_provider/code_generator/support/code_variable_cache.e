indexing
	description: "Record all variables in currently analyzed type to resolve Eiffel names and types	"
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_VARIABLE_CACHE

inherit
	CODE_SHARED_EVENT_MANAGER
		export
			{NONE} all
		end

	CODE_SHARED_TYPE_REFERENCE_FACTORY
		export
			{NONE} all
		end

	CODE_SHARED_GENERATION_CONTEXT
		export
			{NONE} all
		end

feature -- Access

	is_variable (a_name: STRING): BOOLEAN is
			-- Is `a_name' a variable name?
		do
			from
				Variables.start
			until
				Variables.after or Result
			loop
				Result := Variables.item.eiffel_name.is_equal (a_name)
				Variables.forth
			end
		end

feature -- Basic Operations
		
	add_variable (a_dotnet_name: STRING; a_type: CODE_TYPE) is
			-- Add variable `a_unique_variable_name' with type `a_type_name' to `Variables'.
		require
			non_void_name: a_dotnet_name /= Void
			valid_name: not a_dotnet_name.is_empty
			non_void_type: a_type /= Void
		do
			Variables.extend (create {CODE_VARIABLE}.make (create {CODE_VARIABLE_REFERENCE}.make (a_dotnet_name, Type_reference_factory.type_reference_from_code (a_type), Type_reference_factory.type_reference_from_code (current_type))))
		end

	clear_all_local_variables is
			-- clear all content of `variables'
		do
			Variables.wipe_out
		end

feature {NONE} -- Implementation

	Variables: LIST [CODE_VARIABLE] is
			-- All variables in current_feature: parameters and locals
		once
			create {ARRAYED_LIST [CODE_VARIABLE]} Result.make (20)
		ensure
			non_void_result: Result /= Void
		end

end -- class CODE_VARIABLE_CACHE

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