indexing
	description:
		"[
			Objects that provide access to widgets in their default state.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DEFAULT_OBJECT_STATE_CHECKER

inherit
	INTERNAL
		export
			{NONE} all
			{GB_OBJECT_EDITOR} default_create
		end
	
	EV_ANY_HANDLER
		export
			{NONE} all
		end

feature -- Access

	default_object_by_type (a_type: STRING): EV_ANY is
			-- `Result' as a Vision2 object correesponding to `a_type'.
		require
			a_type_not_void: a_type /= Void
		local
			assert_enabled: BOOLEAN
		do
			if all_objects.has (a_type) then
					-- Retrieve an already created object.
				Result := all_objects @ (a_type)
			else
				assert_enabled := (create {ISE_RUNTIME}).check_assert (False)
					-- Create the object and store it for later queries.
				Result ?= new_instance_of (dynamic_type_from_string (a_type))
				Result.default_create
				if assert_enabled then
					assert_enabled := (create {ISE_RUNTIME}).check_assert (True)
				end
				all_objects.put (Result, a_type)
			end
		ensure
			result_not_void: Result /= Void
		end
		
feature {NONE} -- Implementation

	all_objects: HASH_TABLE [EV_ANY, STRING] is
			-- All objects that have been already queried by `Current'.
		once
			create Result.make (20)
		ensure
			Result_not_void: Result /= Void
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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


end -- class DEFAULT_OBJECT_STATE_CHECKER
