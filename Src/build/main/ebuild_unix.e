class EBUILD_UNIX

inherit
	EBUILD
		redefine
			new_license
		end
	OPERATING_ENVIRONMENT

feature

	new_license: LICENCE is
		do
		io.error.putstring ("FIXME%N")
		io.error.putstring ("FIXME%N")
		io.error.putstring ("FIXME%N")
		io.error.putstring ("%TRemove the call to `get'%N%N");
			!BUILD_LICENCE!Result.make (get("EIFFEL3"))
		end

end
