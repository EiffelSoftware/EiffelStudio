note
	description: "[
			Record MethodDef and Field token for a TypeDef
		]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MD_TYPE_DEF_DATA_FOR_OPTIMIZATION

feature -- Access

	method_def_list: detachable LIST [NATURAL_32]
			-- MethodDef tokens
	field_list: detachable LIST [NATURAL_32]
			-- Field tokens

feature -- Status report

	has_field: BOOLEAN
		do
			Result := attached field_list as lst and then lst.count > 0
		end

	has_method_def: BOOLEAN
		do
			Result := attached method_def_list as lst and then lst.count > 0
		end

feature -- Element change

	record_method_def (tok: NATURAL_32)
		local
			lst: like method_def_list
		do
			lst := method_def_list
			if lst = Void then
				create {ARRAYED_LIST [NATURAL_32]} lst.make (5)
				method_def_list := lst
			end
			lst.force (tok & 0x00FF_FFFF)
		end

	record_field (tok: NATURAL_32)
		local
			lst: like field_list
		do
			lst := field_list
			if lst = Void then
				create {ARRAYED_LIST [NATURAL_32]} lst.make (5)
				field_list := lst
			end
			lst.force (tok & 0x00FF_FFFF)
		end

feature -- Operation

	sort_method_def_list
		do
			if attached method_def_list as lst then
				sorter.sort (lst)
			end
		end

	sort_field_list
		do
			if attached field_list as lst then
				sorter.sort (lst)
			end
		end

feature {NONE} -- Implementation

	sorter: SORTER [NATURAL_32]
		once
			create {QUICK_SORTER [NATURAL_32]} Result.make (create {COMPARABLE_COMPARATOR [NATURAL_32]})
		end

end
