indexing
	description: "AST representation of a non-deferred routine.";
	date: "$Date$";
	revision: "$Revision$"

class DO_AS

inherit
	INTERNAL_AS
		redefine
			process
		end

create
	make

feature{NONE} -- Initialization

	make (c: like compound; l_as: KEYWORD_AS) is
			-- Create new DO AST node.
		do
			initialize (c)
			do_keyword := l_as
		ensure
			do_keyword_set: do_keyword = l_as
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_do_as (Current)
		end

feature -- Roundtrip

	do_keyword: KEYWORD_AS
			-- Keyword "do" associated with this structure

feature -- Roundtrip/Location

	complete_start_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			if a_list = Void then
				if compound /= Void then
					Result := compound.complete_start_location (a_list)
				else
					Result := null_location
				end
			else
				Result := do_keyword.complete_start_location (a_list)
			end
		end

	complete_end_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			if compound /= Void then
				Result := compound.complete_end_location (a_list)
			elseif a_list = Void then
					-- Non-roundtrip mode
				Result := null_location
			else
				Result := do_keyword.complete_end_location (a_list)
			end
		end

end -- class DO_AS
