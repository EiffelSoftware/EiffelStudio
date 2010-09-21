note
	description: "Type that can be explicitly marked as attached or detachable"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class ATTACHABLE_TYPE_A

inherit
	TYPE_A
		redefine
			as_attached_type,
			as_attachment_mark_free,
			as_detachable_type,
			as_implicitly_attached,
			as_implicitly_detachable,
			as_marks_free,
			is_attached,
			is_implicitly_attached,
			is_separate,
			to_other_attachment,
			to_other_immediate_attachment,
			to_other_separateness
		end

feature -- Status report

	has_attached_mark: BOOLEAN
			-- Is type explicitly marked as attached?
		do
			Result := attachment_bits & has_attached_mark_mask /= 0
		end

	has_detachable_mark: BOOLEAN
			-- Is type explicitly marked as attached?
		do
			Result := attachment_bits & has_detachable_mark_mask /= 0
		end

	is_attached: BOOLEAN
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
			Result := (attachment_bits & (is_attached_mask | is_implicitly_attached_mask) /= {NATURAL_8} 0) or else is_expanded
		end

	has_separate_mark: BOOLEAN
			-- Is type explicitly marked as separate?

	is_separate: BOOLEAN
			-- <Precursor>
		do
			Result := has_separate_mark and then not is_expanded
		end

feature -- Modification

	set_attached_mark
			-- Mark type declaration as having an explicit attached mark.
		do
			attachment_bits := has_attached_mark_mask | is_attached_mask
		ensure then
			has_attached_mark: has_attached_mark
			is_attached: is_attached
		end

	set_detachable_mark
			-- Mark type declaration as having an explicit detachable mark.
		do
			attachment_bits := has_detachable_mark_mask
		ensure then
			has_detachable_mark: has_detachable_mark
			not_is_attached: not is_expanded implies not is_attached
		end

	set_is_attached
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

	set_separate_mark
			-- Mark type declaration as having an explicit separate mark.
		do
			has_separate_mark := True
		end

	reset_separate_mark
			-- Mark type declaration as having no separate mark.
		do
			has_separate_mark := False
		end

	set_marks_from (other: ATTACHABLE_TYPE_A)
			-- Set attachment marks as they are set in `other'.
		require
			other_attached: attached other
		do
			if other.has_attached_mark then
				set_attached_mark
			elseif other.has_detachable_mark then
				set_detachable_mark
			end
			if other.has_separate_mark then
				set_separate_mark
			end
		end

feature -- Comparison

	has_same_marks (other: ATTACHABLE_TYPE_A): BOOLEAN
			-- Are type marks of `Current' and `other' the same?
		require
			other_attached: other /= Void
		do
			Result :=
				has_attached_mark = other.has_attached_mark and then
				has_detachable_mark = other.has_detachable_mark and then
				has_separate_mark = other.has_separate_mark
		end

