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
			!BUILD_LICENCE!Result.make (Environment.get(Eiffel_variable_name))
		end

end
