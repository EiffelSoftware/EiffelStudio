indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EXTERNAL_TYPE_AS

inherit
	ANY

	SHARED_NAMES_HEAP
		export
			{NONE} all
		end

feature {EXTERNAL_FACTORY} -- Initialization

	initialize (id: ID_AS; is_struct: BOOLEAN; nb_pointer: INTEGER; is_byref: BOOLEAN) is
			-- Create EXTERNAL_TYPE_AS node
		require
			id_not_void: id /= Void
		local
			l, i: INTEGER
			value: STRING
		do
			l := id.count
			if is_struct then
				l := l + struct_text_length
			end

			l := l + nb_pointer

			create value.make (l)
			if is_struct then
				value.append (struct_text)
			end
			value.append (id)
			if nb_pointer > 0 then
				from
					i := 1
				until
					i > nb_pointer
				loop
					value.append_character (star_text)
					i := i + 1
				end
			end

			if is_byref then
				value.append_character (byref_text)
			end

			Names_heap.put (value)
			value_id := Names_heap.found_item
		ensure
			value_id_set: value_id > 0
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			--v.process_external_type_as (Current)
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class EXTERNAL_TYPE_AS
