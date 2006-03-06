indexing
	description: "Custom attribute declaration"
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
			type.set_custom_attribute_type
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

end -- class CODE_ATTRIBUTE_DECLARATION

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2006 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------