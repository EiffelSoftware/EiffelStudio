indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TDS_RESOURCE

inherit
	LINKED_LIST [TDS_RESOURCE]

	TDS_RESOURCE_CONSTANTS

feature -- Access

	tree_view_item: EV_TREE_NODE

	is_wel_code_on: BOOLEAN

	class_name: STRING

	set_class_name (s: STRING) is
		do
			class_name := s
		end

	type: INTEGER

	set_type (a_type: INTEGER) is
		do
			type := a_type
		end

	make_options is
		do
			create options.make
		end

	make_load_and_mem_attributes is
		do
			create load_and_mem_attributes.make
		end

	id: TDS_ID

	set_id (s: STRING) is
		do
			if id = Void then
				create id
			end
			id.set_id (s)
		end

	insert (v: TDS_RESOURCE) is
		do
			extend (v)
		end

	set_tree_view_item (a_parent: EV_TREE_NODE) is
		do
			tree_view_item := a_parent
		end

	set_wel_code (value: BOOLEAN) is
		do
			is_wel_code_on := value
		end

	generate_resource_file (a_resource_file: PLAIN_TEXT_FILE) is
		deferred
		end

	generate_tree_view (a_tree_view: EV_TREE_ITEM) is
		deferred
		end

	generate_wel_code is
		deferred
		end

	load_and_mem_attributes: TDS_LOAD_AND_MEM_ATTRIBUTES

	options: TDS_OPTIONS

	filename: STRING
	
	set_filename (s: STRING) is
		do
			filename := s
		end

	display is
		deferred
		end

end -- class TDS_RESOURCE
