class S_EXPORT_ALL_I

inherit

	S_EXPORT_I
		redefine
			is_all
		end

feature

	is_all: BOOLEAN is
		do
			Result := true
		end;

	same_as (other: S_EXPORT_I): BOOLEAN is
			-- Is Current same_as `other'?
		do
			Result := other.is_all
		end;

end
