deferred class STORER 

inherit

	STORER_EXTERNAL
		export {NONE} all
	end

feature  -- Actions

	store (one_object : ANY;media: ANY) is
		-- Produce on media an external representation of the
		-- entire object structure reachable from current object.
		-- Retrievable within current system only.
		deferred
		end -- store

	store_one_object(object : ANY;is_exp : BOOLEAN)   is
		-- Write object and its dependences on the media
		-- Unmarked means written on media.
        	deferred
        	end -- store_one_object

	putobject,put_object( o : ANY ) is
		-- Append object o
		deferred
		end -- putobject, put_object


end -- class STORER

--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

