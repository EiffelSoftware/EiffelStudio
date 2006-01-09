indexing
	description: "AST representation of a once routines."
	date: "$Date$"
	revision: "$Revision$"

class ONCE_AS

inherit
	INTERNAL_AS
		redefine
			process, is_once
		end

create
	make

feature{NONE} -- Initialization

	make (c: like compound; l_as: KEYWORD_AS) is
			-- Create new DO AST node.
		do
			initialize (c)
			once_keyword := l_as
		ensure
			once_keyword_set: once_keyword = l_as
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_once_as (Current)
		end

feature -- Roundtrip

	once_keyword: KEYWORD_AS
			-- Keyword "once" associated with this structure

feature -- Properties

	is_once: BOOLEAN is True
			-- Is the current routine body a once one ?

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
				Result := once_keyword.complete_start_location (a_list)
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
				Result := once_keyword.complete_end_location (a_list)
			end
		end

end -- class ONCE_AS
