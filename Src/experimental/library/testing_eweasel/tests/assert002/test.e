
class TEST
create
	make
feature
	
	make is
		local
			bool_list: ARRAYED_LIST [BOOLEAN]
		do
			create bool_list.make (3)
			bool_list.extend (True)
			bool_list.extend (False)
			bool_list.extend (False)
			bool_list.extend (True)
			bool_list.finish
			bool_list.forth
			bool_list.forth
		end

end
