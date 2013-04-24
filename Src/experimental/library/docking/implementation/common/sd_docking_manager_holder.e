note
	description: "[
					Objects which holder {SD_DOCKING_MANAGER} instance
																						]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_DOCKING_MANAGER_HOLDER

feature -- Command

	set_docking_manager (a_docking_manager: like internal_docking_manager)
			-- Set `internal_docking_manager' with `a_docking_manager'
		require
			not_void: a_docking_manager /= Void
		do
			internal_docking_manager := a_docking_manager
		ensure
			set: is_docking_manager_attached
		end

	clear_docking_manager
			-- Clear `internal_docking_manager'
		do
			internal_docking_manager := Void
		ensure
			cleared: not is_docking_manager_attached
		end

feature -- Query

	docking_manager: SD_DOCKING_MANAGER
			-- Attached {SD_DOCKING_MANAGER}
		require
			set: is_docking_manager_attached
		local
			l_result: like internal_docking_manager
		do
			l_result := internal_docking_manager
			check l_result /= Void end -- Implied by precondition `set'
			Result := l_result
		ensure
			not_void: Result /= Void
		end

	is_docking_manager_attached: BOOLEAN
			-- If `internal_docking_manager' has been set?
		do
			Result := internal_docking_manager /= Void
		end

feature {NONE} -- Implementation

	internal_docking_manager: detachable SD_DOCKING_MANAGER
			-- Docking manager instance holder

;note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2009, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
