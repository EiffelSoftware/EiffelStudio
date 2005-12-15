indexing
	description	: "Description of variant loop. Version for Bench."
	date		: "$Date$"
	revision	: "$Revision$"

class VARIANT_AS

inherit
	TAGGED_AS
		redefine
			process
		end

create
	make

feature -- Initialization

	make (t: like tag; e: like expr; v_as: like variant_keyword; c_as: like colon_symbol) is
			-- Create new VARIANT AST node.
		do
			initialize (t, e, c_as)
			variant_keyword := v_as
		ensure
			variant_keyword_set: variant_keyword = v_as
		end

feature -- Roundtrip

	variant_keyword: KEYWORD_AS
		-- Keyword "variant" associated with this structure

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_variant_as (Current)
		end

end -- class VARIANT_AS
