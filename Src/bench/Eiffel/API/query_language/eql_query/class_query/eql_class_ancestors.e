indexing
	description: "Object that represents a list of ancestor classes of a certain class"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EQL_CLASS_ANCESTORS

inherit
	EQL_CLASS_HIERARCHY

feature -- Access

	classes (a_class: CLASS_C) : LIST [CLASS_C] is
			-- Ancestor classes of `a_class'
		local
			l_parents: FIXED_LIST [CL_TYPE_A]
			i: INTEGER
		do
			l_parents := a_class.parents
			if l_parents /= Void then
				create {ARRAYED_LIST [CLASS_C]}Result.make (l_parents.count)
				from
					i := 1
				until
					i > l_parents.count
				loop
					Result.extend (l_parents.i_th (i).associated_class)
					i := i + 1
				end
			else
				create {ARRAYED_LIST [CLASS_C]}Result.make (0)
			end
		end

	recursive_classes (a_class: CLASS_C): LIST [CLASS_C] is
			-- Recursive class hierarchy of ancestors of `a_class'
		local
			l_qry: EQL_CLASS_ANCESTOR_QUERY
			l_itr: EQL_ITERATOR [EQL_CLASS]
		do
			create l_qry
			l_qry.execute (create{EQL_CLASS}.make_with_class_c (a_class))
			create {LINKED_LIST [CLASS_C]}Result.make
			l_itr := l_qry.last_result.distinct_itr
			from
				l_itr.start
			until
				l_itr.after
			loop
				Result.extend (l_itr.item.class_c)
				l_itr.forth
			end
		end

end
