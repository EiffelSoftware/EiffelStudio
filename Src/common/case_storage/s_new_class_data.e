class S_NEW_CLASS_DATA

inherit

	S_CLASS_DATA_R331
		redefine
			is_new_since_last_re
		end

creation

	make

feature

	is_new_since_last_re: BOOLEAN is True;
			-- Is current class new since
			-- last reverse engineering ?

end
