indexing
	description: "ARCH_REP_UNIT allows for the valid creation of an REP_ITEM"
	keywords:    "archetype"
	revision:    "%%A%%"
	source:      "%%P%%"
	copyright:   "See notice at end of class"

class ARCH_REP_UNIT

inherit
	SHARED_ODB_ACCESS

creation
	make

feature -- Initialisation
	make (an_item:like item_prototype; desc:STRING) is
		require
			Valid_item: an_item /= Void
			Valid_description: desc /= Void and then not desc.empty
		do
			item_prototype := deep_clone(an_item)
			description := clone(desc)
		ensure
			Description_set: description.is_equal(desc)
		end

feature -- Status
	is_subtype:BOOLEAN is
		do
			Result := parent_type /= Void
		end

feature -- Access
	description: STRING
			-- proper class name of the item type

	bus_obj_desc:BUS_OBJ_DESC

	parent_type:like Current

feature -- Element Change
	set_bus_obj_desc(a_desc:like bus_obj_desc) is
		require
			Valid_descriptor: a_desc /= Void
		do
			bus_obj_desc := a_desc
		end

	set_parent_type(an_au:like Current) is
	       require
	           Args_valid: an_au /= Void
	       do
	           parent_type := an_au
	       end

feature -- Factory
	create_item: like item_prototype is
		do
			Result := deep_clone(item_prototype)
		end

feature {CLIENT_APPLICATION} -- Implementation
	item_prototype: REP_ITEM 

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
 

