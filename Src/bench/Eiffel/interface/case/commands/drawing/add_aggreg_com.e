indexing

	description: 
		"Command to add an aggregation link in a workarea.";
	date: "$Date$";
	revision: "$Revision $"

class ADD_AGGREG_COM

inherit

	ADD_LINK_COM
	ONCES

feature -- Do we need the New Window to popup ?

	need_n ( b : BOOLEAN ) is
		do
			need_nw := b
		end

	need_nw : BOOLEAN 
		
feature {NONE,SYSTEM_DATA} -- Implementation

	is_clientelism : BOOLEAN

	build_link (workarea: WORKAREA; first_entity, second_entity: LINKABLE_DATA) is
			-- Create a new aggregation link.
		local
			new_link: CLI_SUP_DATA;
			new_aggreg_u: ADD_AGGREG_U;
			add_reverse_link : ADD_REVERSE_LINK_U;
			existing_link : CLI_SUP_DATA;
			temp,temp2 : CLASS_DATA;
--			nw: NEW_WINDOW;
		do
			if first_entity /= second_entity then
				existing_link := workarea.straight_clientele_link_between
							(first_entity, second_entity);
				if existing_link /= Void then
					if not existing_link.is_reverse_link then
						!!add_reverse_link.make (existing_link, True)
						temp ?= first_entity
						temp2 ?= second_entity
						if temp /= Void and temp2 /= void then
							if not need_nw then	
						--	!! nw.make(workarea.analysis_window.screen,temp,temp2)
						--	nw.set_new_aggreg(new_aggreg_u,existing_link)
						--	nw.set_aggregation
							end
						end
					end
				else
					if first_entity.is_cluster or else
						second_entity.is_cluster
					then
						! COMP_CLI_SUP_DATA ! new_link.make_aggreg (first_entity, second_entity);
					else
						!! new_link.make_aggreg (first_entity, second_entity);
					end;
					!!new_aggreg_u.make (new_link)
                    temp ?= first_entity
                    temp2 ?= second_entity
                    if temp /= Void then
                        if temp2 /= Void then
							if not need_nw then	
                          --  !! nw.make(workarea.analysis_window.screen,temp,temp2)
                          --  nw.set_new_aggreg(new_aggreg_u,new_link)
						--	nw.set_aggregation
							end
                        else
                     --       Windows.add_message("Imposssible to open the window",1)
                        end
					else
					--	Windows.add_message("Impossible to open the window",1)	
					end

				end
			end
		end -- build_link

end -- class ADD_AGGREG_COM
