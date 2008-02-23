indexing
	description: "Representation of a signature"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	MD_SIGNATURE

feature {NONE} -- Initialization

	make is
			-- Allocated `item'.
		do
			create item.make (Default_size)
			current_position := 0
		end

feature -- Access

	count: INTEGER is
			-- Size of structure once emitted.
		do
			Result := current_position
		end

	item: MANAGED_POINTER
			-- C structures that holds signature.

feature -- Settings

	set_byref_type (element_type: INTEGER_8; a_token: INTEGER) is
			-- Set type as a byref type in current signature.
		require
			token_valid: (element_type = {MD_SIGNATURE_CONSTANTS}.Element_type_class or
				element_type = {MD_SIGNATURE_CONSTANTS}.Element_type_valuetype) implies
				a_token /= 0
		do
			internal_put ({MD_SIGNATURE_CONSTANTS}.Element_type_byref, current_position)
			current_position := current_position + 1
			set_type (element_type, a_token)
		end

	set_type (element_type: INTEGER_8; token: INTEGER) is
			-- Set type in current signature.
		require
			token_valid: (element_type = {MD_SIGNATURE_CONSTANTS}.Element_type_class or
				element_type = {MD_SIGNATURE_CONSTANTS}.Element_type_valuetype) implies
				token /= 0
		do
			internal_put (element_type, current_position)
			current_position := current_position + 1
			inspect
				element_type
			when
				{MD_SIGNATURE_CONSTANTS}.Element_type_class,
				{MD_SIGNATURE_CONSTANTS}.Element_type_valuetype
			then
				compress_type_token (token)
			else
			end
		end

feature -- Copy

	as_special: SPECIAL [NATURAL_8] is
			-- Copy of Current as SPECIAL.
		local
			i, nb: INTEGER
		do
			from
				i := 0
				nb := current_position
				create Result.make (nb)
			until
				i = nb
			loop
				Result.put (item.read_natural_8 (i), i)
				i := i + 1
			end
		ensure
			as_special_not_void: Result /= Void
			same_count: Result.count = current_position
		end

feature {NONE} -- Implementation

	compress_data (i: INTEGER) is
			-- Compress `i' using Partition II 22.2 specification
			-- and store it at currrent_position in current.
		require
			valid_i: i <= 0x1FFFFFFF
		local
			l_pos, l_incr: INTEGER
			l_val: INTEGER
		do
			l_pos := current_position

			if i <= 0x7F then
					-- Simply copy first byte.
				internal_put (i.to_integer_8, l_pos)
				l_incr := 1;
			elseif i <= 0x3FFF then
					-- Copy two bytes added with 0x00008000.
				l_val := i + 0x00008000
				internal_put (((l_val & 0x0000FF00) |>> 8).to_integer_8, l_pos)
				internal_put ((l_val & 0x000000FF).to_integer_8, l_pos + 1)
				l_incr := 2
			else
					-- Copy four bytes added with 0xC0000000
				l_val := i + 0xC0000000
				internal_put (((l_val & 0xFF000000) |>> 24).to_integer_8, l_pos)
				internal_put (((l_val & 0x00FF0000) |>> 16).to_integer_8, l_pos + 1)
				internal_put (((l_val & 0x0000FF00) |>> 8).to_integer_8, l_pos + 2)
				internal_put ((l_val & 0x000000FF).to_integer_8, l_pos + 3)
				l_incr := 4
			end
			current_position := l_pos + l_incr
		end

	compress_type_token (i: INTEGER) is
			-- Compress token `i' using Partition II 22.2.8 specification
			-- and store it at current_position in current.
		local
			l_header: INTEGER
			l_val: INTEGER
			l_encoding: INTEGER
		do
			l_header := i & 0xFF000000
			l_val := i & 0x00FFFFFF

			if l_header = {MD_TOKEN_TYPES}.Md_type_ref then
					-- TypeRef token
				l_encoding := 1
			elseif l_header = {MD_TOKEN_TYPES}.Md_type_def then
					-- TypeDef token
				l_encoding := 0
			elseif l_header = {MD_TOKEN_TYPES}.Md_type_spec then
					-- TypeSpec token
				l_encoding := 2
			else
				check
					error: False
				end
			end

			l_val := (l_val |<< 2) | l_encoding

			compress_data (l_val)
		end

	internal_put (val: INTEGER_8; pos: INTEGER) is
			-- Safe insertion that will resize `internal_body' if needed.
		require
			valid_pos: pos >= 0
		do
			allocate (pos + 1)
			item.put_integer_8 (val, pos)
		end

feature {NONE} -- Internal signature

	current_position: INTEGER
			-- Current position in `internal_body' for next insertion.

	default_size: INTEGER is 20
			-- Default allocated size for a signature.

feature {NONE} -- Stack depth management

	allocate (new_size: INTEGER) is
			-- Resize `item' if needed so that it can accomdate `new_size'.
		local
			l_capacity: INTEGER
		do
			l_capacity := item.count
			if new_size > l_capacity then
				item.resize (new_size.max (l_capacity + Default_size))
			end
		ensure
			enough_size: item.count >= new_size
		end

invariant
	item_not_void: item /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class MD_SIGNATURE
