deferred class LIKE_TYPE

inherit

	TYPE
		redefine
			is_like
		end

feature

	is_like: BOOLEAN is True;
			-- Is the type an acnhored type ?

end
