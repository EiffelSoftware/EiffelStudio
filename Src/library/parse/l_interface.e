indexing

	description:
		"Interface with the Lexical Library classes"
	legal: "See notice at end of class.";

	status: "See notice at end of class.";
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class L_INTERFACE

