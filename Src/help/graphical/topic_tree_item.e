indexing
	description: "Objects that ..."
	author: ""

class
	TOPIC_LIST_ITEM

inherit
	EV_LIST_ITEM
		rename
			data as topic
		redefine
			topic
		end

creation
	make_item

feature -- Initialization

	make_item(li: EV_LIST; top: E_TOPIC) is
		require
			not_void: li /= Void and then top /= Void and then top.id/=Void
		do
			make_with_text(li, top.id)
			topic := top
		end

feature -- Implementation

	topic: E_TOPIC

invariant
	TOPIC_LIST_ITEM_topic_exists: topic /= Void

end -- class TOPIC_LIST_ITEM
