indexing
	description: "Visible clause writer"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_WRITER_VISIBLE_CLAUSE

inherit
	WIZARD_WRITER

create
	make

feature -- Initialization

	make is
			-- Initialize
		do
			create {LINKED_LIST [STRING]} exported_features.make
		end

feature -- Access

	generated_code: STRING is
			-- Generated code
		do
			create Result.make (100)
			Result.append (Tab_tab_tab)
			Result.append (name)
			if not exported_features.is_empty then
				Result.append (New_line)
				Result.append (Tab_tab_tab)
				Result.append (tab)
				Result.append (Export_keyword)
				Result.append (New_line)
				from
					exported_features.start
				until
					exported_features.after
				loop
					Result.append (Tab_tab_tab)
					Result.append (Tab_tab)
					Result.append (Double_quote)
					Result.append (exported_features.item)
					Result.append (Double_quote)
					exported_features.forth
					if not exported_features.after then
						Result.append (Comma)
					end
					Result.append (New_line)
				end
				Result.append (Tab_tab_tab)
				Result.append (tab)
				Result.append (End_keyword)
			end
			Result.append (Semicolon)
			Result.append (New_line)
		end

	can_generate: BOOLEAN is
			-- Can code be generated?
		do
			Result := name /= Void and then not name.is_empty
		end

	name: STRING
			-- Class name.

	exported_features: LIST [STRING]
			-- Exported features.


feature -- Element change

	set_name (a_name: like name) is
			-- Set `name' with `a_name'.
		do
			name := clone (a_name)
		ensure
			name_set: name.is_equal (a_name)
		end

	add_feature (a_feature: STRING) is
			-- Add `a_feature to `exported_features'.
		require
			non_void_feature: a_feature /= Void
			valid_feature: not a_feature.is_empty
		do
			exported_features.extend (clone (a_feature))
		ensure
			added: exported_features.last.is_equal (a_feature)
		end

invariant
	non_void_features: exported_features /= Void

end -- class WIZARD_WRITER_VISIBLE_CLAUSE

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1988-1999 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support http://support.eiffel.com
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
