indexing
	description: "[
		Describes a single contract line - a tag and and Eiffel predicate.
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
			make (create {STRING_32}.make_filled ('-', 1), a_contract, a_source)
			tag.wipe_out
		ensure
			contract_set: contract.is_equal (a_contract)
			source_set: source = a_source
			is_tagless: is_tagless
		end

	make_from_string (a_string: !STRING_GENERAL; a_source: like source)
			-- Creates a contract line from a string and attempts to infer the tag and contract from it.
		require
			not_a_string_is_empty: not a_string.is_empty
		local
			l_data: like split_contract_data
		do
			l_data := split_contract_data (a_string)
			if {l_tag: !STRING_32} l_data.tag then
				make (l_tag, l_data.contract, a_source)
			else
				make_without_tag (l_data.contract, a_source)
			end
		ensure
			source_set: source = a_source
		end

feature -- Access

	tag: !STRING_32 assign set_tag
			-- Contract tag

	contract: !STRING_32 assign set_contract
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

	is_tagless: BOOLEAN
			-- Indicates if the contract is without a tag
		do
			Result := tag.is_empty
		end

feature {NONE} -- Basic operations

	split_contract_data (a_string: !STRING_GENERAL): !TUPLE [tag: ?like tag; contract: !like contract]
			-- Splits a contract string into a tag and contract.
			--
			-- `a_string': The contract string to split.
			-- `Result': The split tag and contract.
			--           'tag': A contract tag or Void if the contract has not tag.
			--           'contract': The contract predicate.
		require
			not_a_string_is_empty: not a_string.is_empty
		local
			l_rx: like contract_tag_regex
			l_tag: !like tag
			l_contract: !like contract
		do
			l_rx := contract_tag_regex
			l_rx.match (a_string.as_string_8)
			if l_rx.has_matched then
				create l_tag.make_from_string (l_rx.captured_substring (1))
				create l_contract.make_from_string (l_rx.captured_substring (2))
				if l_contract.is_empty then
					create l_contract.make_from_string (a_string.substring (l_rx.captured_substring (1).count, a_string.count))
				end
				Result := [l_tag, l_contract]
			else
				Result := [Void, ({!STRING_32}) #? a_string.as_string_32]
			end
		ensure
			not_result_tag_is_empty: Result.tag /= Void implies not Result.tag.is_empty
			not_result_contract_is_empty: not Result.contract.is_empty
		end

feature -- Output

	string: !STRING_32
			-- Retrieve a string representation of the contract line
		do
			create Result.make (75)
			if not is_tagless then
				Result.append (tag)
				Result.append (": ")
			end
			Result.append (contract)
		ensure
			not_result_is_empty: not Result.is_empty
		end

feature {NONE} -- Regular expressions

	contract_tag_regex: !RX_PCRE_MATCHER
			-- Contract tag extraction regular expression.
		once
			create Result.make
			Result.set_caseless (True)
			Result.compile ("^[ \t]*([a-z][a-z0-9_]*)[ \t]*\:[ \t]*(.*)[ \t]*$")
		ensure
			result_is_compiled: Result.is_compiled
		end

invariant
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
