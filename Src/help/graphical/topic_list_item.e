indexing
	description: "A tree item that contains a topic."
	author: "Vincent Brendel"

class
	TOPIC_TREE_ITEM

inherit
	EV_TREE_ITEM
		rename
			data as topic
		redefine
			topic
		end

creation
	make_item

feature -- Initialization

	make_item(tr: EV_TREE_ITEM_HOLDER; top: E_TOPIC) is
			-- Initialize with parent 'tr'.
		require
			not_void: tr /= Void and then top /= Void and then top.id /= Void
		do
			make_with_text(tr, top.head)
			topic := top
		end

feature -- Access

	topic: E_TOPIC
			-- The topic object.

invariant
	TOPIC_TREE_ITEM_topic_exists: topic /= Void

end -- class TOPIC_TREE_ITEM
