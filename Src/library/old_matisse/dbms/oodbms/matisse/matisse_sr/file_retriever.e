deferred class FILE_RETRIEVER 

inherit

	MEMORY
		export {NONE} all
	end

	RETRIEVER
		redefine anchor
	end

feature -- Access

	retrieve(file_name: like anchor): EXT_STORABLE is
		-- Retrieve object structure, from external
		-- representation previously stored in a file
		-- called `file_name'.
		-- To access resulting object under correct type,
		-- use assignment attempt.
		-- Will raise an exception (code `Retrieve_exception')
		-- if file content is not a `STORABLE' structure.
		-- Will return Void if the file does not exist or
		-- is not readable.
		require else
			file_name_not_void: file_name /= Void
			file_name_not_empty: not file_name.empty
		deferred
		end -- retrieve_from_file

feature {NONE} -- Implementation

	anchor : STRING

end -- class FILE_RETRIEVER

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

