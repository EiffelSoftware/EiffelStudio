
class BUILD_LIC

feature

	licence: ISE_LICENCE is
		once
			!!Result.make (build_dir);
		end;

	build_dir: STRING is
		do
		end;

end
