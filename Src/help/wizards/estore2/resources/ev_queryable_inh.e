	QUERYABLE
		redefine
			out
		end
<FL_DECL_INH_END>
	get_feature_value (attr: STRING): STRING is
			-- Return the value of the attribute 'attr' if it exists. Otherwise, return Void.
		do
			if attr.is_equal ("<FIRST_ATTR_NAME>") then
				Result := <FIRST_ATTR_NAME>.out
<ELSEIF_GET>			else
				Result := Void
			end
		end

	set_feature_value (attr, value: STRING) is
			-- Set to 'value' the value of the attribute 'attr' if it exists.
		local
				-- Useful if an attribute has type 'date_time'.
			dt: DATE_TIME
		do
			if attr.is_equal ("<FIRST_ATTR_NAME>") then
<FOR_DATE_TIME
>				<FIRST_ATTR_NAME> := <VALUE><CONVERSION>
<ELSEIF_SET>			end
		end
