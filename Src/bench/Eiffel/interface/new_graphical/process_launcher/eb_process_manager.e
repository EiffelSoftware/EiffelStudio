indexing
	description: "Object that manages freezing and finalizing c compilation"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_PROCESS_MANAGER

create
	make

feature{NONE} -- Initialization

	make (a_freezor, a_finalizor: EB_C_COMPILER_LAUNCHER; a_external: EB_EXTERNAL_LAUNCHER) is
			-- Initialize using freezing launcher `freezor',
			-- finalizing launcher `finalizor' and external command launcher `a_external'.
		require
			a_freezor_not_void: a_freezor /= Void
			a_finalizor_not_void: a_finalizor /= Void
			a_external_not_void: a_external /= Void
		do
			freezor := a_freezor
			finalizor := a_finalizor
			externalor := a_external
		ensure
			freezor_set: freezor = a_freezor
			finalizor_set: finalizor = a_finalizor
			externalor_set: externalor = a_external
		end

feature -- Status reporting

	is_c_compilation_running: BOOLEAN is
			-- Is either `freezor' or `finalizor' running, or both?
		do
			Result := freezor.is_running or finalizor.is_running
		end

	is_external_command_running: BOOLEAN is
			-- Is external command running?
		do
			Result := externalor.is_running
		end

	is_process_running: BOOLEAN is
			-- Is either `freezor', `finalizor' or `externalor' running, or all?
		do
			Result := is_c_compilation_running or is_external_command_running
		end

feature{NONE} -- Implementation

	freezor: EB_C_COMPILER_LAUNCHER
			-- Freezing launcher

	finalizor: EB_C_COMPILER_LAUNCHER
			-- Finalizing launcher

	externalor: EB_EXTERNAL_LAUNCHER

invariant

	freezor_not_void: freezor /= Void
	finalizor_not_void: finalizor /= Void
	externalor_not_void: externalor /= Void

end
