indexing
	description: "Information on a Rose diagram for XMI Export"
	date: "$Date$"
	revision: "$Revision$"

class
	XMI_DIAGRAM

inherit
	XMI_ITEM

create 
	make,
	make_as_root

feature --Initialization

	make (id: INTEGER; c: XMI_CLUSTER) is
			-- Initialization of `Current'.
		do
			xmi_id := id
			associated_cluster := c
			is_root := false
			create xmi_presentations.make
		end

	make_as_root (id: INTEGER; idref: INTEGER) is
			-- Initialization of `Current' as the root diagram in Rose.
		do
			xmi_id := id
			id_model := idref
			is_root := true
			create xmi_presentations.make
		end

feature -- Access

	xmi_presentations: LINKED_LIST [XMI_PRESENTATION]
		-- XMI representations of the classes included in `Current'.

	associated_cluster: XMI_CLUSTER
		-- Cluster from which `Current' is the diagram
		-- Void if `is_root'.

	id_model: INTEGER
		-- Number identifying the model including `Current'
		-- Void if not `is_root'.

feature -- Status report

	is_root: BOOLEAN
		-- Is `Current' root diagram in the XMI representation?

feature -- Element change

	add_presentation (r: XMI_PRESENTATION) is
			-- Adds `r' to `xmi_presentations'.
		require
			new_presentation_not_void: r /= Void
		do
			xmi_presentations.extend (r)
		ensure
			new_presentation_added: xmi_presentations.has (r)
		end

feature -- Actions

	code: STRING is
			-- XMI representation of the diagram.	
		do
			if is_root then
				Result := "<UISModelElement xmi.id = 'G."
				Result.append (id_model.out)
				Result.append ("'>%N%
					% <uisOwnedDiagram>%N%
					%  <UISDiagram xmi.id = 'S.")
				Result.append (xmi_id.out)
				Result.append ("'>%N%
					%  <uisDiagramName>Main</uisDiagramName>%N%
					%  <uisToolName>Rational Rose 98</uisToolName>%N%
					%  <uisDiagramStyle>ClassDiagram</uisDiagramStyle>%N%
					%  <uisDiagramPresentation>%N")
				
				from
					xmi_presentations.start
				until
					xmi_presentations.after
				loop
					Result.append (xmi_presentations.item.code)
					xmi_presentations.forth
				end
				
				Result.append ("  </uisDiagramPresentation>%N%
					%	</UISDiagram>%N%
					%	<UISDiagram xmi.id = 'S.")
				Result.append ((xmi_id + 1).out) --| FIXME: could be nicer.
				Result.append ("'>%N%
      				%    <uisDiagramName>Main</uisDiagramName>%N%
        				%	 <uisToolName>Rational Rose 98</uisToolName>%N%
         				%		<uisDiagramStyle>ModuleDiagram</uisDiagramStyle>%N%
					% 	 </UISDiagram>%N%
					%	</uisOwnedDiagram>%N%
					%	</UISModelElement>%N")
			else
				Result := "<UISModelElement xmi.id = 'G."
				Result.append (associated_cluster.id_extender.out)
				Result.append ("'>%N%
					% <uisOwnedDiagram>%N%
					%  <UISDiagram xmi.id = 'S.")
				Result.append (xmi_id.out)
				Result.append ("'>%N%
					%  <uisDiagramName>Main</uisDiagramName>%N%
					%  <uisToolName>Rational Rose 98</uisToolName>%N%
					%  <uisDiagramStyle>ClassDiagram</uisDiagramStyle>%N%
					%  <uisDiagramPresentation>%N")

				from
					xmi_presentations.start
				until
					xmi_presentations.after
				loop
					Result.append (xmi_presentations.item.code)
					xmi_presentations.forth
				end
				
				Result.append ("  </uisDiagramPresentation>%N%
					% 	 </UISDiagram>%N%
					%	</uisOwnedDiagram>%N%
					%	</UISModelElement>%N")
			end
		end	

end -- class XMI_DIAGRAM

