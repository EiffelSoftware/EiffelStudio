class S_EXPORT_NONE_I

inherit

	S_EXPORT_I
		redefine
			is_none
		end

feature

	is_none: BOOLEAN is
		do
			Result := true
		end;

	same_as (other: S_EXPORT_I): BOOLEAN is
			-- Is Current same_as `other'?
		do
			Result := other.is_none
		end;

end
