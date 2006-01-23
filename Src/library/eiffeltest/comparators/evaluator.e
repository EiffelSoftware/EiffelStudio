indexing
	description:
		"Evaluators for test steps"
	legal: "See notice at end of class."

	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class EVALUATOR inherit

	CALLBACK
		rename
			callback as test_step, set_callback as set_test_step
		end

feature -- Access

	name: STRING
			-- Name of evaluator

feature -- Status report

	is_setup_ok: BOOLEAN is
			-- Is evaluator set up?
		do
			Result := name /= Void and then not name.is_empty
		end

	is_true: BOOLEAN is
			-- Does evaluator yield true?
		require
			setup_ok: is_setup_ok
		deferred
		end
	 
feature -- Status setting

	set_name (s: STRING) is
			-- Set name to `s'.
		require
			non_empty_name: s /= Void and then not s.is_empty
		do
			name := s
		ensure
			name_set: name = s
		end

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




end -- class EVALUATOR

