indexing
	description: "ARCH_INFO_UNIT allows for the valid creation of an INFO_ITEM"
	keywords:    "archetype"
	revision:    "%%A%%"
	source:      "%%P%%"
	copyright:   "See notice at end of class"

class ARCH_INFO_UNIT

inherit
        ARCH_REP_UNIT
		rename
			make as rep_make
		redefine
			item_prototype,
			create_item
		end

creation
        make

feature -- Initialisation
        make (an_item:like item_prototype; desc:STRING) is
		require
			Valid_item: an_item /= Void
			Valid_description: desc /= Void and then not desc.empty
		do
			rep_make(an_item, desc)
		ensure
			Description_set: description.is_equal(desc)
		end

feature -- Factory
        create_item: like item_prototype is
			-- factory routine to make the right kind of baggage unit
		do
			Result := deep_clone(item_prototype)
		end

feature {NONE} -- Implementation
        item_prototype: INFO_ITEM 
	            -- the item to clone in make_asset

end

--         +---------------------------------------------------+
--         |                                                   |
--         |                Copyright (c) 1998                 |
--         |            Deep Thought Informatics P/L           |
--         |        Australian Company Number 076 645 291      |
--         |                                                   |
--         | Duplication and distribution permitted with this  |
--         | notice  intact.  Please send  modifications  and  |
--         | suggestions  to the Deep Thought Informatics, in  |
--         | the  interests  of maintenance  and improvement.  |
--         |                                                   |
--         |           email: info@deepthought.com.au          |
--         |                                                   |
--         +---------------------------------------------------+
 

