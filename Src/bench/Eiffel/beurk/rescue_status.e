class RESCUE_STATUS

feature -- Access

	is_error_exception: BOOLEAN

	is_like_exception: BOOLEAN

feature -- Modification

	set_is_error_exception (b: BOOLEAN) is
		do
			is_error_exception := b
		end

	set_is_like_exception (b: BOOLEAN) is
		do
			is_like_exception := b
		end

	is_unexpected_exception: BOOLEAN is
		do
			Result := not (is_error_exception or is_like_exception)
		end

end
