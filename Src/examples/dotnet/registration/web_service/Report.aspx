<%@ Assembly Name="registrationservice" %>
<%@ Import Namespace="RegistrationService" %>
<%@ Import Namespace="System.Data" %>
<%@ Page Language="C#" %>

<HTML>
	<HEAD>
		<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
		<META HTTP-EQUIV=REFRESH CONTENT="5">
		<TITLE>TOOLS USA 2000</TITLE>
		<LINK REL="stylesheet" TYPE="text/css" HREF="usa.css">
		<SCRIPT RUNAT="SERVER">
			
			void Page_Load( Object Source, EventArgs E )
			{
				Registrar registrar;
				Object[] registrants, registrations;
				Registrant registrant;
				Registration registration;
				DataTable RegistrantDataTable, RegistrationDataTable;
				DataRow RegistrantDataRow, RegistrationDataRow;
				
				registrar =( Registrar )Application ["Registrar"];
				if( registrar != null )
				{
					if( registrar.last_operation_successful())
					{
						// Create registrant table
						RegistrantDataTable = new DataTable( "Registrants" );
						RegistrantDataTable.Columns.Add( new DataColumn( "Identifier", typeof( String )));
						RegistrantDataTable.Columns.Add( new DataColumn( "Address Form", typeof( String )));
						RegistrantDataTable.Columns.Add( new DataColumn( "First Name", typeof( String )));
						RegistrantDataTable.Columns.Add( new DataColumn( "Last Name", typeof( String )));
						RegistrantDataTable.Columns.Add( new DataColumn( "Company Name", typeof( String )));
						RegistrantDataTable.Columns.Add( new DataColumn( "Address", typeof( String )));

						//Update registrant table
						registrants = registrar.registrants_database().items();
						for( int i = 0; i < registrants.Length; i++ )
						{
							registrant =( Registrant )registrants [i];
							RegistrantDataRow = RegistrantDataTable.NewRow();
							RegistrantDataRow ["Identifier"] = registrant.identifier;
							RegistrantDataRow ["Address Form"] = registrant.address_form;
							RegistrantDataRow ["First Name"] = registrant.first_name;
							RegistrantDataRow ["Last Name"] = registrant.last_name;
							RegistrantDataRow ["Company Name"] = registrant.company_name;
							RegistrantDataRow ["Address"] = registrant.address;					
							RegistrantDataTable.Rows.Add( RegistrantDataRow );
						}

						// Update registrant DataGrid
						RegistrantDataGrid.DataSource = RegistrantDataTable.DefaultView;
						RegistrantDataGrid.DataBind();

						// Create registration table
						RegistrationDataTable = new DataTable( "Registrations" );
						RegistrationDataTable.Columns.Add( new DataColumn( "Identifier", typeof( String )));
						RegistrationDataTable.Columns.Add( new DataColumn( "Registrant Identifier", typeof( String )));
						RegistrationDataTable.Columns.Add( new DataColumn( "Quantity", typeof( int )));
						RegistrationDataTable.Columns.Add( new DataColumn( "Discount Plan", typeof( String )));
						RegistrationDataTable.Columns.Add( new DataColumn( "Pre-Conference", typeof( bool )));
						RegistrationDataTable.Columns.Add( new DataColumn( "WET", typeof( bool )));
						RegistrationDataTable.Columns.Add( new DataColumn( "Conference", typeof( bool )));
						RegistrationDataTable.Columns.Add( new DataColumn( "Eiffel Summit", typeof( bool )));
						RegistrationDataTable.Columns.Add( new DataColumn( "Post-Conference", typeof( bool )));

						//Update registration table
						registrations = registrar.registrations_database().items();
						for( int i = 0; i < registrations.Length; i++ )
						{
							registration =( Registration )registrations [i];
							RegistrationDataRow = RegistrationDataTable.NewRow();
							RegistrationDataRow ["Identifier"] = registration.identifier;
							RegistrationDataRow ["Registrant Identifier"] = registration.registrant_id;
							RegistrationDataRow ["Quantity"] = registration.quantity;
							RegistrationDataRow ["Discount Plan"] = registration.discount_plan;
							RegistrationDataRow ["Pre-Conference"] = registration.preconf;
							RegistrationDataRow ["WET"] = registration.wet;
							RegistrationDataRow ["Conference"] = registration.conference;					
							RegistrationDataRow ["Eiffel Summit"] = registration.esummit;					
							RegistrationDataRow ["Post-Conference"] = registration.postconf;					
							RegistrationDataTable.Rows.Add( RegistrationDataRow );
						}

						// Update registration DataGrid
						RegistrationDataGrid.DataSource = RegistrationDataTable.DefaultView;
						RegistrationDataGrid.DataBind();
					}
				}
			}
		</SCRIPT>
	</HEAD>
	<BODY CELLSPACING="0" CELLPADDING="0" TOPMARGIN="0" LEFTMARGIN="0" BGCOLOR="#FFFFCC">
	<BR>
	<CENTER>
		<A HREF="Report.aspx">Registrants Table </A>
	</CENTER>
	<BR><BR>
	<ASP:DataGrid ID="RegistrantDataGrid" RUNAT="SERVER"
		Align="CENTER"
		Width="1000"
		BorderWidth="5"
		BackColor="#FFFFCC" 
		BorderColor="#006633"
		ShowFooter="FALSE" 
		CellPadding=5 
		CellSpacing="1"
		Font-Name="VERDANA"
		Font-Size="8pt"
		HeaderStyle-BackColor="#EEEEBB"
		MaintainState="FALSE"
	/>
	<BR><BR><BR>
	<CENTER>
		<A HREF="Report.aspx">Registrations Table </A>
	</CENTER>
	<BR><BR>
	<ASP:DataGrid ID="RegistrationDataGrid" RUNAT="SERVER"
		Align="CENTER"
		Width="1000"
		BorderWidth="5"
		BackColor="#FFFFCC" 
		BorderColor="#006633"
		ShowFooter="FALSE" 
		CellPadding=5 
		CellSpacing="1"
		Font-Name="VERDANA"
		Font-Size="8pt"
		HeaderStyle-BackColor="#EEEEBB"
		MaintainState="FALSE"
	/>
	<BR><BR>
	<CENTER>
		<A HREF="Registration.aspx">Back to registration page</A>
	</CENTER>
	</BODY>
</HTML>
