note
	description: "Objects which holder {SD_DOCKING_MANAGER} instance."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SD_DOCKING_MANAGER_HOLDER

feature -- Command

	set_docking_manager (a_docking_manager: like docking_manager)
			-- Set `docking_manager' with `a_docking_manager'
		require
			not_void: a_docking_manager /= Void
		do
			docking_manager := a_docking_manager
		ensure
			set: is_docking_manager_attached
		end

	clear_docking_manager
			-- Clear `docking_manager'.
		do
				-- Nothing to do.
		end

feature -- Query

	docking_manager: SD_DOCKING_MANAGER
			-- Docking manager instance.

	is_docking_manager_attached: BOOLEAN
			-- If `docking_manager' has been set?
		do
			Result := True
		end

;note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2016, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
