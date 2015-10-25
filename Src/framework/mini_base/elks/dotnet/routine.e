note
	description: "[
		Objects representing delayed calls to a routine,
		with some operands possibly still open
		]"
	library: "Free implementation of ELKS library"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ROUTINE [OPEN_ARGS -> detachable TUPLE create default_create end]

feature {NONE} -- Implementation

	frozen open_map: detachable ARRAY [INTEGER]
			-- Index map for open arguments

	frozen set_rout_disp (handle: RUNTIME_METHOD_HANDLE; closed_args: TUPLE;
						  omap: ARRAY [INTEGER]; a_is_inline_agent: BOOLEAN)
			-- Initialize object.
		do
		end

note
	copyright: "Copyright (c) 1984-2015, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
