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

create
	initialize

feature {NONE} -- Initialization

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

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_external_as (Current)
		end

feature -- Attributes

	language_name: EXTERNAL_LANG_AS
			-- Language name
			-- might be replaced by external_declaration or external_definition

	alias_name_id: INTEGER
			-- Alias name ID in NAMES_HEAP.

feature -- Location

	start_location: LOCATION_AS is
			-- Starting point for current construct.
		do
			Result := language_name.start_location
		end
		
	end_location: LOCATION_AS is
			-- Ending point for current construct.
		do
			Result := language_name.end_location
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

feature -- Conveniences

	type_check is
			-- Type checking
		do
			language_name.extension.type_check (Current)
		end

feature -- Byte code

	byte_node: BYTE_CODE is
			-- Byte code for external feature
		local
			extern: EXTERNAL_I
		do
			extern ?= context.current_feature
			if extern = Void then
				create {DEF_BYTE_CODE} Result
			else
				check
					extern_exists: context.current_feature /= Void
					is_extern: context.current_feature.is_external
				end
				create {EXT_BYTE_CODE} Result.make (extern.external_name_id)
			end
		end

invariant
	language_name_not_void: language_name /= Void

end -- class EXTERNAL_AS
