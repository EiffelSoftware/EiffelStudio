indexing

	description: 
		"Undoable command for adding generic data.";
	date: "$Date$";
	revision: "$Revision $"


class ADD_GENERIC_U 

inherit

	ADD_LINKABLE_ELEMENT
		redefine
			data, request_for_data, free_data,
			data_container
		end;

creation

	make, make_with

feature -- Property

	name: STRING is 
		once
			Result := "Add generic"
		end;

feature -- Update

	redo is
			-- Execute command.
		local
			heir_link_list	: LINKED_LIST	[ INHERIT_DATA	]
			client_link_list	: LINKED_LIST	[ CLI_SUP_DATA	]
			heir_link	: INHERIT_DATA
			client_link	: CLI_SUP_DATA
			generic_list	: LINKED_LIST	[ GENERIC_DATA	]
		do
			data_container.generics.extend (data);
			--data_container.set_is_modified_since_last_re;

			heir_link_list	:= data_container.parent_links

			if heir_link_list /= Void
			then
				from	
					heir_link_list.start
				until
					heir_link_list.after
				loop
					heir_link	:= heir_link_list.item
	
					generic_list	:= heir_link.generics
					if generic_list = Void
					then
						!! generic_list.make
					end
					generic_list.extend	( clone	( data	) )
					
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

					generic_list	:= client_link.generics
					if generic_list = Void
					then
						!! generic_list.make
					end
					generic_list.extend	( clone	( data	) )
					
					client_link_list.forth			
				end
			end

			data_container.update_name;
			windows.namer_window.update
			windows.update_class_windows
		end;

	undo is
			-- Cancel effect of executing the command.
		local
			heir_link_list	: LINKED_LIST	[ INHERIT_DATA	]
			client_link_list	: LINKED_LIST	[ CLI_SUP_DATA	]
			heir_link	: INHERIT_DATA
			client_link	: CLI_SUP_DATA
			generic_list	: LINKED_LIST	[ GENERIC_DATA	]
		do
			data_container.generics.start;
			data_container.generics.prune (data);
			--data_container.set_is_modified_since_last_re;			

			heir_link_list	:= data_container.parent_links

			if heir_link_list /= Void
			then
				from	
					heir_link_list.start
				until
					heir_link_list.after
				loop
					heir_link	:= heir_link_list.item
	
					generic_list	:= heir_link.generics

					if generic_list.after
					then
						generic_list.back
					end			

					from
					until 
						generic_list.islast
					loop
						generic_list.forth
					end
					
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

					generic_list	:= client_link.generics

					if generic_list.after
					then
						generic_list.back
					end			

					from
					until 
						generic_list.islast
					loop
						generic_list.forth
					end
					
					generic_list.remove
					
					client_link_list.forth			
				end
			end


			data_container.update_name;
			windows.namer_window.update
			windows.update_class_windows
			
		end

feature -- Element change

	create_data is
			-- Change a generic parameter name.
		local
			generic_name: STRING;
		do
			generic_name := data_container.new_generic_name
			!! data.make	( generic_name	);
		end

feature {NONE} -- Data

	data: GENERIC_DATA;

	data_container: CLASS_DATA;

	request_for_data is do end;

	free_data is do end;	

end -- class ADD_GENERIC_U
