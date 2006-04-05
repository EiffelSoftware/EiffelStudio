indexing
	description: "Custom attribute declaration"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_ATTRIBUTE_DECLARATION

inherit
	CODE_NAMED_ENTITY

create
	make

feature {NONE} -- Initialization

	make (a_type: like type; a_arguments: like arguments) is
			-- Initialization
		require
			non_void_type: a_type /= Void
		do
			arguments := a_arguments
			type := a_type
		ensure
			type_set: type = a_type
			arguments_set: arguments = a_arguments
		end
		
feature -- Access

	arguments: LIST [CODE_ATTRIBUTE_ARGUMENT]
			-- List of arguments.

	type: CODE_TYPE_REFERENCE
			-- Type of created custom attribute
			
	code: STRING is
			-- | Result := "create {`name'}.constructor_name [('arguments')] [[`arguments']] end"
			-- Eiffel syntax of custom attribute.
		local
			l_properties_setting: BOOLEAN
		do
			create Result.make (120)
			Result.append ("create {")
			Result.append (type.eiffel_name)
			Result.append ("}.make")

				-- Constructor arguments.
			if arguments /= Void then
				from
					arguments.start
					if not arguments.after then
						Result.append (" (")
						Result.append (arguments.item.argument_code)
						arguments.forth
					end
				until
					arguments.after or else not arguments.item.name.is_empty
				loop
					Result.append (", ")
					Result.append (arguments.item.code)
					arguments.forth
				end
				if arguments.count > 0 then
					Result.append_character (')')
				end
		
					-- Properties setting.
				l_properties_setting := not arguments.after
				from
					if l_properties_setting then
						Result.append_character ('[')
						Result.append (arguments.item.code)
						arguments.forth
					end
				until
					arguments.after
				loop
					Result.append (", ")
					Result.append (arguments.item.code)
					arguments.forth
				end
				if l_properties_setting then
					Result.append_character (']')
				end
			end

			Result.append (" end")
		end

invariant
	non_void_arguments: arguments /= Void
	non_void_type: type /= Void

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


end -- class CODE_ATTRIBUTE_DECLARATION

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