indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	INLINE_AGENT_CREATION_AS

inherit
	AGENT_ROUTINE_CREATION_AS
		rename
			make as initialize_routine
		redefine
			process, is_equivalent
		end

create
	make

feature{NONE} -- Initialization

	make (a_body: like body; o: like internal_operands; a_as: like agent_keyword) is
			-- Create a new INLINE_AGENT_CREATION_AS AST node.
		require
			as_not_void: a_as /= Void
			body_not_void: a_body /= Void
		do
			initialize (Void, Void, o, False)
			agent_keyword := a_as
			body := a_body
		ensure
			agent_keyword_set: agent_keyword = a_as
			body_set: body = a_body
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_inline_agent_creation_as (Current)
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := Precursor (other) and then equivalent (body, other.body)
		end

feature -- Access

	set_feature_name (a_fn: ID_AS) is
		require
			fn_not_void: a_fn /= Void
		do
			feature_name := a_fn
		ensure
			feature_name_set: feature_name = a_fn
		end

feature --attributes

	body: BODY_AS

end
