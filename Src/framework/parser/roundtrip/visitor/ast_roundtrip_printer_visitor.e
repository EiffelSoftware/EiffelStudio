indexing
	description: "Roundtrip visitor to generate Eiffel code"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	AST_ROUNDTRIP_PRINTER_VISITOR

inherit
	AST_ROUNDTRIP_ITERATOR
		redefine
			process_keyword_as,
			process_symbol_as,
			process_bool_as,
			process_char_as,
			process_typed_char_as,
			process_result_as,
			process_retry_as,
			process_unique_as,
			process_deferred_as,
			process_void_as,
			process_string_as,
			process_verbatim_string_as,
			process_current_as,
			process_integer_as,
			process_real_as,
			process_id_as,
			process_break_as,
			process_symbol_stub_as,
			reset
		end
create
	make,
	make_with_default_context

feature {NONE} -- Initialization

	make (a_ctxt: ROUNDTRIP_CONTEXT)  is
			-- Initialize and set `context' with `a_ctxt'.
		require
			a_ctxt_not_void: a_ctxt /= Void
		do
			context := a_ctxt
		end

	make_with_default_context is
			-- Initialize and create context of type `ROUNDTRIP_STRING_LIST_CONTEXT'.
		do
			make (create {ROUNDTRIP_STRING_LIST_CONTEXT}.make)
		end

feature -- Context setting

	set_context (a_ctxt: ROUNDTRIP_CONTEXT) is
			-- Set `context' with `a_ctxt'.
		require
			a_ctxt_not_void: a_ctxt /= Void
		do
			context := a_ctxt
		ensure
			context_set: context = a_ctxt
		end

	reset is
			-- Reset visitor for a next visit.
		do
			Precursor
			context.clear
		end

feature -- Roundtrip: process leaf

	process_break_as (l_as: BREAK_AS) is
			-- Process `l_as'.
		do
			Precursor (l_as)
			put_string (l_as)
		end

	process_keyword_as (l_as: KEYWORD_AS) is
			-- Process `l_as'.
		do
			Precursor (l_as)
			put_string (l_as)
		end

	process_symbol_as (l_as: SYMBOL_AS) is
			-- Process `l_as'.
		do
			Precursor (l_as)
			put_string (l_as)
		end

	process_symbol_stub_as (l_as: SYMBOL_STUB_AS) is
			-- Process `l_as'.
		do
			Precursor (l_as)
			put_string (l_as)
		end

	process_bool_as (l_as: BOOL_AS) is
		do
			Precursor (l_as)
			put_string (l_as)
		end

	process_char_as (l_as: CHAR_AS) is
		do
			Precursor (l_as)
			put_string (l_as)
		end

	process_typed_char_as (l_as: TYPED_CHAR_AS) is
			-- Process `l_as'.
		do
			Precursor (l_as)
			put_string (l_as)
		end

	process_result_as (l_as: RESULT_AS) is
		do
			Precursor (l_as)
			put_string (l_as)
		end

	process_retry_as (l_as: RETRY_AS) is
		do
			Precursor (l_as)
			put_string (l_as)
		end

	process_unique_as (l_as: UNIQUE_AS) is
		do
			Precursor (l_as)
			put_string (l_as)
		end

	process_deferred_as (l_as: DEFERRED_AS) is
		do
			Precursor (l_as)
			put_string (l_as)
		end

	process_void_as (l_as: VOID_AS) is
		do
			Precursor (l_as)
			put_string (l_as)
		end

	process_string_as (l_as: STRING_AS) is
		do
			Precursor (l_as)
			put_string (l_as)
		end

	process_verbatim_string_as (l_as: VERBATIM_STRING_AS) is
		do
			Precursor (l_as)
			put_string (l_as)
		end

	process_current_as (l_as: CURRENT_AS) is
		do
			Precursor (l_as)
			put_string (l_as)
		end

	process_integer_as (l_as: INTEGER_AS) is
		do
			Precursor (l_as)
			context.add_string (l_as.number_text (match_list))
		end

	process_real_as (l_as: REAL_AS) is
		do
			Precursor (l_as)
			context.add_string (l_as.number_text (match_list))
		end

	process_id_as (l_as: ID_AS) is
		do
			Precursor (l_as)
			put_string (l_as)
		end

feature

	text: STRING is
			-- Generated Eiffel code
		do
			Result := context.string_representation
		end

feature{NONE} -- Implementation

	context: ROUNDTRIP_CONTEXT
			-- Context used to store generated code

	put_string (l_as: LEAF_AS) is
			-- Print text contained in `l_as' into `context'.
		require
			l_as_in_list: l_as.index >= start_index and then l_as.index <= end_index
		do
			context.add_string (l_as.text (match_list))
		end

invariant
	context_not_void: context /= Void

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

end

