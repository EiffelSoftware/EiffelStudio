indexing
	description: "Update the Text Field when an Element is Selected"
	date: "$Date$"
	revision: "$Revision$"

class
	SELEC_COM_ACE

inherit
	EV_COMMAND

creation
	make

feature -- Initialization

	make ( l: like list; ace : like ace_w ) is
			-- Initialize
		do
			list := l
			ace_w := ace
		end

feature -- Properties

	ace_w : EC_ACE_WINDOW

	list: EV_LIST

feature {NONE} -- Implementation

execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
	local
		elem : SCROLL_ELEMENT_FOR_ACE
	do
		elem ?= list.selected_item
		if elem/= Void then
			
			if ace_w /= Void then 
					if elem.cluster_data.is_root or else
					elem.cluster_data.parent_cluster.is_root then
			--		ace_w.set_tf ( elem.cluster_data.reversed_engineered_file_name)
				else
			--		ace_w.set_tf ( elem.cluster_data.file_name )
				end
	
				ace_w.update_browse_b
			end
			
		end
	end

end -- class SELEC_COM_ACE
