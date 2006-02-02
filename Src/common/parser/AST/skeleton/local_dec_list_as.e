indexing
	description: "Object that represents a list of local decarations"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LOCAL_DEC_LIST_AS

inherit
	AST_EIFFEL

create
	make

feature{NONE} -- Initialization

	make (l_as: like locals; k_as: like local_keyword) is
			-- Initialize instance.
		require
			l_as_not_void: l_as /= Void
		do
			locals := l_as
			local_keyword := k_as
		ensure
			locals_set: locals = l_as
			local_keyword_set: local_keyword = k_as
		end

feature -- Access

	locals: EIFFEL_LIST [TYPE_DEC_AS]
			-- Local declarations

feature -- Visitor

	process (v: AST_VISITOR) is
			-- Visitor feature.
		do
			v.process_local_dec_list_as (Current)
		end

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			if locals = Void then
				Result := other.locals = Void
			else
				Result := other.locals /= Void and then locals.is_equivalent (other.locals)
			end
		end

feature -- Roundtrip/Token

	first_token (a_list: LEAF_AS_LIST): LEAF_AS is
			-- First token in current AST node
		do
			if a_list = Void then
				if locals /= Void then
					Result := locals.first_token (a_list)
				end
			else
				Result := local_keyword.first_token (a_list)
			end
		end

	last_token (a_list: LEAF_AS_LIST): LEAF_AS is
			-- Last token in current AST node
		do
			if locals /= Void then
				Result := locals.last_token (a_list)
			end
			if (Result = Void or else Result.is_null) and a_list /= Void then
					-- Roundtrip mode
				Result := local_keyword.last_token (a_list)
			end
		end

feature -- Roundtrip

	local_keyword: KEYWORD_AS
			-- Keyword "local" associated with current AST node

end
