
class RESCUE_STATUS

feature

	is_error_exception: BOOLEAN;

	set_is_error_exception (b: BOOLEAN) is
		do
			is_error_exception := b
		end;

	is_like_exception: BOOLEAN;

	set_is_like_exception (b: BOOLEAN) is
		do
			is_like_exception := b
		end;

	is_unexpected_exception: BOOLEAN is
		do
			Result := 
				not (is_error_exception or is_like_exception)
		end;

	fail_on_rescue: BOOLEAN;

	set_fail_on_rescue (b: BOOLEAN) is
		do
debug
	io.error.putstring ("Rescue_status.set_fail_on_rescue: ");
	io.error.putbool (b);
	io.error.new_line;
end;
			fail_on_rescue := b
		end;

end
