indexing
	description: "A list item with a topic object."
	author: "Vincent Brendel"

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
			-- Initialize with parent 'li'.
		require
			not_void: li /= Void and then top /= Void and then top.id/=Void
		do
			make_with_text(li, top.id)
			topic := top
		end

feature -- Access

	topic: E_TOPIC
			-- The topic object.

invariant
	TOPIC_LIST_ITEM_topic_exists: topic /= Void

end -- class TOPIC_LIST_ITEM
