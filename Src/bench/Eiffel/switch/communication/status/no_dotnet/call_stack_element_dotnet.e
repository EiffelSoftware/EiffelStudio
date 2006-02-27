indexing
	description	: "Information about a call in the calling stack."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision $"

class CALL_STACK_ELEMENT_DOTNET

inherit
	
	CALL_STACK_ELEMENT

feature {NONE} -- Initialization

	make (level, tid: INTEGER) is
		do
		end

feature -- Properties

	is_eiffel_call_stack_element: BOOLEAN is False

	current_object: ABSTRACT_DEBUG_VALUE is
			-- Current object value
		do
		end

	object_address: STRING

	display_object_address: like object_address
			
feature -- Dotnet Properties

	dotnet_module_name: STRING is
		do
		end

	dotnet_module_filename: STRING is
		do
		end
		
feature
	
	display_feature (st: STRUCTURED_TEXT) is
			-- Display information about associated routine.
		do
		end
		
	display_locals (st: STRUCTURED_TEXT) is
			-- Display the local entities and result (if it exists) of
			-- the routine associated with Current call.
		do
		end		
		
	display_arguments (st: STRUCTURED_TEXT) is
			-- Display the arguments passed to the routine
			-- associated with Current call.
		do
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

end -- class CALL_STACK_ELEMENT_DOTNET

