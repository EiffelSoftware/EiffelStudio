indexing
	description: "Helper functions using .NET reflection"
	date: "$Date$"
	revision: "$Revision$"

class
	REFLECTION

feature -- Status Report

	is_consumed_type (t: TYPE): BOOLEAN is
			-- Is `t' a public CLS compliant type?
		local
			parent_name: SYSTEM_STRING
			parent_type: TYPE
		do
			if is_cls_compliant (t) then
				Result := t.is_public
				if not Result then
					if t.is_nested_public or t.is_nested_family or t.is_nested_fam_orassem then
						parent_name := t.full_name
						parent_name := parent_name.substring_integer_integer (0, parent_name.index_of_character ('+'))
						parent_type := t.assembly.get_type_string (parent_name)
						Result := parent_type /= Void and then parent_type.is_public
					end
				end
			end
		end

	is_consumed_method (m: METHOD_BASE): BOOLEAN is
			-- Is `m' a public/family CLS compliant method?
		do
			Result := (m.is_public or m.is_family or m.is_family_or_assembly) and
						is_cls_compliant (m)
		end

	is_consumed_field (f: FIELD_INFO): BOOLEAN is
			-- Is `f' a public/family CLS compliant field?
		do
			Result := (f.is_public or f.is_family or f.is_family_or_assembly) and
						is_cls_compliant (f)
		end

	is_cls_compliant (member: MEMBER_INFO): BOOLEAN is
			-- 	Is `member' CLS compliant?
		local
			ca: CLSCOMPLIANT_ATTRIBUTE
		do
			ca ?= feature {ATTRIBUTE}.get_custom_attribute_member_info_type (member, Cls_compliant_attribute_type)
			Result := ca = Void or else ca.is_compliant
		end

	is_public_static_field (a_field: FIELD_INFO): BOOLEAN is
			-- Is `a_field' public and static?
		do
			Result := a_field.is_public and a_field.is_static
		end
		
feature {NONE} -- Implementation

	cls_compliant_attribute_type: TYPE is
			-- typeof (System.CLSCompliantAttribute)
		once
			Result := feature {TYPE}.get_type_string (("System.CLSCompliantAttribute").to_cil)
		end

end -- class REFLECTION
