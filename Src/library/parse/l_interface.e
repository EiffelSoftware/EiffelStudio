note

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

	build (doc: INPUT)
			-- Create lexical analyzer and set `doc'
			-- to be the input document.
		require
			document_exists: doc /= Void
		do
			metalex_make;
			obtain_analyzer;
			make_analyzer
				-- Per postcondition of `make_analyzer'
			check attached analyzer as l_analyzer then
				doc.set_lexical (l_analyzer)
			end
		end;

	obtain_analyzer
			-- Build lexical analyzer.
		deferred
		ensure
			analyzer /= Void
		end

feature {NONE} -- Implementation

	set_separator_type (type: INTEGER)
			-- Make tokens of type `type' to be separators.
		local
			l_analyzer: like analyzer
		do
			l_analyzer := analyzer
			if l_analyzer = Void then
				create l_analyzer.make
				analyzer := l_analyzer
			end;
			l_analyzer.set_separator_type (type)
		end;

note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class L_INTERFACE

