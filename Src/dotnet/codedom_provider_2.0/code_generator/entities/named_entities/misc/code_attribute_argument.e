indexing
	description: "Attribute argument of a custom attribute"
	date: "$$"
	revision: "$$"	

class
	CODE_ATTRIBUTE_ARGUMENT

inherit
	CODE_ENTITY

	CODE_SHARED_NAME_FORMATTER
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_value: like value; a_name: like name; a_type: like type) is
			-- Initialize instance.
		require
			non_void_value: a_value /= Void
			non_void_type: a_type /= Void
		do
			value := a_value
			name := a_name
			type := a_type
		ensure
			value_set: value = a_value
			name_set: name = a_name
			type_set: type = a_type
		end

feature -- Access

	name: STRING
			-- Name of property or attribute to set if any

	value: CODE_EXPRESSION
			-- Argument or value to set property or attribute with name `name' with
			
	type: CODE_TYPE_REFERENCE
			-- Type of the custom attribute.
			
	code: STRING is
			-- | Result := "`value'"	 if name.is_empty
			-- | OR
			-- | Result := "["`name'", `value']"
		do
			create Result.make (120)
			if name = Void or else name.is_empty then
				Result.append (value.code)
			else
				Result.append ("[")
				Result.append ("%"")
				Result.append (Name_formatter.formatted_feature_name (name))
				Result.append ("%", ")
				Result.append (value.code)
				Result.append ("]")
			end
		end

	argument_code: STRING is
			-- | Result := "`value'" always
		do
			Result := value.code
		end

invariant
	non_void_value: value /= Void
	non_void_type: type /= Void

end -- class CODE_ATTRIBUTE_ARGUMENT

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