feature -- Duplication

	as_attached_type: like Current
			-- Attached variant of the current type
		do
			Result := duplicate
			Result.set_attached_mark
		end

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
			result_is_attachable_to_attached: Result.is_attachable_to (as_attached_type)
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

	as_detachable_type: like Current
			-- detachable type
		do
			if not has_detachable_mark then
				Result := duplicate
				Result.set_detachable_mark
			else
				Result := Current
			end
		end

	as_attachment_mark_free: like Current
			-- Same as Current but without any attachment mark
		local
			l_bits: like attachment_bits
		do
			l_bits := attachment_bits
			if l_bits = 0 then
				Result := Current
			else
				attachment_bits := 0
				Result := duplicate
				attachment_bits := l_bits
			end
		ensure then
			result_has_no_attached_mark: not Result.has_attached_mark
			result_has_no_detachable_mark: not Result.has_detachable_mark
		end

	as_marks_free: like Current
			-- Same as Current but without any attachment and separate marks
		local
			a: like attachment_bits
			s: BOOLEAN
		do
			a := attachment_bits
			s := has_separate_mark
			if a = 0 and then not s then
				Result := Current
			else
				has_separate_mark := False
				attachment_bits := 0
				Result := duplicate
				attachment_bits := a
				has_separate_mark := s
			end
		ensure then
			result_has_no_attached_mark: not Result.has_attached_mark
			result_has_no_detachable_mark: not Result.has_detachable_mark
			result_has_no_separate_mark: not Result.has_separate_mark
		end

	to_other_attachment (other: ATTACHABLE_TYPE_A): like Current
			-- Current type to which attachment status of `other' is applied
		local
			c: TYPE_A
			o: ATTACHABLE_TYPE_A
		do
			Result := Current
			if other /= Result then
				if other.is_like_current then
					c := other.conformance_type
				else
					c := other.actual_type
				end
				if c /= Void and then c /= Result and then attached {ATTACHABLE_TYPE_A} c as t then
						-- Apply attachment settings of anchor if applicable and current type has none.
					o := t
				else
					o := other
				end
				Result := to_other_immediate_attachment (o)
			end
		end

	to_other_immediate_attachment (other: ATTACHABLE_TYPE_A): like Current
			-- Current type to which attachment status of `other' is applied
			-- without taking into consideration attachment status of an anchor (if any)
		do
			Result := Current
			if other.has_attached_mark then
				if not has_attached_mark then
					Result := duplicate
					Result.set_attached_mark
				end
			elseif other.is_implicitly_attached then
				if not is_attached and then not is_implicitly_attached then
					Result := as_implicitly_attached
				end
			elseif other.has_detachable_mark then
				if not is_expanded and then not has_detachable_mark then
					Result := duplicate
					Result.set_detachable_mark
				end
			elseif not other.is_implicitly_attached and then is_implicitly_attached then
				Result := as_implicitly_detachable
			end
		end

	to_other_separateness (other: ATTACHABLE_TYPE_A): like Current
			-- Current type to which attachment status of `other' is applied
		do
			Result := Current
			if other /= Result then
				if not other.is_separate then
					if is_separate then
						Result := as_non_separate
					end
				elseif other.has_separate_mark then
					if not is_expanded and then not has_separate_mark then
						Result := duplicate
						Result.set_separate_mark
					end
				elseif not is_separate then
					Result := as_separate
				end
			end
		end

	as_separate: like Current
			-- Separate version of this type
		require
			not_separate: not is_separate
		do
			Result := duplicate
			Result.set_separate_mark
		end

	as_non_separate: like Current
			-- Non-separate version of this type
		require
			is_separate: is_separate
		do
			Result := duplicate
			Result.reset_separate_mark
		end

feature {NONE} -- Attachment properties

	attachment_bits: NATURAL_8
			-- Associated attachment flags

	has_detachable_mark_mask: NATURAL_8 = 1
			-- Mask in `attachment_bits' that tells whether the type has an explicit detachable mark

	has_attached_mark_mask: NATURAL_8 = 2
			-- Mask in `attachment_bits' that tells whether the type has an explicit attached mark

	is_attached_mask: NATURAL_8 = 4
			-- Mask in `attachment_bits' that tells whether the type is attached

	is_implicitly_attached_mask: NATURAL_8 = 8
			-- Mask in `attachment_bits' that tells whether the type is implicitly attached

feature {NONE} -- Output

	dump_marks (s: STRING)
			-- Append leading type marks to `s'.
		require
			s_attached: attached s
		do
			if has_attached_mark then
				s.append_character ('!')
			elseif has_detachable_mark then
				s.append_character ('?')
			end
			if has_separate_mark then
				s.append ({SHARED_TEXT_ITEMS}.ti_separate_keyword)
				s.append_character (' ')
			end
		end

	ext_append_marks (f: TEXT_FORMATTER)
			-- Append leading type marks using formatter `t'.
		require
			f_attached: attached f
		do
			if has_attached_mark then
				f.process_keyword_text ({SHARED_TEXT_ITEMS}.ti_attached_keyword, Void)
				f.add_space
			elseif has_detachable_mark then
				f.process_keyword_text ({SHARED_TEXT_ITEMS}.ti_detachable_keyword, Void)
				f.add_space
			end
			if has_separate_mark then
				f.process_keyword_text ({SHARED_TEXT_ITEMS}.ti_separate_keyword, Void)
				f.add_space
			end
		end

invariant
	expanded_consistency: is_expanded implies not is_separate
	separate_mark_consistency: not is_expanded implies (has_separate_mark implies is_separate)

note
	copyright:	"Copyright (c) 1984-2010, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
