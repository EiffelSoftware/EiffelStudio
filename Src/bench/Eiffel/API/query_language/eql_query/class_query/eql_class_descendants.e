indexing
	description: "Object that represents a list of ancestor classes of a certain class"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EQL_CLASS_DESCENDANTS

inherit
	EQL_CLASS_HIERARCHY

feature -- Access

	classes (a_class: CLASS_C) : LIST [CLASS_C] is
			-- Descendant classes of `a_class'
		local
			l_descendants: LIST [CLASS_C]

			i: INTEGER
		do
			l_descendants := a_class.descendants
			if l_descendants /= Void then
				create {ARRAYED_LIST [CLASS_C]}Result.make (l_descendants.count)
				Result.fill (l_descendants)
			else
				create {ARRAYED_LIST [CLASS_C]}Result.make (0)
			end
		end

	recursive_classes (a_class: CLASS_C): LIST [CLASS_C] is
			-- Recursive class hierarchy of descendants of `a_class'
		local
			l_qry: EQL_CLASS_DESCENDANT_QUERY
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
