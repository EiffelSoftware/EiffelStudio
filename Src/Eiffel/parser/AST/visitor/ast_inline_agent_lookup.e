indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	AST_INLINE_AGENT_LOOKUP

inherit
	AST_ITERATOR
		redefine 
			process_inline_agent_creation_as, 
			process_eiffel_list 
		end

feature

	lookup_inline_agent (body: FEATURE_AS; a_inline_agent_nr: INTEGER): BODY_AS is
		require
			valid_inline_agent_nr: a_inline_agent_nr > 0
		do
			found_inline_agent := Void
			distance_from_target := a_inline_agent_nr
			process_feature_as (body)
			Result := found_inline_agent
		end

	process_inline_agent_creation_as (l_as: INLINE_AGENT_CREATION_AS) is
			-- Process `l_as'.
		do
			distance_from_target := distance_from_target - 1
			if distance_from_target = 0 then
				found_inline_agent := l_as.body
			else
				precursor (l_as)
			end
		end

	process_eiffel_list (l_as: EIFFEL_LIST [AST_EIFFEL]) is
		local
			l_cursor: CURSOR
		do
			from
				l_cursor := l_as.cursor
				l_as.start
			until
				found_inline_agent /= Void or else l_as.after
			loop
				l_as.item.process (Current)
				l_as.forth
			end
			l_as.go_to (l_cursor)
		end

feature {NONE}

	distance_from_target: INTEGER
	found_inline_agent: BODY_AS

end
