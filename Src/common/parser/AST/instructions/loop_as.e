indexing
	description	: "Abstract description of an Eiffel loop instruction. %
				  %Version for Bench."
	date		: "$Date$"
	revision	: "$Revision$"

class LOOP_AS

inherit
	INSTRUCTION_AS
		redefine
			number_of_breakpoint_slots
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (f: like from_part; i: like invariant_part;
		v: like variant_part; s: like stop;
		c: like compound; e: like end_keyword) is
			-- Create a new LOOP AST node.
		require
			s_not_void: s /= Void
			e_not_void: e /= Void
		do
			from_part := f
			invariant_part := i
			variant_part := v
			stop := s
			compound := c
			end_keyword := e
		ensure
			from_part_set: from_part = f
			invariant_part_set: invariant_part = i
			variant_part_set: variant_part = v
			stop_set: stop = s
			compound_set: compound = c
			end_keyword_set: end_keyword = e
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_loop_as (Current)
		end

feature -- Attributes

	from_part: EIFFEL_LIST [INSTRUCTION_AS]
			-- from compound

	invariant_part: EIFFEL_LIST [TAGGED_AS]
			-- invariant list

	variant_part: VARIANT_AS
			-- Variant list

	stop: EXPR_AS
			-- Stop test

	compound: EIFFEL_LIST [INSTRUCTION_AS]
			-- Loop compound

	end_keyword: LOCATION_AS
			-- Line number where `end' keyword is located

feature -- Location

	start_location: LOCATION_AS is
			-- Starting point for current construct.
		do
			if from_part /= Void then
				Result := from_part.start_location
			elseif invariant_part /= Void then
				Result := invariant_part.start_location
			elseif variant_part /= Void then
				Result := variant_part.start_location
			else
				Result := stop.start_location
			end
		end
		
	end_location: LOCATION_AS is
			-- Ending point for current construct.
		do
			Result := end_keyword
		end

feature -- Access

	number_of_breakpoint_slots: INTEGER is
			-- Number of stop points for AST
		do
				-- "from" part
			if from_part /= Void then
				Result := Result + from_part.number_of_breakpoint_slots
			end

				-- "invariant" part
			if invariant_part /= Void then
				Result := Result + invariant_part.number_of_breakpoint_slots
			end
				-- "variant" part
			if variant_part /= Void then
				Result := Result + variant_part.number_of_breakpoint_slots
			end

				-- "until" part
			Result := Result + 1

				-- "loop" part
			if compound /= Void then
				Result := Result + compound.number_of_breakpoint_slots
			end
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (compound, other.compound) and then
				equivalent (from_part, other.from_part) and then
				equivalent (invariant_part, other.invariant_part) and then
				equivalent (stop, other.stop) and then
				equivalent (variant_part, other.variant_part)
		end

invariant
	stop_not_void: stop /= Void 
			
end -- class LOOP_AS
