indexing
	description: "Document Schema attribute."
	date: "$Date$"
	revision: "$Revision$"

class
	DOCUMENT_SCHEMA_ATTRIBUTE

create
	make

feature -- Creation

	make (a_name: STRING; a_parent: DOCUMENT_SCHEMA_ELEMENT) is
			-- Make with 'a_name' and 'a_parent'
		require
			parent_not_void: a_parent /= Void
			name_not_void: a_parent /= Void
		do
			name := a_name
			parent := a_parent
		end	
	
feature -- Status Setting

	set_use (a_use: XML_XML_SCHEMA_USE) is
			-- Set `use' value
		require
			use_not_void: a_use /= Void
		do
			use := a_use
		end	
		
	set_default_value (a_default_value: STRING) is
			-- Set `default value'
		require
			value_not_void: a_default_value /= Void
		do
			default_value := a_default_value
		end	
	
feature -- Access

	name: STRING
			-- Name
			
	parent: DOCUMENT_SCHEMA_ELEMENT
			-- Parent
			
	default_value: STRING
			-- Default value
			
	required: BOOLEAN is
			-- Required?
		do
			Result := use.to_integer = feature {XML_XML_SCHEMA_USE}.required.to_integer
		end		
	
	prohibited: BOOLEAN is
			-- Prohibited?
		do
			Result := use.to_integer = feature {XML_XML_SCHEMA_USE}.prohibited.to_integer
		end

	optional: BOOLEAN is
			-- Optional?
		do
			Result := use.to_integer = feature {XML_XML_SCHEMA_USE}.optional.to_integer
		end

feature {NONE} -- Implementation

	use: XML_XML_SCHEMA_USE
			-- Usage
			
end -- class DOCUMENT_SCHEMA_ATTRIBUTE
