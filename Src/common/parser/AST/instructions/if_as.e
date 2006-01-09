indexing
	description	: "Abstract description of a conditional instruction, %
				  %Version for Bench."
	date		: "$Date$"
	revision	: "$Revision$"

class IF_AS

inherit
	INSTRUCTION_AS
		redefine
			number_of_breakpoint_slots
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (cnd: like condition; cmp: like compound;
		ei: like elsif_list; e: like else_part; el: like end_keyword; i_as, t_as, e_as: like if_keyword) is
			-- Create a new IF AST node.
		require
			cnd_not_void: cnd /= Void
			el_not_void: el /= Void
		do
			condition := cnd
			compound := cmp
			elsif_list := ei
			else_part := e
			end_keyword := el
			if_keyword := i_as
			then_keyword := t_as
			else_keyword := e_as
		ensure
			condition_set: condition = cnd
			compound_set: compound = cmp
			elsif_list_set: elsif_list = ei
			else_part_set: else_part = e
			end_keyword_set: end_keyword = el
			if_keyword_set: if_keyword = i_as
			then_keyword_set: then_keyword = t_as
			else_keyword_set: else_keyword = e_as
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_if_as (Current)
		end

feature -- Roundtrip

	if_keyword, then_keyword, else_keyword: KEYWORD_AS
			-- Keyword "if", "else" and "then" assoicated with this structure

feature -- Attributes

	condition: EXPR_AS
			-- Conditional expression

	compound: EIFFEL_LIST [INSTRUCTION_AS]
			-- Compound

	elsif_list: EIFFEL_LIST [ELSIF_AS]
			-- Elsif list

	else_part: EIFFEL_LIST [INSTRUCTION_AS]
			-- Else part

	end_keyword: KEYWORD_AS
			-- Line number where `end' keyword is located

feature -- Roundtrip/Location

	complete_start_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			if a_list = Void then
				Result := condition.complete_start_location (a_list)
			else
				Result := if_keyword.complete_start_location (a_list)
			end
		end

	complete_end_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			Result := end_keyword.complete_end_location (a_list)
		end

feature -- Access

	number_of_breakpoint_slots: INTEGER is
			-- Number of stop points for AST
		do
			Result := 1 -- condition test
			if compound /= Void then
				Result := Result + compound.number_of_breakpoint_slots
			end
			if elsif_list /= Void then
				Result := Result + elsif_list.number_of_breakpoint_slots
			end
			if else_part /= Void then
				Result := Result + else_part.number_of_breakpoint_slots
			end
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (compound, other.compound) and then
				equivalent (condition, other.condition) and then
				equivalent (else_part, other.else_part) and then
				equivalent (elsif_list, other.elsif_list)
		end

invariant
	condition_not_void: condition /= Void
	end_keyword_not_void: end_keyword /= Void

end -- class IF_AS
