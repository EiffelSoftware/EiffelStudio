indexing
	description: "Platform specific constants.";
	date: "$Date$";
	revision: "$Revision$"

class
	PLATFORM_CONSTANTS

inherit
	OPERATING_ENVIRONMENT

feature -- Access

	Driver: STRING is
			-- Name of `driver' executable used to execute melted code.
		once
			if is_windows then
				create Result.make (15)
				Result.append ((create {EIFFEL_ENV}).Eiffel_c_compiler)
				Result.append ("\driver.exe")
			elseif is_vms then
				Result := "driver.exe"
			else
				Result := "driver"
			end
		end

	Executable_suffix: STRING is
			-- Platform specific executable extension.
		once
			if not is_unix then
				Result := "exe"
			else
				Result := ""
			end
		end

	Finish_freezing_script: STRING is "finish_freezing"
			-- Name of post-eiffel compilation processing to launch
			-- C code.

	Preobj: STRING is
			-- Name of C library used in precompiled library.
		once
			if is_windows then
				Result := "precomp.lib"
			elseif is_unix then
				Result := "preobj.o"
			else
				Result := "preobj.olb"
			end
		end

	is_unix: BOOLEAN is
			-- Is it a Unix platform?
		once
			Result := not (is_vms or is_windows)
		end

	is_vms: BOOLEAN is
			-- Is the platform VMS?
		external
			"C"
		alias
			"eif_is_vms"
		end

	is_windows: BOOLEAN is
			-- Is the platform a windows platform?
		external
			"C"
		alias
			"eif_is_windows"
		end

end -- class PLATFORM_CONSTANTS
