indexing 
	description: "Eiffel attribute"
	date: "$$"
	revision: "$$"	

class
	ECDP_ATTRIBUTE

inherit
	ECDP_FEATURE
		redefine
			set_name,
			make,
			ready
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- | Call Precursor {ECDP_FEATURE}.
		do
			Precursor {ECDP_FEATURE}
		end

feature -- Access

	type: STRING
			-- type of attribute

	is_array_type: BOOLEAN
			-- Is returned_type a NATIVE_ARRAY?

	code: STRING is
			-- | call 'generated_attribute' then 'generated_comments'
			-- | Result := "feature [{exports,...}] -- feature_type
			-- |				`attribute_name': `type'
			-- |					[-- comments ..."]
			
			-- Eiffel code of attribute
		do
			check
				non_void_type: type /= Void
				not_empty_type: not type.is_empty
			end
			
			create Result.make (100)
			add_tab_to_indent_string
			Result.append (attribute_code)
			
			if comments /= void and then comments.count > 0 then
				Result.append (comments_code)
			end
			sub_tab_to_indent_string
			Result.append (Dictionary.New_line)
		end
		
feature -- Status Report

	ready: BOOLEAN is
			-- Is attribute ready to be generated?
		do
			Result := Precursor {ECDP_FEATURE}
		end

feature -- Status Setting

	set_name (a_name: like name) is
			-- Set `name' with `a_name'.
		do
			name := a_name
		end

	set_type (a_type: like type) is
			-- Set `type' with `a_type'.
		require
			non_void_type: a_type /= Void
			not_empty_type: not a_type.is_empty
		do
			type := a_type
		ensure
			type_set: type = a_type
		end

	set_is_array_type (a_bool: like is_array_type) is
			-- Set `is_array_type' with `a_bool'.
		do
			is_array_type := a_bool
		ensure
			is_array_type_set: is_array_type = a_bool
		end

feature -- Code Generation

	attribute_code: STRING is
			-- | Result := "`attribute_name': `TYPE'"
			-- | Call `format_name' if name not formatted
		require
			not_void_name: name /= void
			not_void_type: type /= void
		local
			returned_type_name: STRING
		do
			check 
				not_empty_attribute_name: not name.is_empty
				not_empty_attribute_type: not type.is_empty
			end
			
			create Result.make (120)
			Result.append (indent_string)
			Result.append (Resolver.eiffel_entity_name (name))
			Result.append (Dictionary.Colon)
			Result.append (Dictionary.Space)
			returned_type_name := Resolver.eiffel_type_name (type)
			if is_array_type then
				Result.append ("NATIVE_ARRAY [")
				Result.append (returned_type_name)
				Result.append ("]")
			else
				Result.append (returned_type_name)
			end
			Result.append (Dictionary.New_line)
		ensure
			not_void_result: Result /= void
			not_empty_result: not Result.is_empty
		end
		
end -- class ECDP_ATTRIBUTE

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