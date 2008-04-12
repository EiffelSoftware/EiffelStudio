indexing
	description: "[

	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	ES_CONTRACT_LINE

inherit
	ES_CONTRACT_SOURCE_I

create
	make,
	make_without_tag,
	make_from_string

feature {NONE} -- Initialization

	make (a_tag: !like tag; a_contract: !like contract; a_source: like source)
			-- Initializes a contract line
		require
			not_a_tag_is_empty: not a_tag.is_empty
			not_a_contract_is_empty: not a_contract.is_empty
		do
			tag := a_tag
			contract := a_contract
			source := a_source
		ensure
			tag_set: tag.is_equal (a_tag)
			contract_set: contract.is_equal (a_contract)
			source_set: source = a_source
		end

	make_without_tag (a_contract: !like contract; a_source: like source)
			-- Initializes a contract line
		require
			not_a_contract_is_empty: not a_contract.is_empty
		do
			make ("unnamed", a_contract, a_source)
		ensure
			contract_set: contract.is_equal (a_contract)
			source_set: source = a_source
		end

	make_from_string (a_string: STRING_GENERAL; a_source: like source)
			-- Creates a contract line from a string and attempts to infer the tag and contract from it.
		require
			not_a_string_is_empty: not a_string.is_empty
		local
			l_data: like split_contract_data
		do
			l_data := split_contract_data (a_string.as_string_8)
			if l_data.tag.is_empty then
				make_without_tag (l_data.contract, a_source)
			else
				make (l_data.tag, l_data.contract, a_source)
			end
		ensure
			source_set: source = a_source
		end

feature -- Access

	tag: !STRING
			-- Contract tag

	contract: !STRING assign set_contract
			-- Contract text

feature -- Access

	context: !ES_CONTRACT_EDITOR_CONTEXT [CLASSI_STONE]
			-- <Precursor>
		do
			Result := source.context
		end

	source: !ES_CONTRACT_SOURCE_I
			-- Parent source

feature -- Element change

	set_tag (a_tag: !like tag)
			-- Sets the cotract tag name.
			--
			-- `a_tag': The contract tag
		require
			not_a_tag_is_empty: not a_tag.is_empty
			is_editable: is_editable
		do
			tag := a_tag
		ensure
			tag_set: tag.is_equal (a_tag)
		end

	set_contract (a_contract: !like contract)
			-- Set the contract text
		require
			not_a_contract_is_empty: not a_contract.is_empty
			is_editable: is_editable
		do
			contract := a_contract
		ensure
			contract_set: contract.is_equal (a_contract)
		end

feature -- Status report

	is_editable: BOOLEAN
			-- <Precursor>
		do
			Result := source.is_editable
		end

feature {NONE} -- Basic operations

	split_contract_data (a_string: STRING): !TUPLE [tag: like tag; contract: like contract]
			--
		require
			a_string_attached: a_string /= Void
			not_a_string_is_empty: not a_string.is_empty
		local
			l_rx: like contract_tag_regex
			l_tag: !like tag
			l_contract: !like contract
		do
			l_rx := contract_tag_regex
			l_rx.match (a_string)
			if l_rx.has_matched then
				l_tag ?= l_rx.captured_substring (1)
				l_contract ?= a_string.substring (l_rx.captured_substring (0).count, a_string.count)
				Result := [l_tag, l_contract]
			end
		end

feature -- Output

	string: !STRING
			-- Retrieve a string representation of the contract line
		do
			create Result.make (75)
			Result.append (tag)
			Result.append (": ")
			Result.append (contract)
		ensure
			not_result_is_empty: not Result.is_empty
		end

feature {NONE} -- Regular expressions

	contract_tag_regex: !RX_PCRE_MATCHER
			-- Contract tag extraction regular expression
		once
			create Result.make
			Result.compile ("^[ \t]*([a-z][a-z0-9_]*)[ \t]*\:[ \t]*")
		ensure
			result_is_compiled: Result.is_compiled
		end

invariant
	not_tag_is_empty: not tag.is_empty
	not_contract_is_empty: not contract.is_empty

;indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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
