class IO_MEDIUM_USE 

inherit

	MEMORY
		export {NONE} all
		undefine dispose
	end

feature -- Status Setting

	set_media(argument : like media) is
		-- Connect to media
		require
			argument_not_void : argument /= Void
			media_exists: argument.exists;
			media_is_open_write: argument.is_open_write
			media_is_binary: not argument.is_plain_text
		do
			media := argument
		end -- set_media

	unset_media is
		-- Disconnect from media
		do
			media := Void
		end -- unset_media

feature -- Access

	media : IO_MEDIUM

feature {NONE} -- Implementation

	dispose is
		-- Close media
		do
			if media /=Void then media.close end
		end -- dispose

invariant

	file_exists: media /= Void implies media.exists
	file_is_open_write: media /= Void implies media.is_open_write

end -- class IO_MEDIUM_USE

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

