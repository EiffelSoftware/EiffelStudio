note
	description: "Summary description for {MD_INDEX_LIST}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MD_INDEX_LIST [G -> PE_MD_TABLE [PE_MD_TABLE_ENTRY]]

create
	make

feature {NONE} -- Initialization

	make (nb: INTEGER)
		do
			create items.make (nb)
		end

feature -- Access

	items: ARRAYED_LIST [TUPLE [lower_index, upper_index: NATURAL_32; entry: like {G}.entry]]

	indexes (e: like {G}.entry): detachable TUPLE [lower_index, upper_index, nb: NATURAL_32]
		do
			across
				items as ic
			until
				Result /= Void
			loop
				if ic.item.entry = e then
					Result := [ic.item.lower_index, ic.item.upper_index, ic.item.upper_index - ic.item.lower_index + 1]
				end
			end
			if Result /= Void and then Result.lower_index = 0 then
				Result := Void
			end
		end

feature -- Element change

	sort
		do
			index_sorter.sort (items)
		end

	update
		local
			prev: like items.item
		do
			sort
			across
				items as ic
			loop
				if attached ic.item as d then
					if prev /= Void and then prev.lower_index > 0 then
						prev.upper_index := d.lower_index - 1
					end
					prev := d
				end
			end
		end

	force (a_lower, a_upper: NATURAL_32; e: like {G}.entry)
		do
			items.force ([a_lower, a_upper, e])
		end

feature -- Implementation		

	index_sorter: QUICK_SORTER [TUPLE [index: NATURAL_32]]
		once
			create Result.make (create {AGENT_EQUALITY_TESTER [TUPLE [index: NATURAL_32]]}.make (agent (t1, t2: TUPLE [index: NATURAL_32]): BOOLEAN
					do
						Result := t1.index < t2.index
					end))
		end


end
