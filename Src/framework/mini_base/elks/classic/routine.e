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

	frozen set_rout_disp (a_rout_disp, a_encaps_rout_disp, a_calc_rout_addr: POINTER;
						  a_routine_id: INTEGER; a_open_map: like open_map;
						  a_is_basic, a_is_target_closed: BOOLEAN; a_written_type_id_inline_agent: INTEGER;
						  a_closed_operands: TUPLE; a_open_count: INTEGER)
			-- Initialize object.
		do
		end

	frozen set_rout_disp_final (a_rout_disp, a_encaps_rout_disp, a_calc_rout_addr: POINTER
						  		a_closed_operands: TUPLE; a_is_target_closed: BOOLEAN; a_open_count: INTEGER)
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
