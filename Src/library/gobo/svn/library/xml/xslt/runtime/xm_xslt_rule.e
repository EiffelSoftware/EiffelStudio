indexing

	description:

		"Objects that implement one rule within an XSLT mode"

	library: "Gobo Eiffel XSLT Library"
	copyright: "Copyright (c) 2004, Colin Adams and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class	XM_XSLT_RULE

create

	make, make_with_copy

feature {NONE} -- Implementation

	make (a_pattern: XM_XSLT_PATTERN; a_handler: XM_XSLT_RULE_VALUE; a_precedence: INTEGER; a_priority: MA_DECIMAL; a_sequence_number: INTEGER) is
			-- Establish invariant.
		require
			pattern_not_void: a_pattern /= Void
			handler_not_void: a_handler /= Void
		do
			pattern := a_pattern
			handler := a_handler
			precedence := a_precedence
			priority := a_priority
			sequence_number := a_sequence_number
			priority_rank := -1 -- not yet computed
		ensure
			no_next_rule: next_rule = Void
			pattern_set: pattern = a_pattern
			handler_set: handler = a_handler
			precedence_set: precedence = a_precedence
			priority_set: priority = a_priority
			sequence_number_set: sequence_number = a_sequence_number
		end

	make_with_copy (other: XM_XSLT_RULE) is
			-- Create as a copy of `other', along with a copy of it's chain.
		require
			other_rule_not_void: other /= Void
		do
			pattern := other.pattern
			handler := other.handler
			precedence := other.precedence
			priority := other.priority
			priority_rank := other.priority_rank
			sequence_number := other.sequence_number
			if other.next_rule /= Void then
				create next_rule.make_with_copy (other.next_rule)
			end
		end

feature -- Access

	pattern: XM_XSLT_PATTERN
			-- pattern which this rule matches
	
	handler: XM_XSLT_RULE_VALUE
			-- handler for `pattern'

	precedence: INTEGER
			-- Precedence

	priority: MA_DECIMAL
			-- Priority

	priority_rank: INTEGER
			-- Ranked priority, so comparison can be done using integer binary arithmetic

	sequence_number: INTEGER
			-- Sequence number
	
	next_rule: XM_XSLT_RULE
			-- Next rule on the chain

feature -- Element change

	set_next_rule (a_next_rule: XM_XSLT_RULE) is
			-- Set next rule in chain.
		do
			next_rule := a_next_rule
		ensure
			next_rule_set: next_rule = a_next_rule
		end

	set_priority_rank (a_rank: INTEGER) is
			-- Set `priority_rank'.
		require
			strictly_positive_rank: a_rank > 0
			rank_not_set: priority_rank = -1
		do
			priority_rank := a_rank
		ensure
			rank_set: priority_rank = a_rank
		end

invariant
	
	pattern_not_void: pattern /= Void
	handler_not_void: handler /= Void
	positive_sequence_number: sequence_number >= 0

end
	
