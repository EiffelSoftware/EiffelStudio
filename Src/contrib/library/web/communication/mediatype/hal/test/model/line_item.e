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
            from
                create {LINKED_LIST [ITEM]} Result.make
				item_index.start
            until
                item_index.after
            loop
                Result.append (item_index.item_for_iteration)
                item_index.forth
            end
        end


feature -- Status setting

    set_name (a_name: STRING_32)
        do
            name := a_name
        end

    add_item (an_item: ITEM)
        local
            l: detachable LIST [ITEM]
        do
            if item_index.has (an_item.id) then
                l := item_index.at ( an_item.id )
            else
                create {LINKED_LIST [ITEM]} l.make
                item_index.put (l, an_item.id)
            end
            if attached l as la then
           	 	la.force (an_item)
            end

        end

	add_items (item_list: like items)
        do
            from
                item_list.start
            until
                item_list.after
            loop
                add_item (item_list.item)
                item_list.forth
            end
        end


feature {NONE} -- Implementation

    item_index: HASH_TABLE [LIST [ITEM], STRING_32]

end -- class LINE_ITEM
