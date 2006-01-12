indexing
	description: "Roundtrip visitor to generate Eiffel code"
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
			process_separator_as,
			process_new_line_as,
			process_comment_as,
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
			process_break_as
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

	process_separator_as (l_as: SEPARATOR_AS) is
			-- Process `l_as'.
		do
			Precursor (l_as)
			put_string (l_as)
		end

	process_new_line_as (l_as: NEW_LINE_AS) is
			-- Process `l_as'.
		do
			Precursor (l_as)
			put_string (l_as)
		end

	process_comment_as (l_as: COMMENT_AS) is
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
			put_string (l_as)
		end

	process_real_as (l_as: REAL_AS) is
		do
			Precursor (l_as)
			put_string (l_as)
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

end

