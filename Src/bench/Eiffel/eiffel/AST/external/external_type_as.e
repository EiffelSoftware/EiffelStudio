indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EXTERNAL_TYPE_AS

inherit
	AST_EIFFEL
	
	SHARED_NAMES_HEAP
		export
			{NONE} all
		end

feature {EXTERNAL_FACTORY} -- Initialization

	initialize (id: ID_AS; is_struct, is_pointer, is_byref, is_enum: BOOLEAN) is
			-- Create EXTERNAL_TYPE_AS node
		require
			id_not_void: id /= Void
		local
			l: INTEGER
			value: STRING
		do
			l := id.count
			if is_struct then
				l := l + struct_text_length
			end
			if is_pointer then
					-- `1' is `star_text' length
				l := l + 1
			end

			create value.make (l)
			if is_struct then
				value.append (struct_text)
			end
			value.append (id)
			if is_pointer then
				value.append_character (star_text)
			end

			if is_byref then
				value.append_character (byref_text)
			end

			Names_heap.put (value)
			value_id := Names_heap.found_item
		end

feature -- Access

	value_id: INTEGER
			-- String ID in NAMES_HEAP value of EXTERNAL_TYPE_AS

feature {NONE} -- Constants

	struct_text: STRING is "struct "
			-- Representation of the `stuct' string.

	struct_text_length: INTEGER is 7
			-- Length of `struct_text'.

	star_text: CHARACTER is '*'
			-- Representation of the `*' character.

	byref_text: CHARACTER is '&'
			-- Representation of the `&' character.

feature {NONE} -- Not exported because should never be used.

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to `Current'?
			-- Not valid in current context
		do
			check
				False
			end
		end
	
	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconsitute text according to context.
			-- Not valid in current context
		do
			check
				False
			end
		end

end -- class EXTERNAL_TYPE_AS
