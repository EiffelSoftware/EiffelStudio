indexing
	description: "AST representation of a external C routine."
	date: "$Date$"
	revision: "$Revision$"

class EXTERNAL_AS

inherit
	ROUT_BODY_AS
		redefine
			byte_node, type_check, is_external
		end

	EXTERNAL_CONSTANTS

	SHARED_NAMES_HEAP
		export
			{NONE} all
		end

feature {AST_FACTORY} -- Initialization

	initialize (l: like language_name; a: STRING_AS) is
			-- Create a new EXTERNAL AST node.
		require
			l_not_void: l /= Void
		do
			language_name := l
			if a /= Void then
				Names_heap.put (a.value)
				alias_name_id := Names_heap.found_item
			end
		ensure
			language_name_set: language_name = l
		end

feature -- Attributes

	language_name: EXTERNAL_LANG_AS
			-- Language name
			-- might be replaced by external_declaration or external_definition

	alias_name_id: INTEGER
			-- Alias name ID in NAMES_HEAP.

feature -- Properties

	is_external: BOOLEAN is True
			-- Is the current routine body an external one ?

	external_name: STRING is
			-- Alias name: Void if none
		do
			if alias_name_id > 0 then
				Result := Names_heap.item (alias_name_id)
			end
		end; -- external_name

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := alias_name_id = other.alias_name_id and then
				equivalent (language_name, other.language_name)
		end

end -- class EXTERNAL_AS
