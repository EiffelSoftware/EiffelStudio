indexing
	description: "Custom attribute declaration"
	date: "$Date$"
	revision: "$Revision$"

class
	ECDP_ATTRIBUTE_DECLARATION

inherit
	ECDP_NAMED_ENTITY

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialization
		do
			default_create
			create arguments.make
		ensure then
			non_void_arguments: arguments /= Void
		end
		
feature -- Access

	arguments: LINKED_LIST [ECDP_ATTRIBUTE_ARGUMENT]
			-- List of arguments.

	constructor_name: STRING
			-- Constructor name
			
	code: STRING is
			-- | Result := "create {`name'}.constructor_name [('arguments')] [[`arguments']] end"
			-- Eiffel syntax of custom attribute.
		local
			l_properties_setting: BOOLEAN
		do
			create Result.make (120)
			Result.append (Dictionary.Create_keyword)
			Result.append (Dictionary.Space)
			Result.append (Dictionary.Opening_brace_bracket)
			Result.append (Eiffel_types.eiffel_type_name (name))
			Result.append (Dictionary.Closing_brace_bracket)
			Result.append (constructor_call)

				-- Constructor arguments.
			from
				arguments.start
				if not arguments.after then
					Result.append (Dictionary.Space)
					Result.append (Dictionary.Opening_round_bracket)
					Result.append (arguments.item.code)
					arguments.forth
				end
			until
				arguments.after or else not arguments.item.name.is_empty
			loop
				Result.append (Dictionary.Comma)
				Result.append (Dictionary.Space)
				Result.append (arguments.item.code)
				arguments.forth
			end
			if arguments.count > 0 then
				Result.append (Dictionary.Closing_round_bracket)
			end
			
				-- Properties setting.
			l_properties_setting := not arguments.after
			from
				if l_properties_setting then
					arguments.item.set_type (name)
					Result.append (arguments.item.code)
					arguments.forth
				end
			until
				arguments.after
			loop
				Result.append (Dictionary.Comma)
				Result.append (Dictionary.Space)
				arguments.item.set_type (name)
				Result.append (arguments.item.code)
				arguments.forth
			end
			if l_properties_setting then
				Result.append ("]")
			end
			Result.append (Dictionary.Space)
			Result.append (Dictionary.End_keyword)
		end

feature -- Status Setting

	set_constructor_name (a_name: like constructor_name) is
			-- Set `constructor_name' with `a_name'.
		require
			non_void_name: a_name /= Void
		do
			constructor_name := a_name
		ensure
			constructor_name_set: constructor_name = a_name
		end

	add_attribute (an_attribute: ECDP_ATTRIBUTE_ARGUMENT) is
			-- Add `an_attribute' to `arguments'.
		require
			non_void_an_attribute: an_attribute /= Void
		do
			arguments.extend (an_attribute)
		ensure
			an_attribute_added: arguments.has (an_attribute)
		end

feature {NONE} -- Implementation

	constructor_call: STRING is
			-- | call `Eiffel_types.eiffel_constructor_name' to find constructor_name
			-- | Result := ""
			-- | OR		:= ".constructor_name"

			-- Generate constructor name.
		require
			name_set: not name.is_empty
		local
			l_arguments: LINKED_LIST [ECDP_EXPRESSION]
		do
			create Result.make (40)
			
			create l_arguments.make
			from
				arguments.start
			until
				arguments.after or else not arguments.item.name.is_empty
			loop
				l_arguments.extend (arguments.item.value)
				arguments.forth
			end
			Result.append (Eiffel_types.eiffel_constructor_name (Eiffel_types.dotnet_type (name), l_arguments))

			set_constructor_name (Result)

			if not Result.is_empty then
				Result.prepend (dictionary.Dot_keyword)
			end
		ensure
			non_void_result: Result /= Void
		end

invariant
	non_void_arguments: arguments /= Void

end -- class ECDP_ATTRIBUTE_DECLARATION

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