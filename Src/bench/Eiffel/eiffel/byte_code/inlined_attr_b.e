class INLINED_ATTR_B

inherit
	ATTRIBUTE_B
		redefine
			enlarged
		end

feature

	fill_from (a: ATTRIBUTE_B) is
		do
			parent := a.parent
			attribute_name := a.attribute_name;
			attribute_id := a.attribute_id;
			type := a.type;
		end

	enlarged: INLINED_ATTR_B is
		do
			Result := Current
		end

end
