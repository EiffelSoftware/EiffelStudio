
indexing

	description: 
		"";
	date: "$Date$";
	revision: "$Revision $"


class E_SHOW_ATTRIBUTES 

inherit

	E_CLASS_FORMAT_CMD

creation

	make, do_nothing

feature -- Access

	criterium (f: E_FEATURE): BOOLEAN is
			-- Criterium for feature `f'
		local
			l_exp_status: EXPORT_NONE_I
			l_bool: BOOLEAN
			l_entities: ARRAY [CONSUMED_ENTITY] 
			l_property: CONSUMED_PROPERTY
			l_count: INTEGER
		do
				-- Only shows attribute. If an attribute is of type NONE
				-- like `Void' in ANY we do not show them.
			if f.type /= Void then
				if current_class.is_true_external and consumed_type /= Void then
						-- .NET class.
					l_exp_status ?= f.export_status
					if l_exp_status = Void then
								-- (i.e NOT an EXPORT_NONE_I).
						l_entities := consumed_type.flat_entities
						from
							l_count := 1
						until
							l_count = l_entities.count or l_bool
						loop
							if 
								l_entities.item (l_count).is_field and
								l_entities.item (l_count).eiffel_name.is_equal (f.name) 
							then
								l_bool := True
							elseif l_entities.item (l_count).is_property then
								l_property ?= l_entities.item (l_count)
								if l_property.getter /= Void then
									if l_property.getter.eiffel_name.is_equal (f.name) then
										l_bool := True
									end
								end
							end
							l_count := l_count + 1
						end
						Result := l_bool
					end
				else
					Result := f.is_attribute and not f.type.is_none
				end
			else
				Result := f.is_attribute and not f.type.is_none
			end				
		ensure then
--			good_criterium: Result = f.is_attribute	and not f.type.is_none
		end
	
end -- class E_SHOW_ATTRIBUTES
