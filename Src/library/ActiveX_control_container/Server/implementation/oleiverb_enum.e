indexing
	description: "[
			A verb is an action that an OLE object takes in response 
			to a message from its container. An object's container, 
			or a client linked to the object, normally calls 
			IOleObject::DoVerb in response to some end-user 
			action, such as double-clicking on the object. 
			The various actions that are available for a given 
			object are enumerated in an OLEVERB structure, which 
			the container obtains by calling IOleObject::EnumVerbs. 
			IOleObject::DoVerb matches the value of iVerb against 
			the iVerb member of the structure to determine which 
			verb to invoke. 
			OLE 2 defines seven verbs that are available, but not 
			necessarily useful, to all objects. In addition, each 
			object can define additional verbs that are unique to it. 
			]"
	date: "$Date$"
	revision: "$Revision$"


class
	OLEIVERB_ENUM
	
feature -- Access

	Oleiverb_primary           : INTEGER is  0
			-- Specifies the action that occurs when an end 
			-- user double-clicks the object in its container. 
			-- The object, not the container, determines 
			-- this action. If the object supports in-place 
			-- activation, the primary verb usually activates 
			-- the object in place.
	
	Oleiverb_show              : INTEGER is  -1
			-- Instructs an object to show itself for editing 
			-- or viewing. Called to display newly inserted 
			-- objects for initial editing and to show link 
			-- sources. Usually an alias for some other 
			-- object-defined verb.
	
	Oleiverb_open              : INTEGER is  -2
			-- Instructs an object, including one that otherwise 
			-- supports in-place activation, to open itself for 
			-- editing in a window separate from that of its 
			-- container. If the object does not support 
			-- in-place activation, this verb has the same 
			-- semantics as OLEIVERB_SHOW.
	
	Oleiverb_hide              : INTEGER is  -3
			-- Causes an object to remove its user interface 
			-- from the view. Applies only to objects that 
			-- are activated in-place.
	
	Oleiverb_uiactivate        : INTEGER is  -4
			-- Activates an object in place, along with 
			-- its full set of user-interface tools, 
			-- including menus, toolbars, and its name 
			-- in the title bar of the container window. 
			-- If the object does not support in-place 
			-- activation, it should return E_NOTIMPL.
	
	Oleiverb_inplaceactivate   : INTEGER is  -5
			-- Activates an object in place without displaying 
			-- tools, such as menus and toolbars, that end 
			-- users need to change the behavior or appearance 
			-- of the object. Single-clicking such an object 
			-- causes it to negotiate the display of its 
			-- user-interface tools with its container. 
			-- If the container refuses, the object remains 
			-- active but without its tools displayed.
	
	Oleiverb_discardundostate  : INTEGER is  -6
			-- Used to tell objects to discard any undo 
			-- state that they may be maintaining without 
			-- deactivating the object. 

end -- class OLEIVERB_ENUM
