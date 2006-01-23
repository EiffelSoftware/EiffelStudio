indexing
	description: "Push_b button containing an application method as %
					% an attribute"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	id: "$Id$"
	revision: "$Revision$"

class

	APPLICATION_METHOD_PUSH_B
	
	--| FIXME extracted from Build, minor changes.
	--| No known bugs or work to be done.

inherit

	EV_LIST_ITEM

creation

	make

feature {NONE} -- Initialization

	make (an_application_method: APPLICATION_METHOD; a_parent: EV_COMBO_BOX) is
			-- Create a push_b button with `an_application method'
			-- as identifier, `a_parent' as parent and call `set_default'.
		require else
			valid_application_method: an_application_method /= Void
		do
			default_create
			set_text (an_application_method.method_name)
			a_parent.extend (Current)
			application_method := an_application_method	
		ensure then
			application_method_set: application_method = an_application_method
		end

feature -- Attribute

	application_method: APPLICATION_METHOD;	

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


end -- class APPLICATION_METHOD_PUSH_B
