indexing
	description: "Eiffel indexing clause"
	date: "$Date$"
	revision: "$Revision$"

class
	ECD_INDEXING_CLAUSE

inherit
	ECD_NAMED_ENTITY
		rename
			name as tag
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Call Precursor {ECD_NAMED_ENTITY}
		do
			default_create
			create text.make_empty
			create custom_attributes.make
		ensure then
			non_void_text: text /= Void
			non_void_custom_attribute: custom_attributes /= Void
		end		

feature -- Access

	text: STRING 
			-- Indexing clause text
			
	custom_attributes: LINKED_LIST [ECD_ATTRIBUTE_DECLARATION]
			-- List of custom attributes.

	code: STRING is
			-- Eiffel code of indexing clause
		do
			create Result.make (120)
			Result.append (tag)
			Result.append (Dictionary.Colon)
			Result.append (Dictionary.Space)
			Result.append (Dictionary.Inverted_comma)
			Result.append (text)
			Result.append (Dictionary.Inverted_comma)
			Result.append (Dictionary.New_line)
			Result.append (custom_attributes_code)
		end

feature -- Status Setting

	set_text (a_text: like text) is
			-- Set `text' with `a_text'.
		require
			non_void_text: a_text /= Void
		do
			text := a_text
		ensure
			text_set: text = a_text
		end

	add_custom_attribute (a_custom_attribute: ECD_ATTRIBUTE_DECLARATION) is
			-- Add `a_custom_attribute' to `custom_attributes.
		require
			non_void_a_custom_attribute: a_custom_attribute /= Void
		do
			custom_attributes.extend (a_custom_attribute)
		ensure
			a_custom_attribute_added: custom_attributes.has (a_custom_attribute)
		end

feature {NONE} -- Implementation

	custom_attributes_code: STRING is
			-- generate indexing, custom attributes.
		do
			create Result.make (200)
			if custom_attributes.count > 0 then
				increase_tabulation
				Result.append (indent_string)
				Result.append (Dictionary.Attribute_keyword)
				Result.append (Dictionary.Colon)
				Result.append (Dictionary.Space)
				from
					custom_attributes.start
				until
					custom_attributes.after
				loop
					Result.append (custom_attributes.item.code)
					custom_attributes.forth
					if not custom_attributes.after then
						Result.append (",")
						Result.append (Dictionary.New_line)
						Result.append (Dictionary.Tab)
						Result.append (Dictionary.Tab)
					end
				end
				decrease_tabulation
				Result.append (Dictionary.New_line)
			end
		ensure
			non_void_result: Result /= Void
		end
		
invariant
	non_void_text: text /= Void
	non_void_custom_attribute: custom_attributes /= Void
	
end -- class ECD_INDEXING_CLAUSE

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