class TEST
inherit
	EXCEPTIONS

create
	make

feature -- Initialization

	make is
		local
			l_res: INTEGER
		do
			if l_res = 0 then
				Current.feature_inv
			elseif l_res = 1 then
				Current.feature_post
			elseif l_res = 2 then
				Current.feature_check
			elseif l_res = 3 then
				Current.feature_linv
			elseif l_res = 4 then
				Current.feature_pre				
			end
		rescue
			print ("Rescued%N")
			i := 0
			l_res := l_res + 1
			retry
		end

	feature_inv is
		once
			i := 1
		end
		
	feature_pre is
		require
			pre_vio: False
		once
			i := 1
		end
		
	feature_post is
		once
		ensure
			post_vio: False
		end
		
	feature_check is
		once
			check check_vio: False end
		end
		
	feature_linv is
		once
			from
			variant
				variant_vio: i + 1
			until
				False
			loop

			end
		end

	i: INTEGER

invariant
	i_zero: i = 0

end
