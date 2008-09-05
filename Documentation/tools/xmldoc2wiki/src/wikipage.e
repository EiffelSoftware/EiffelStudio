indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WIKIPAGE

inherit
	WIKI_WITH_CHILD
		undefine
			is_equal
		redefine
			is_valid_page
		end

	XML2WIKITEXT_HELPERS
		undefine
			is_equal
		end

	DEBUG_OUTPUT
		undefine
			is_equal
		end

	COMPARABLE

create
	make

feature {NONE} -- Initialization

	make (a_base_id: STRING; a_path: STRING)
		do
			set_base_id (a_base_id)
			set_path (path_to_url (a_path))
		end

feature -- Access

	is_index: BOOLEAN

	base_id: STRING
	path: STRING
	src: STRING assign set_src
	title: STRING assign set_title
	depth: INTEGER assign set_depth
	tags: STRING assign set_tags
	failed: BOOLEAN assign set_failed

feature -- status report

	is_valid_page (p: WIKIPAGE): BOOLEAN
		do
			Result := Precursor (p) and is_index
		end

	debug_output: STRING is
			-- String that should be displayed in debugger to represent `Current'.
		do
			create Result.make_empty
			Result.append (depth.out + ": ")

			if base_id /= Void then
				Result.append (base_id)
			end
		end

feature -- Comparison		

	infix "<" (other: like Current): BOOLEAN is
			-- <Precursor>
		do

		end

feature -- Element change

	force_base_id (v: like base_id)
		require
			v_attached: v /= Void
		do
			base_id := v
		end

	set_base_id (v: like base_id)
		require
			v_attached: v /= Void
		do
			base_id := v
			is_index := base_id.is_equal (once "index")
		end

	set_src (v: like src)
		require
			v_attached: v /= Void
		do
			src := v
		end

	set_title (v: like title)
		require
			v_attached: v /= Void
		do
			title := v
		end

	set_path (v: like path)
		require
			v_attached: v /= Void
		do
			path := v
		end

	set_tags (v: like tags)
		require
			v_attached: v /= Void
		do
			tags := v
		end

	set_is_index (v: like is_index)
		do
			is_index := v
		end

	set_depth (v: like depth)
		do
			depth := v
		end

	set_failed (v: like failed)
		do
			failed := v
			check should_never_fail: False end
		end

end
