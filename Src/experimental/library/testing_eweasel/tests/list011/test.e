
class TEST
create
	make
feature
	make is
		do
			create {ARRAYED_LIST [PARENT]} parent_list.make (5)
			create {ARRAYED_LIST [CHILD]} child_list.make (5)
			parent_list.extend (create {PARENT})
			child_list.extend (create {CHILD})
			parent_list.append (child_list)
		end

	parent_list: LIST [PARENT]

	child_list: LIST [CHILD]

end
