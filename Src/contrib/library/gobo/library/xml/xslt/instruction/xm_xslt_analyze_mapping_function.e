note

	description: "Objects that map sequences of matching and non-matching strings to the results of xsl:matching-substring and xsl:non-matching-substring children of xsl:analyze-string"

	library: "Gobo Eiffel XSLT Library"
	copyright: "Copyright (c) 2007, Colin Adams and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class XM_XSLT_ANALYZE_MAPPING_FUNCTION

inherit

	XM_XPATH_CONTEXT_MAPPING_FUNCTION

create

	make

feature {NONE} -- Initialization

	make (a_base: XM_XSLT_REGEXP_ITERATOR; a_context: XM_XSLT_EVALUATION_CONTEXT; a_matching, a_non_matching: XM_XPATH_EXPRESSION)
			-- Initialize `Current'.
		require
			a_base_not_void: a_base /= Void
			a_base_before: a_base.before
			a_context_not_void: a_context /= Void
		do
			base_iterator := a_base
			context := a_context
			matching_block := a_matching
			non_matching_block := a_non_matching
		ensure
			base_iterator_set: base_iterator = a_base
			context_set: context = a_context
			matching_block_set: matching_block = a_matching
			non_matching_block_set: non_matching_block = a_non_matching
		end

feature -- Evaluation

	map (a_context: XM_XPATH_CONTEXT)
			-- Map `a_context.context_item' to a sequence
		do
			if base_iterator.is_matching and matching_block /= Void then
				matching_block.create_iterator (context)
				last_mapped_sequence := matching_block.last_iterator
			elseif not  base_iterator.is_matching and non_matching_block /= Void then
				non_matching_block.create_iterator (context)
				last_mapped_sequence := non_matching_block.last_iterator
			else
				create {XM_XPATH_EMPTY_ITERATOR [XM_XPATH_NODE]} last_mapped_sequence.make
			end
		end

feature {NONE} -- Implementation

	base_iterator: XM_XSLT_REGEXP_ITERATOR
			-- Regular expression iterator

	context: XM_XSLT_EVALUATION_CONTEXT
		-- Saved dynamic context

	matching_block: XM_XPATH_EXPRESSION
			-- Optional matching expression

	non_matching_block: XM_XPATH_EXPRESSION
			-- Optional non-matching expression

invariant

	base_iterator_not_void: base_iterator /= Void
	context_not_void: context /= Void

end
