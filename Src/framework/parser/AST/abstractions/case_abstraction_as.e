note
	description: "Abstract description of an alternative of a multi_branch construct."

deferred class CASE_ABSTRACTION_AS [P -> detachable AST_EIFFEL]

inherit
	AST_EIFFEL

feature {NONE} -- Initialization

	make (i: like interval; c: like content; w, t: detachable KEYWORD_AS)
			-- Create a new WHEN AST node with interval `i` content `c`
			-- and keywords `w` for "when" and `t` for "then".
		require
			i_attached: i /= Void
		do
			interval := i
			content := c
			if attached w then
				when_keyword_index := w.index
			end
			if attached t then
				then_keyword_index := t.index
			end
		ensure
			interval_set: interval = i
			content_set: content = c
			when_keyword_set: w /= Void implies when_keyword_index = w.index
			then_keyword_set: t /= Void implies then_keyword_index = t.index
		end

feature -- Roundtrip

	when_keyword_index, then_keyword_index: INTEGER
			-- Index of keyword "when" and "then" associated with this structure.

	when_keyword (l: LEAF_AS_LIST): detachable KEYWORD_AS
			-- Keyword "when" associated with this structure.
		require
			l_attached: attached l
		do
			Result := keyword_from_index (l, when_keyword_index)
		end

	then_keyword (l: LEAF_AS_LIST): detachable KEYWORD_AS
			-- Keyword "then" ssociated with this structure.
		require
			l_attached: attached l
		do
			Result := keyword_from_index (l, then_keyword_index)
		end

	index: INTEGER
			-- <Precursor>
		do
			Result := when_keyword_index
		end

feature -- Access

	interval: EIFFEL_LIST [INTERVAL_AS]
			-- Interval of the alternative.

	content: P
			-- Content.

feature -- Roundtrip/Token

	first_token (l: detachable LEAF_AS_LIST): detachable LEAF_AS
			-- <Precursor>
		do
			if attached l and when_keyword_index /= 0 then
				Result := when_keyword (l)
			else
				Result := interval.first_token (l)
			end
		end

	last_token (l: detachable LEAF_AS_LIST): detachable LEAF_AS
			-- <Precursor>
		do
			if attached content as c then
				Result := c.last_token (l)
			elseif attached l and then_keyword_index /= 0 then
				Result := then_keyword (l)
			else
				Result := interval.last_token (l)
			end
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN
			-- Is `other' equivalent to the current object?
		do
			Result :=
				equivalent (content, other.content) and
				equivalent (interval, other.interval)
		end

feature {CASE_ABSTRACTION_AS} -- Replication

	set_interval (i: like interval)
			-- Set `interval` to `i`.
		require
			i_attached: attached i
		do
			interval := i
		end

	set_content (c: like content)
			-- Set `content` to `c`.
		do
			content := c
		ensure
			content_set: content = c
		end

invariant
	interval_attached: attached interval

note
	date: "$Date$"
	revision: "$Revision$"
	author: "Alexander Kogtenkov"
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
