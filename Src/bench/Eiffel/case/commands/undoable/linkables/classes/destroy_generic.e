indexing

	description: 
		"Undoable command for destroying generic data.";
	date: "$Date$";
	revision: "$Revision $"

class DESTROY_GENERIC

inherit

	DESTROY_LIST_ELEMENT
		redefine 
			redo	,
			data	, 
			update	,
 			data_container
		select
			redo	,
			data	,
			update	,
			data_container
	end
		
		

	DESTROY_LIST_ELEMENT
		rename
			redo	as redo_element	,
			data	as data_element	,
			update	as update_element	,
			data_container	as data_container_element		
	end

creation

	make

feature
	--process

	redo is
	local
		heir_link_list	: LINKED_LIST	[ INHERIT_DATA	]
		heir_link	: INHERIT_DATA
		client_link_list	: LINKED_LIST	[ CLI_SUP_DATA	]
		client_link	: CLI_SUP_DATA
		generic_list	: LINKED_LIST	[ GENERIC_DATA	]
		generic_position : INTEGER
	do
		redo_element
		
		heir_link_list	:= data_container.parent_links
		if heir_link_list /= Void
		then
			from	
				heir_link_list.start
			until
				heir_link_list.after
			loop
				heir_link	:= heir_link_list.item

				generic_position := position + 1

				generic_list	:= heir_link.generics
				generic_list.go_i_th	( generic_position	)
				generic_list.remove
				
				heir_link_list.forth			
			end
		end
		
		client_link_list	:= data_container.supplier_links
		if client_link_list /= Void
		then
			from	
				client_link_list.start
			until
				client_link_list.after
			loop
				client_link	:= client_link_list.item

				generic_position := position + 1

				generic_list	:= client_link.generics
				generic_list.go_i_th	( generic_position	)
				generic_list.remove
				
				client_link_list.forth			
			end
		end
		
	end


feature {DESTROY_ENTITIES_U} -- Implementation

	data: GENERIC_DATA;
			-- Generic parameter

	data_container: CLASS_DATA;

	update is
		do
--			data_container.update_name;
--			Windows.update_class_info_in_windows (data_container);
		end;

end -- class DESTROY_GENERIC
