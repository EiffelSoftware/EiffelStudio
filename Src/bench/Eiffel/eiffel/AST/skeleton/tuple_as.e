indexing
	description: "AST representation of manifest tuple."
	date: "$Date$"
	revision: "$Revision$"

class TUPLE_AS

inherit
	EXPR_AS
		redefine
			type_check, byte_node, is_equivalent
		end

	SHARED_INSTANTIATOR
		export
			{NONE} all
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (exp: like expressions) is
			-- Create a new Manifest TUPLE AST node.
		require
			exp_not_void: exp /= Void
		do
			expressions := exp
		ensure
			expressions_set: expressions = exp
		end

feature -- Attributes

	expressions: EIFFEL_LIST [EXPR_AS]
			-- Expression list symbolizing the manifest tuple

feature -- Location

	start_location: LOCATION_AS is
			-- Starting point for current construct.
		do
			Result := expressions.start_location
		end
		
	end_location: LOCATION_AS is
			-- Ending point for current construct.
		do
			Result := expressions.end_location
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_tuple_as (Current)
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (expressions, other.expressions)
		end

feature -- Type check, byte code, dead code removal and formatter

	type_check is
			-- Type check a manifest tuple
		local
			i, nb: INTEGER
			tuple_type: TUPLE_TYPE_A
			generics : ARRAY [TYPE_A]
		do
			context.begin_expression
				-- Type check expression list
			expressions.type_check
				-- Creation of a tuple type
			from
				nb := expressions.count
				i := nb
				create generics.make (1, nb)
			until
				i < 1
			loop
				generics.put (context.item, i)
				context.pop (1)
				i := i - 1
			end
				-- Update type stack
			create tuple_type.make (System.tuple_id, generics)

			Instantiator.dispatch (tuple_type, Context.current_class)

			context.replace (tuple_type)
				-- Update the tuple type stack
			tuple_line.insert (tuple_type)
		end

	byte_node: TUPLE_CONST_B is
			-- Byte code for a manifest tuple
		do
			create Result
			Result.set_expressions (expressions.byte_node)
			Result.set_type (tuple_line.item.type_i)
				-- Update the tuple_type stack
			tuple_line.forth
		end

	tuple_line: LINE [TUPLE_TYPE_A] is
			-- Tuple type stack
		once
			Result := context.tuple_line
		end

feature {AST_EIFFEL} -- Output

	string_value: STRING is ""

invariant
	expressions_not_void: expressions /= Void

end -- class TUPLE_AS

