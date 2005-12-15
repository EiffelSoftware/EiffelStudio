indexing
	description:
		"AST representation of an access in an invariant beginning a %
		%call expression or instruction or an access after a creation for %
		%which there is no standard export validation like in %
		%ACCESS_FEAT_AS."
	date: "$Date$"
	revision: "$Revision$"

class ACCESS_INV_AS

inherit
	ACCESS_FEAT_AS
		redefine
			process
		end

create
	make

feature{NONE} -- Initialization

	make (f: like feature_name; p: like parameters; s_as: like dot_symbol) is
			-- Create a new FEATURE_ACCESS AST node.
		do
			initialize (f, p)
			dot_symbol := s_as
		ensure
			dot_symbol_set: dot_symbol = s_as
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_access_inv_as (Current)
		end

feature -- Roundtrip

	dot_symbol: SYMBOL_AS
			-- Symbol "." associated with this structure


end -- class ACCESS_INV_AS
