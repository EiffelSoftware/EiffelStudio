class STORE_HANDLE
 
feature -- Access

	storer :  CELL[STORER] is once !!Result.put(Void) end

	retriever : CELL[RETRIEVER] is once !!Result.put(Void) end

feature {NONE} -- Access

	basic_storer : BASIC_STORER32 is once !!Result.make(1024) end    

	matisse_storer : MATISSE_STORER is once !!Result end

	basic_retriever : BASIC_RETRIEVER is once !!Result end

	matisse_retriever : MATISSE_RETRIEVER is once !!Result end

feature -- Status Setting

	-- Files
	set_basic_store is do storer.put(basic_storer) end

	-- Databases
	set_matisse_storer is do storer.put(matisse_storer) end -- set_matisse_storer
	set_matisse_retriever is do retriever.put(matisse_retriever) end -- set_matisse_retriever

end -- class STORE_HANDLE

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

