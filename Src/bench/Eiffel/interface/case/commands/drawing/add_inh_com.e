indexing

	description: 
		"Command to add an inheritance link in a workarea.";
	date: "$Date$";
	revision: "$Revision $"

class ADD_INH_COM

inherit

	ADD_LINK_COM;
	
feature {NONE, SYSTEM_DATA} -- Implementation

	is_clientelism : BOOLEAN

	build_link (workarea: WORKAREA; first_entity, second_entity: LINKABLE_DATA) is
			-- Create a new inherit link.
		local
			new_link: INHERIT_DATA;
			new_inherit_u: ADD_INHERIT_U;
		do
			if first_entity /= second_entity then
				if first_entity.is_cluster or else 
					second_entity.is_cluster
				then
					! COMP_INHERIT_DATA ! new_link.make 
							(first_entity, second_entity);
				else
					!!new_link.make (first_entity, second_entity);
				end
				!!new_inherit_u.make (new_link)
				if System.str_inh then
						straight_link(first_entity,second_entity, new_link)
				end
			end
		end 
			

end -- class ADD_INH_COM
