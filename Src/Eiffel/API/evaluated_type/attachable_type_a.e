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
			is_attached,
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

feature {NONE} -- Attachment properties

	attachment_bits: NATURAL_8
			-- Associated attachment flags

	has_detachable_mark_mask: NATURAL_8 is 1
			-- Mask in `attachment_bits' that tells whether the type has an explicit detachanble mark

	has_attached_mark_mask: NATURAL_8 is 2
			-- Mask in `attachment_bits' that tells whether the type has an explicit attached mark

	is_attached_mask: NATURAL_8 is 4;
			-- Mask in `attachment_bits' that tells whether the type is attached

indexing
	copyright:	"Copyright (c) 2007, Eiffel Software"
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
