--|---------------------------------------------------------------
--|   Copyright (C) 1993 Interactive Software Engineering, Inc. --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Interface with the Lexical Library classes

indexing

	date: "$Date$";
	revision: "$Revision$"

deferred class L_INTERFACE 

inherit

	METALEX
		rename
			make as metalex_make
		end

feature 

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
		end -- build

feature {NONE}

	set_separator_type (type: INTEGER) is
			-- Make tokens of type `type' to be separators.
		do
			if analyzer = Void then
				!!analyzer.make
			end;
			analyzer.set_separator_type (type)
		end -- set_separator_type

feature 

	obtain_analyzer is
			-- Build lexical analyzer.
		deferred
		ensure
			analyzer /= Void
		end -- obtain_analyzer

end -- class L_INTERFACE
