indexing
	description: "XMI code constants"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	XMI_CODE

inherit
	EIFFEL_ENV

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
				%      <XMI.exporter>"
			header.append (workbench_name)
			header.append ("</XMI.exporter>%N%
				%      <XMI.exporterVersion>")
			header.append (version_number)
			header.append ("</XMI.exporterVersion>%N%
				%    </XMI.documentation>%N%
				%    <XMI.metamodel xmi.name = 'UML' xmi.version = '1.1'/>%N%
				%  </XMI.header>%N")
	
			content_end := "       </Foundation.Core.Namespace.ownedElement>%N%
	    		%</Model_Management.Model>  %N%
			    %</XMI.content>%N"
	
			file_end := "</XMI>%N"
	
			extensions_start := "<XMI.extensions xmi.extender = '"
			extensions_start.append (workbench_name)
			extensions_start.append ("'>%N")
	
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
				%      <XMI.extension xmi.extender = '"
			Result.append (workbench_name)
			Result.append ("'>%N%
				%        <XMI.reference xmi.idref = 'G.")
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

	extensions_end: STRING;
			-- Code of the end of the XMI file extensions.

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class XMI_CODE
