indexing

	description: 
		"Command to add a client-supplier link in a workarea.";
	date: "$Date$";
	revision: "$Revision $"

class ADD_CLI_SUP_COM 

inherit

	ADD_LINK_COM

	CONSTANTS;
	ONCES


feature -- Do we need the New Window to popup ? 
	
	need_n (b: BOOLEAN) is
		do
			need_nw := b
		end

	need_nw : BOOLEAN
		-- do we need to popup new window ?

feature {NONE, ADD_RECURSIVE_COM, TYPE_DEC_STONE, SYSTEM_DATA} -- Implementation

	is_clientelism : BOOLEAN is
		do
			Result := TRUE 
		end

	build_link (workarea: WORKAREA; first_entity, second_entity: LINKABLE_DATA) is
			-- Create a new association link.
		local
		--	add: ADD_FEATURE_U --added
		--	ff: FEATURE_DATA; -- added
			temp,temp2 : CLASS_DATA; --added
		--	ind  : INDEX_DATA --added
		--	ad_ind: ADD_INDEX_U --added
			new_link: CLI_SUP_DATA;
			--new_client_u: ADD_CLIENT_U;
			new_reflexive_u : ADD_REFLEXIVE_U;
			add_reverse_link : ADD_REVERSE_LINK_U;
			existing_link : CLI_SUP_DATA;	
			win: EC_RELATION_WINDOW
		--	nw: NEW_WINDOW
		do
			-- Treatment
			if first_entity /= second_entity then
				existing_link := workarea.straight_clientele_link_between
							(first_entity, second_entity);
				if existing_link /= Void then
					if not existing_link.is_reverse_link then
						!!add_reverse_link.make (existing_link, False)
						temp ?= first_entity
						temp2 ?= second_entity
						if temp /= void and temp2 /= void
							then
								if not need_nw then 
							--	 nw.set_new_client(new_client_u,existing_link)
							--	!! nw.make(workarea.analysis_window.screen,temp,temp2)
								end	
						end
					end
				else
					if first_entity.is_cluster or else
						second_entity.is_cluster
					then
						! COMP_CLI_SUP_DATA ! new_link.make_ref
								(first_entity, second_entity)
					else
						!!new_link.make_ref (first_entity, second_entity);
					end;
					!!new_client_u.make (new_link)

					temp ?= first_entity
					temp2 ?= second_entity
					if temp /= Void then
						if temp2 /= Void then 
							if not need_nw then
							--	!! nw.make(workarea.analysis_window.screen,temp,temp2)
							--	nw.set_new_client(new_client_u,new_link)
							end
						end
					else
					--	Windows.add_message("Impossible to open the window",1)
					end
				end	
			else
				if first_entity.client_link_of (first_entity) = Void then
					if first_entity.is_cluster or else
						second_entity.is_cluster
					then
						--!!nw.make(workarea.analysis_window.screen,temp,temp2)

						! COMP_CLI_SUP_DATA ! new_link.make_reflexive
								(first_entity)
					else
					--	!!nw.make(workarea.analysis_window.screen,temp, temp2)
					!!new_link.make_reflexive (first_entity);
					end;
					!!new_reflexive_u.make (new_link)
				else
				--	Windows.error (workarea.analysis_window, Message_keys.another_reflexive_link_er, Void);
				end
			end
			if new_link /= Void then
					if System.str_client then
						straight_link(first_entity,second_entity, new_link)
				end
			end
		end

end -- class ADD_CLI_SUP_COM
