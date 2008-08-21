indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_QUERY_LANGUAGE_TEXT_OUTPUT

inherit
	EB_QUERY_LANGUAGE_PRINTER_OUTPUT

create
	make

feature{NONE} -- Initialization

	make is
			-- Initialize.
		do
			create output_internal.make
		end

feature -- Access

	last_output: STRING_32 is
			-- Last output
		do
			if count > 0 then
				create Result.make (count)
			else
				create Result.make (128)
			end
			output_internal.do_all (agent Result.append ({STRING_32} ?))
		ensure
			result_attached: Result /= Void
		end

feature -- Status report

	is_output_empty: BOOLEAN is
			-- Is output empty?
		do
			Result := count = 0
		ensure then
			good_result: Result = (count = 0)
		end

feature -- Basic operations

	initialize_last_output is
			-- Initialize `last_output' for new output process.
		do
			count := 0
			output_internal.wipe_out
		ensure then
			count_reset: count = 0
			output_internal_reset: output_internal.is_empty
		end

feature{EB_QUERY_LANGUAGE_PRINTER_VISITOR} -- Process

	process_domain (a_item: QL_DOMAIN) is
			-- Process `a_item'.
		do
		end

	process_item_internal (a_item: QL_ITEM) is
			-- Process `a_item'.
		require
			a_item_attached: a_item /= Void
		local
			l_name: STRING_32
		do
			l_name := a_item.name
			count := count + l_name.count
			output_internal.extend (l_name)
		ensure
			count_increased: count = old count + a_item.name.count
			a_item_processed: not output_internal.is_empty and then output_internal.last = a_item.name
		end

	process_target (a_item: QL_TARGET) is
			-- Process `a_item'.
		do
			process_item_internal (a_item)
		end

	process_group (a_item: QL_GROUP) is
			-- Process `a_item'.
		do
			process_item_internal (a_item)
		end

	process_class (a_item: QL_CLASS) is
			-- Process `a_item'.
		do
			process_item_internal (a_item)
		end

	process_feature (a_item: QL_FEATURE) is
			-- Process `a_item'.
		do
			process_item_internal (a_item)
		end

	process_real_feature (a_item: QL_REAL_FEATURE) is
			-- Process `a_item'.
		do
			process_item_internal (a_item)
		end

	process_invariant (a_item: QL_INVARIANT) is
			-- Process `a_item'.
		do
			process_item_internal (a_item)
		end

	process_quantity (a_item: QL_QUANTITY) is
			-- Process `a_item'.
		do
			process_item_internal (a_item)
		end

	process_line (a_item: QL_LINE) is
			-- Process `a_item'.
		do
			process_item_internal (a_item)
		end

	process_generic (a_item: QL_GENERIC) is
			-- Process `a_item'.
		do
			process_item_internal (a_item)
		end

	process_local (a_item: QL_LOCAL) is
			-- Process `a_item'.
		do
			output_internal.extend (a_item.name)
		end

	process_argument (a_item: QL_ARGUMENT) is
			-- Process `a_item'.
		do
			process_item_internal (a_item)
		end

	process_assertion (a_item: QL_ASSERTION) is
			-- Process `a_item'.
		do
			process_item_internal (a_item)
		end

feature{EB_QUERY_LANGUAGE_PRINTER_VISITOR} -- Implementation

	process_folder (a_name: STRING_32; a_path: STRING_32; a_group: CONF_GROUP) is
			-- Process folder.
			-- `a_name' is name of that folder, `a_path' is related path of that folder, such as "/abc/def".
			-- `a_group' is the group where that folder is located.
		do
			count := count + a_name.count
			output_internal.extend (a_name)
		ensure then
			count_increased: count = old count + a_name.count
			a_name_processed: not output_internal.is_empty and then output_internal.last = a_name
		end

	process_dot_separator is
			-- Process dot separator, i.e, put a dot in output.
		local
			l_dot: STRING_32
		do
			l_dot := ti_dot
			count := count + l_dot.count
			output_internal.extend (l_dot)
		end

feature{NONE} -- Implemenation

	output_internal: LINKED_LIST [STRING_32]
			-- Implementation of `output'

	count: INTEGER
			-- Number of characters in `output'

invariant
	output_internal_attached: output_internal /= Void

end
