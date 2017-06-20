note
	description: "Summary description for {LINE_ITEM}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LINE_ITEM

create
    make

feature {NONE} -- Initialization

    make (a_name: STRING_32)
        do
            set_name (a_name)
            create item_index.make (10)
        end

feature -- Access

   name: STRING_32

   items: LIST [ITEM]
        do
			create {ARRAYED_LIST [ITEM]} Result.make (item_index.count)
			across
				item_index as ic
            loop
                Result.append (ic.item)
            end
        end

feature -- Status setting

    set_name (a_name: STRING_32)
        do
            name := a_name
        end

    add_item (an_item: ITEM)
        local
            lst: detachable LIST [ITEM]
        do
            lst := item_index.item (an_item.id)
            if lst = Void then
                create {ARRAYED_LIST [ITEM]} lst.make (1)
                item_index.force (lst, an_item.id)
            end
			lst.force (an_item)
        end

	add_items (lst: like items)
        do
            across
                lst as ic
            loop
                add_item (ic.item)
            end
        end

feature {NONE} -- Implementation

    item_index: STRING_TABLE [LIST [ITEM]]

end -- class LINE_ITEM
