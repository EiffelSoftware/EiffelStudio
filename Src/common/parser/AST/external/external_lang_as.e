indexing
	description: "AST representation of an external structure."
	date: "$Date$"
	revision: "$Revision$"

class
	EXTERNAL_LANG_AS

inherit
	AST_EIFFEL
		redefine
			is_equivalent, location
		end
	EXTERNAL_CONSTANTS

feature {AST_FACTORY} -- Initialization

	initialize (l: like language_name; loc: like location) is
			-- Create a new EXTERNAL_LANGUAGE AST node.
		require
			l_not_void: l /= Void
		do
			language_name := l
			location := loc
			parse
		ensure
			language_name_set: language_name = l
			location_set: location = loc
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_external_lang_as (Current)
		end

feature -- Attributes

	language_name: STRING_AS;
			-- Language name
			-- might be replaced by external_declaration or external_definition

	location: TOKEN_LOCATION
			-- Location of AST

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
				-- FIXME: is_equivalent should be done on EXTERNAL_EXTENSION_AS
			Result := language_name.is_equivalent (other.language_name)
		end

feature {NONE} -- Implementation

	parse is
			-- Parse external declaration
		do
			-- do nothing
		end
		
end -- class EXTERNAL_LANG_AS
