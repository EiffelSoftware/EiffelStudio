indexing
	description: "Accelerators epresentation in the tds"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

class
	TDS_ACCELERATORS

inherit
	TDS_RESOURCE
		rename
			make as list_make
		end

create
	make

feature -- Initialization

	make is
			-- Create accelerators
		do
			list_make
			create accelerator_list.make
		end

feature -- Access

	current_accelerator: TDS_ACCELERATORS_ITEM
			-- Accelerator being processed

	accelerator_list: LINKED_LIST [TDS_ACCELERATORS_ITEM]

feature -- Setting

	set_current_accelerator (v: TDS_ACCELERATORS_ITEM) is
			-- Assign `v' to `current_accelerator'.
		require
			v_not_void: v /= Void
		do
			current_accelerator := v
		ensure
			current_accelerator_set: current_accelerator = v
		end

	insert_accelerator (v: TDS_ACCELERATORS_ITEM) is
		do
			accelerator_list.extend (v)
		end

feature -- Code generation

	generate_tree_view (a_tree_view: EV_TREE_ITEM) is
		do
		end

	generate_wel_code is
		do
		end

	generate_resource_file (a_resource_file: PLAIN_TEXT_FILE) is
		do
		end

	display is
		do
		end

end -- class TDS_ACCELERATORS
