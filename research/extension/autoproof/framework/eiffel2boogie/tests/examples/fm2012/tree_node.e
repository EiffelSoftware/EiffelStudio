class
	TREE_NODE

create
	make

feature -- Initialization

	make (a_left, a_right: TREE_NODE; a_value: INTEGER)
		require
			left_smaller: a_left /= Void implies a_left.data < a_value
			right_smaller: a_right /= Void implies a_right.data > a_value
		do
			left := a_left
			right := a_right
			data := a_value
		ensure
			left = a_left
			right = a_right
			data = a_value
		end

feature -- Access

	left: TREE_NODE

	right: TREE_NODE

	data: INTEGER

feature -- Element change

	set_left (a_node: TREE_NODE)
		do
			left := a_node
		ensure
			left_set: left = a_node
		end

	set_right (a_node: TREE_NODE)
		do
			right := a_node
		ensure
			right_set: right = a_node
		end

	set_data (a_value: INTEGER)
		do
			data := a_value
		ensure
			data_set: data = a_value
		end

end
