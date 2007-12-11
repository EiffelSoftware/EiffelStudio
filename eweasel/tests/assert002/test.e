
class TEST
create
	make
feature
	
	make is
		local
			bool_list: ARRAYED_LIST [BOOLEAN]
			b: BOOLEAN
		do
			create bool_list.make (3)
			bool_list.extend (True)
			bool_list.extend (False)
			bool_list.extend (False)
			bool_list.extend (True)
			b := bool_list.i_th (5)
		end

end
