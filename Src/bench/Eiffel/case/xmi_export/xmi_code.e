indexing
	description: "XMI code constants"
	date: "$Date$"
	revision: "$Revision$"

class
	XMI_CODE

create
	make

feature --Initialization

	make is 
			-- Initialize the constant elements of code.
	do
		header := "<?xml version = '1.0' encoding = %'UTF-8%' ?>%N%
			%<!DOCTYPE XMI SYSTEM 'uml.dtd' [%N%
			%<!ELEMENT uisToolName (#PCDATA)>%N%
			%<!ELEMENT uisDiagramName (#PCDATA)>%N%
			%<!ELEMENT uisDiagramStyle (#PCDATA)>%N%
			%<!ELEMENT uisDiagramPresentation (Foundation.Auxiliary_Elements.Presentation*)>%N%
			%<!ELEMENT UISDiagram (uisDiagramName, uisToolName, uisDiagramStyle, uisDiagramPresentation*)>%N%
			%<!ATTLIST UISDiagram xmi.id ID #REQUIRED>%N%
			%<!ELEMENT uisOwnedDiagram (UISDiagram*)>%N%
			%<!ELEMENT UISModelElement (uisOwnedDiagram*)>%N%
			%<!ATTLIST UISModelElement xmi.id ID #REQUIRED>%N%
			%<!ENTITY bs %"&#38;#08;%">%N%
			%<!ENTITY vt %"&#38;#11;%">%N%
			%<!ENTITY ff %"&#38;#12;%">%N%
			%]>%N%
			%<XMI xmi.version = '1.0'>%N%
			%  <XMI.header>%N%
			%    <XMI.documentation>%N%
			%      <XMI.exporter>ISE EiffelBench</XMI.exporter>%N%
			%      <XMI.exporterVersion>4.6</XMI.exporterVersion>%N%
			%    </XMI.documentation>%N%
			%    <XMI.metamodel xmi.name = 'UML' xmi.version = '1.1'/>%N%
			%  </XMI.header>%N"

		content_end := "       </Foundation.Core.Namespace.ownedElement>%N%
    		%</Model_Management.Model>  %N%
		    %</XMI.content>%N"

		file_end := "</XMI>%N"

		extensions_start := "<XMI.extensions xmi.extender = 'ISE EiffelBench'>%N"

		extensions_end := "</XMI.extensions>%N"
	end

feature -- Access

	header: STRING 
			-- Header code of the XMI file.	

	content_start (idref: INTEGER): STRING is
			-- Code of the beginning of the XMI file content.
		require
			ref_consistent: idref > 0
		do
			Result := "<XMI.content>%N%
				%    <Model_Management.Model xmi.id = 'G.1'>%N%
				%     <Foundation.Core.ModelElement.name>empty</Foundation.Core.ModelElement.name>%N%
				%      <Foundation.Core.ModelElement.visibility xmi.value = 'private'/>%N%
				%      <Foundation.Core.GeneralizableElement.isRoot xmi.value = 'false'/>%N%
				%      <Foundation.Core.GeneralizableElement.isLeaf xmi.value = 'false'/>%N%
				%      <Foundation.Core.GeneralizableElement.isAbstract xmi.value = 'false'/>%N%
				%      <XMI.extension xmi.extender = 'ISE EiffelBench'>%N%
				%        <XMI.reference xmi.idref = 'G."
			Result.append (idref.out)
			Result.append ("'/>%N%
				%      </XMI.extension>%N%
				%      <Foundation.Core.Namespace.ownedElement>%N")
		ensure
			result_not_void: Result /= Void
		end

	content_end: STRING
			-- Code of the end of the XMI file content.

	file_end: STRING
			-- Code of the end of the XMI file.

	extensions_start: STRING
			-- Code of the beginning of the XMI file extensions.

	extensions_end: STRING
			-- Code of the end of the XMI file extensions.

end -- class XMI_CODE
