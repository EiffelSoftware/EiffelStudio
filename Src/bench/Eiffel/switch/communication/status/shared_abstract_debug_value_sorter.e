indexing
	description: "Objects that ..."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_ABSTRACT_DEBUG_VALUE_SORTER

feature {NONE} -- Implementation

	Abstract_debug_value_sorter: DS_SORTER [ABSTRACT_DEBUG_VALUE] is
			-- Attributes sorter.
		local
			l_comp: KL_COMPARABLE_COMPARATOR [ABSTRACT_DEBUG_VALUE]
		once
			create l_comp.make
			create {DS_QUICK_SORTER [ABSTRACT_DEBUG_VALUE]} Result.make (l_comp)
		end

	sort_debug_values (lst: DS_LIST [ABSTRACT_DEBUG_VALUE]) is
			-- sort `children' and return it.
		require
			lst_not_void: lst /= Void
		do
			if
				not lst.sorted (abstract_debug_value_sorter)
			then
				lst.sort (abstract_debug_value_sorter)
			end
		ensure
			lst_sorted: lst.sorted (abstract_debug_value_sorter)
		end

end
