note
	description: "Input stream that always provides the same value."
	author: "Nadia Polikarpova"
	model: item

class
	V_CONSTANT_INPUT [G]

inherit
	V_INPUT_STREAM [G]

create
	make

feature {NONE} -- Initialization

	make (v: G)
			-- Create a stream that provides `v'.
		do
			item := v
		ensure
			item_effect: item = v
		end

feature -- Access

	item: G
			-- Item at current position.

feature -- Status report

	off: BOOLEAN = False
			-- Is current position off scope?

feature -- Cursor movement

	forth
			-- Move one position forward.
		note
			modify: nothing__
		do
		end

invariant
	box_definition: box |=| create {MML_SET [G]}.singleton (item)

end
