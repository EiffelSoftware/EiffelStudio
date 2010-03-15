note
	description: "[
					Diff facilities used for comparing strings
					Facade for Diff library
																					]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EQA_DIFF_UTILITY

create
	make

feature {NONE} -- Initialization

	make
			-- Creation method
		do
			create diff
		end

feature -- Command

	compare (a_src, a_dst: ARRAY [STRING_GENERAL])
			-- Compare stings in `a_src' and `a_dst'
		do
			diff.set (a_src, a_dst)
			diff.compute_diff
		end

feature -- Query

	is_ready: BOOLEAN
			-- If Current ready for query `differing_lines'?
		do
			Result := diff.values_set
		end

	differing_lines: LINKED_LIST [LIST [STRING_32]]
			-- Show differing lines between source and destination strings
		require
			ready: is_ready
		local
			l_result: detachable like differing_lines
		do
			check not_implemented: False end
			check l_result /= Void end
			Result := l_result
		end

feature {NONE} -- Implementation

	diff: DIFF [STRING_GENERAL]
			-- Diff utility

;note
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
