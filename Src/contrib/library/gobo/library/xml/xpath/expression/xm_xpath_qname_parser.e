indexing

	description:

		"Objects that parse assumed lexical QNames"

	library: "Gobo Eiffel XPath Library"
	copyright: "Copyright (c) 2005, Colin Adams and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class XM_XPATH_QNAME_PARSER

inherit

	XM_MARKUP_CONSTANTS

	XM_UNICODE_CHARACTERS_1_1

create

	make

feature {NONE} -- Initialization

	make (a_qname: STRING) is
			-- Establish invariant
		require
			qname_not_void: a_qname /= Void
		local
			a_string_splitter: ST_SPLITTER
			some_qname_parts: DS_LIST [STRING]
		do
			create a_string_splitter.make
			a_string_splitter.set_separators (Prefix_separator)
			some_qname_parts := a_string_splitter.split_greedy (a_qname)
			if some_qname_parts.count = 1 then
				optional_prefix := Default_namespace
				local_name := some_qname_parts.item (1)
				if is_ncname (local_name) then
					is_valid := True
				end
			elseif some_qname_parts.count = 2 then
				optional_prefix := some_qname_parts.item (1)
				local_name := some_qname_parts.item (2)
				if is_ncname (local_name) and then is_ncname (optional_prefix) then
					is_valid := True
				end
			elseif some_qname_parts.count > 2 then
				too_many_colons := True
			end
		end

feature -- Access

	optional_prefix: STRING
			-- Optional prefix

	local_name: STRING
			-- Local name

feature -- Status report

	is_valid: BOOLEAN
			-- Does `Current' represent a valid lexical QName?

	too_many_colons: BOOLEAN
			-- Were more than one colon prenet?

	is_prefix_present: BOOLEAN is
			-- Is a prefix present?
		require
			valid: is_valid
		do
			Result := optional_prefix.count > 0
		end

invariant

	prefix_not_void:	is_valid implies optional_prefix /= Void
	local_name_not_void: is_valid implies local_name /= Void
	invalidity_contraint: too_many_colons implies not is_valid

end
	
