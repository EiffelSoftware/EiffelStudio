indexing

	description:
		"Interface with the Lexical Library classes";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class L_INTERFACE inherit

	METALEX
		rename
			make as metalex_make
		end

feature -- Initialization

	build (doc: INPUT) is
			-- Create lexical analyzer and set `doc'
			-- to be the input document.
		require
			document_exists: doc /= Void
		do
			metalex_make;
			obtain_analyzer;
			make_analyzer;
			doc.set_lexical (analyzer)
		end;

	obtain_analyzer is
			-- Build lexical analyzer.
		deferred
		ensure
			analyzer /= Void
		end

feature {NONE} -- Implementation

	set_separator_type (type: INTEGER) is
			-- Make tokens of type `type' to be separators.
		do
			if analyzer = Void then
				create analyzer.make
			end;
			analyzer.set_separator_type (type)
		end;

end -- class L_INTERFACE

--|----------------------------------------------------------------
--| EiffelParse: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

