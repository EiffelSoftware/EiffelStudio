indexing
	description: "AST representation of a external C routine."
	date: "$Date$"
	revision: "$Revision$"

class EXTERNAL_AS

inherit
	ROUT_BODY_AS
		redefine
			is_external
		end

	SHARED_NAMES_HEAP
		export
			{NONE} all
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (l: like language_name; a: STRING_AS; e_as, a_as: KEYWORD_AS) is
			-- Create a new EXTERNAL AST node.
		require
			l_not_void: l /= Void
		do
			language_name := l
			if a /= Void then
				Names_heap.put (a.value)
				alias_name_id := Names_heap.found_item
			end
			external_keyword := e_as
			alias_keyword := a_as
			alias_name_literal := a
		ensure
			language_name_set: language_name = l
			alias_keyword_set: alias_keyword = a_as
			external_keyword_set: external_keyword = e_as
			alias_name_literal_set: alias_name_literal = a
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_external_as (Current)
		end

feature -- Roundtrip

	alias_keyword: KEYWORD_AS
			-- keyword "alias" associated with this class

	external_keyword: KEYWORD_AS
			-- keyword "external" associated with this class

	alias_name_literal: STRING_AS
			-- String literal of alias name in this structure


feature -- Attributes

	language_name: EXTERNAL_LANG_AS
			-- Language name
			-- might be replaced by external_declaration or external_definition

	alias_name_id: INTEGER
			-- Alias name ID in NAMES_HEAP.

feature -- Roundtrip/Location

	complete_start_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			if a_list = Void then
				Result := language_name.complete_start_location (a_list)
			else
				Result := external_keyword.complete_start_location (a_list)
			end
		end

	complete_end_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			if a_list = Void then
				Result := language_name.complete_end_location (a_list)
			else
				if alias_name_literal /= Void then
					Result := alias_name_literal.complete_end_location (a_list)
				else
					Result := language_name.complete_end_location (a_list)
				end
			end
		end

feature -- Properties

	is_external: BOOLEAN is True
			-- Is the current routine body an external one ?

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := alias_name_id = other.alias_name_id and then
				equivalent (language_name, other.language_name)
		end

invariant
	language_name_not_void: language_name /= Void

end -- class EXTERNAL_AS
