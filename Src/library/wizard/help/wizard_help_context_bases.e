indexing
	description: "Base addresses for help contexts URLs"

class
	WIZARD_HELP_CONTEXT_BASES

feature -- Access
			
	Root_index: STRING is "index.html"
			-- Default help file for a given base

	url_extension: STRING is ".html"
			-- URL extension

feature -- Status Report

	is_valid_url (a_url: STRING): BOOLEAN is
			-- Does `a_url' have a valid URL syntax?
		local
		--	i: INTEGER
		do
			Result := True
		--	from
		--		i := 1
		--		Result := a_url /= Void and then a_url.count > url_extension.count
		--	until
		--		i > (a_url.count - url_extension.count) or not Result
		--	loop
		--		Result := Result and ((a_url.item (i) > 'A' and a_url.item (i) < 'z') or a_url.item (i) = '/' or a_url.item (i) = ':')
		--		i := i + 1
		--	end
		--	Result := Result and then (a_url.substring (a_url.count - url_extension.count + 1, a_url.count).is_equal (url_extension) or (a_url.has ('#') and a_url.substring (a_url.index_of ('#', 1) - url_extension.count, a_url.index_of ('#', 1) - 1 ).is_equal (url_extension)))
		end
			
end -- class WIZARD_HELP_CONTEXT_BASES

--|----------------------------------------------------------------
--| EiffelWizard: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

