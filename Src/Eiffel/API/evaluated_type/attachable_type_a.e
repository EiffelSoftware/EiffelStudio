indexing
	description: "Type that can be explicitly marked as attached or detachable"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class ATTACHABLE_TYPE_A

inherit
	TYPE_A
		redefine
			as_implicitly_attached,
			as_implicitly_detachable,
			is_attached,
			is_implicitly_attached,
			set_attached_mark,
			set_detachable_mark
		end

feature -- Status report

	has_attached_mark: BOOLEAN is
			-- Is type explicitly marked as attached?
		do
			Result := attachment_bits & has_attached_mark_mask /= 0
		end

	has_detachable_mark: BOOLEAN is
			-- Is type explicitly marked as attached?
		do
			Result := attachment_bits & has_detachable_mark_mask /= 0
		end

	is_attached: BOOLEAN is
			-- Is the type attached?
		do
			Result := (attachment_bits & is_attached_mask /= 0) or else is_expanded
		end

	is_attachable_to (other: ATTACHABLE_TYPE_A): BOOLEAN
			-- Does type preserve attachment status of other?
		do
			Result := other.is_attached implies is_implicitly_attached
		end

	is_implicitly_attached: BOOLEAN
			-- Is type (implicitly) attached?
		do
			Result := (attachment_bits & (is_attached_mask | is_implicitly_attached_mask) /= 0) or else is_expanded
		end

feature -- Modification

	set_attached_mark is
			-- Mark class type declaration as having an explicit attached mark.
		do
			attachment_bits := has_attached_mark_mask | is_attached_mask
		ensure then
			has_attached_mark: has_attached_mark
			is_attached: is_attached
		end

	set_detachable_mark is
			-- Set class type declaration as having an explicit detachable mark.
		do
			attachment_bits := has_detachable_mark_mask
		ensure then
			has_detachable_mark: has_detachable_mark
			not_is_attached: not is_expanded implies not is_attached
		end

	set_is_attached is
			-- Set attached type property.
		require
			not_has_detachable_mark: is_expanded or else not has_detachable_mark
		do
			attachment_bits := attachment_bits | is_attached_mask
		ensure
			is_attached: is_attached
		end

	set_is_implicitly_attached
			-- Mark type as being implicitly attached, so that
			-- it is allowed to be attached to an attached type.
		do
			attachment_bits := attachment_bits | is_implicitly_attached_mask
		ensure
			is_implicitly_attached: is_implicitly_attached
		end

	unset_is_implicitly_attached
			-- Mark type as being implicitly detachable, so that
			-- it is not allowed to be attached to an attached type.
		require
			not_is_attached: not is_attached
			is_implicitly_attached: is_implicitly_attached
		do
			attachment_bits := attachment_bits.bit_xor (is_implicitly_attached_mask)
		ensure
			not_is_implicitly_attached: not is_implicitly_attached
		end

feature -- Comparison

	has_same_attachment_marks (other: ATTACHABLE_TYPE_A): BOOLEAN
			-- Are attachment marks of `Current' and `other' the same?
		require
			other_attached: other /= Void
		do
			Result :=
				has_attached_mark = other.has_attached_mark and then
				has_detachable_mark = other.has_detachable_mark
		end

feature -- Duplication

	as_implicitly_attached: like Current
			-- Implicitly attached type
		do
			if is_implicitly_attached then
				Result := Current
			else
				Result := duplicate
				Result.set_is_implicitly_attached
			end
		ensure then
			result_is_implicitly_attached: Result.is_implicitly_attached
			result_is_attachable_to_attached: Result.is_attachable_to (as_attached)
		end

	as_implicitly_detachable: like Current
			-- Implicitly detachable type
		do
			if not is_attached and then is_implicitly_attached then
				Result := duplicate
				Result.unset_is_implicitly_attached
			else
				Result := Current
			end
		end

feature {NONE} -- Attachment properties

	attachment_bits: NATURAL_8
			-- Associated attachment flags

	has_detachable_mark_mask: NATURAL_8 is 1
			-- Mask in `attachment_bits' that tells whether the type has an explicit detachanble mark

	has_attached_mark_mask: NATURAL_8 is 2
			-- Mask in `attachment_bits' that tells whether the type has an explicit attached mark

	is_attached_mask: NATURAL_8 is 4
			-- Mask in `attachment_bits' that tells whether the type is attached

	is_implicitly_attached_mask: NATURAL_8 is 8;
			-- Mask in `attachment_bits' that tells whether the type is implicitly attached

indexing
	copyright:	"Copyright (c) 2007-2008, Eiffel Software"
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

end
