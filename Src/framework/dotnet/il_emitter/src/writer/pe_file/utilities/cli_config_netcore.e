note
	description: "Optional Header NetCore constants for Net version greater than or equal 6"
	date: "$Date$"
	revision: "$Revision$"

class
	CLI_CONFIG_NETCORE

feature -- Constants

	major_linked_version: INTEGER_8 = 48
		-- 0x30 in hex

feature -- Image DLL Characteristics

	HIGH_ENTROPY_VA: INTEGER_16 = 0x0020
			-- Image can handle a high entropy 64-bit virtual address space.

	DYNAMIC_BASE: INTEGER_16 = 0x0040
			-- DLL can be relocated at load time.

	FORCE_INTEGRITY: INTEGER_16 = 0x0080
			-- Code Integrity checks are enforced.

	NX_COMPAT: INTEGER_16 = 0x0100
			-- Image is NX compatible.

	NO_ISOLATION: INTEGER_16 = 0x0200
			-- Isolation aware, but do not isolate the image.

	NO_SEH: INTEGER_16 = 0x0400
			-- Does not use structured exception (SE) handling.
			-- No SE handler may be called in this image.

	NO_BIND: INTEGER_16 = 0x0800
			-- Do not bind the image.

	APPCONTAINER: INTEGER_16 = 0x1000
			-- Image must execute in an AppContainer.

	WDM_DRIVER: INTEGER_16 = 0x2000
			-- A WDM driver.

	GUARD_CF: INTEGER_16 = 0x4000
			-- Image supports Control Flow Guard.

	TERMINAL_SERVER_AWARE: INTEGER_16 = 0x8000
			-- Terminal Server aware.


	default_dll_characteristics: INTEGER_16
		do
			Result := high_entropy_va | dynamic_base | nx_compat | no_seh | terminal_server_aware
		ensure
			is_class: class
		end

end
