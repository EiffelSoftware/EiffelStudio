<%@ Assembly Name="registrationservice" %>
<%@ Import Namespace="RegistrationService" %>
<%@ Page Language="C#" %>

<HTML>
	<HEAD>
		<META HTTP-EQUIV="Content-TyPe" CONTENT="text/html; charset=windows-1252">
		<TITLE>Eiffel# Demo</TITLE>
		<LINK REL="stylesheet" TYPE="text/css" HREF="usa.css">
		<LINK HREF="http://www.eiffel.com/images/interface/eiffel_purple.ico" REL="SHORTCUT ICON">
		<SCRIPT RUNAT="SERVER">

			bool registered, register_click;
			String error_message;
			Registrar registrar;
			
			void Page_Init( Object Source, EventArgs E )
			{
				registrar = new Registrar();
				registrar.start();
				Application ["Registrar"] = registrar;
				registered = false;
				register_click = false;
			}
			
			void Register_Click( Object Source, EventArgs E )
			{
				register_click = true;
				
				// Add registrant
				registrar.add_registrant( address_form.SelectedItem.Value,
									first_name.Value,
									last_name.Value,
									company_name.Value,
									address.Value,
									city.Value,
									state.Value,
									zip.Value,
									country.Value );
				
				if( registrar.last_operation_successful())
				{
					// Add registration
					registrar.add_registration( registrar.last_registrant_identifier(),
										quantity.Value,
										discount_plan.SelectedItem.Value,
										( preconf.Checked ),
										( wet.Checked ),
										( conference.Checked ),
										( esummit.Checked ),
										( postconf.Checked ));
				}
				
				registered = registrar.last_operation_successful();
				error_message = registrar.last_error_message();
				
				if( registered )
					Navigate( "Done.aspx" );
			}

		</SCRIPT>
	</HEAD>
	<BODY CELLSPACING="0" CELLPADDING="0" TOPMARGIN="0" LEFTMARGIN="0">
		<TABLE BORDER="0" WIDTH="100%" CELLSPACING="0" CELLPADDING="0">
			<TR>
				<TD WIDTH="17%" VALIGN="TOP" BGCOLOR="#006633">
					<TABLE BORDER="4" WIDTH="37%" VALIGN="TOP" BGCOLOR="#006633" CELLSPACING="0" CELLPADDING="0" BORDERCOLOR="#006633">
						<TR>
							<TD WIDTH="100%" BGCOLOR="#006633" HEIGHT="20">
								<P ALIGN="CENTER"><A HREF="http://www.tools-conferences.com"><IMG SRC="images/tools2000logo.jpg" BORDER="0" ALT="TOOLS Conferences home" ALIGN="LEFT" WIDTH="130" HEIGHT="70"></A>
								</P>
							</TD>
						</TR>
						<TR>
							<TD WIDTH="100%" BGCOLOR="#006633" HEIGHT="20"></TD>
						</TR>
						<TR>
							<TD WIDTH="100%" BGCOLOR="#006633" HEIGHT="20">
								<A CLASS="LEFTREF" HREF="http://www.tools-conferences.com/usa">TOOLS USA Home</A>
							</TD>
						</TR>
						<TR>
							<TD WIDTH="100%" BGCOLOR="#006633" HEIGHT="20">&nbsp;</TD>
						</TR>
						<TR>
							<TD WIDTH="100%" BGCOLOR="#006633" HEIGHT="20"><A CLASS="LEFTREF" HREF="http://www.tools-conferences.com/usa/calls/committee.html">Comittee</A></TD>
						</TR>
						<TR>
							<TD WIDTH="100%" BGCOLOR="#006633" HEIGHT="20"><A CLASS="LEFTREF" HREF="http://www.tools-conferences.com/usa/program/keynotes.html">Keynotes</A></TD>
						</TR>
						<TR>
							<TD WIDTH="100%" BGCOLOR="#006633" HEIGHT="20"><A CLASS="LEFTREF" HREF="http://www.tools-conferences.com/usa/program/tutorials.html">Tutorials</A></TD>
						</TR>
						<TR>
							<TD WIDTH="100%" BGCOLOR="#006633" HEIGHT="20"><A CLASS="LEFTREF" HREF="http://www.tools-conferences.com/usa/program/intro_ot.html">Intro to OT</A></TD>
						</TR>
						<TR>
							<TD WIDTH="100%" BGCOLOR="#006633" HEIGHT="20"><A CLASS="LEFTREF" HREF="http://www.tools-conferences.com/usa/program/papers.html">Papers</A></TD>
						</TR>
						<TR>
							<TD WIDTH="100%" BGCOLOR="#006633" HEIGHT="20"><A CLASS="LEFTREF" HREF="http://www.tools-conferences.com/usa/program/schedule.html">Schedule</A></TD>
						</TR>
						<TR>
							<TD WIDTH="100%" BGCOLOR="#006633" HEIGHT="20"><A CLASS="LEFTREF" HREF="http://www.tools-conferences.com/usa/program/wet.html">WET</A></TD>
						</TR>
						<TR>
							<TD WIDTH="100%" BGCOLOR="#006633" HEIGHT="20"><A CLASS="LEFTREF" HREF="http://www.tools-conferences.com/usa/program/eiffel_summit/index.html">Eiffel Summit</A></TD>
						</TR>
						<TR>
							<TD WIDTH="100%" BGCOLOR="#006633" HEIGHT="20">&nbsp;</TD>
						</TR>
						<TR>
							<TD WIDTH="100%" BGCOLOR="#006633" HEIGHT="20"><A CLASS="LEFTREF" HREF="http://www.tools-conferences.com/usa/calls/exhibit.html">Exhibit at TOOLS</A></TD>
						</TR>
						<TR>
							<TD WIDTH="100%" BGCOLOR="#006633" HEIGHT="20"><A CLASS="LEFTREF" HREF="http://www.tools-conferences.com/usa/program/sponsors.html">Sponsors</A></TD>
						</TR>
						<TR>
							<TD WIDTH="100%" BGCOLOR="#006633" HEIGHT="20"><A CLASS="LEFTREF" HREF="http://www.tools-conferences.com/tools/usa/registration/index.html">Registration</A></TD>
						</TR>
						<TR>
							<TD WIDTH="100%" BGCOLOR="#006633" HEIGHT="20">&nbsp;</TD>
						</TR>
						<TR>
							<TD WIDTH="100%" BGCOLOR="#006633" HEIGHT="20"><A CLASS="LEFTREF" HREF="http://www.tools-conferences.com/usa/program/sb.html">About Santa-Barbara</A></TD>
						</TR>
						<TR>
							<TD WIDTH="100%" BGCOLOR="#006633" HEIGHT="20">&nbsp;</TD>
						</TR>
						<TR>
							<TD WIDTH="100%" BGCOLOR="#006633" HEIGHT="20"><A CLASS="LEFTREF" HREF="http://www.tools-conferences.com/usa/program/contact.html">Contact TOOLS!</A></TD>
						</TR>
						<TR>
							<TD WIDTH="100%" BGCOLOR="#006633">&nbsp;</TD>
						</TR>
						<TR>
							<TD WIDTH="100%" BGCOLOR="#006633"  VALIGN="BOTTOM">
								<CENTER>
									<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="100%" HEIGHT="160">
										<TR>
											<TD WIDTH="100%" VALIGN="BOTTOM"><IMG BORDER="0" SRC="images/photo_pool.jpg" WIDTH="172" HEIGHT="138" align="BOTTOM"></TD>
										</TR>
									</TABLE>
								</CENTER>
							</TD>
						</TR>
					</TABLE>
				</TD>
				<TD WIDTH="83%" VALIGN="TOP">
					<TABLE BORDER="0" WIDTH="100%" CELLSPACING="0" CELLPADDING="0">
						<TR HEIGHT="29">
							<TD WIDTH="100%">
				                                <TABLE BORDER="0" WIDTH="100%" CELLSPACING="0" CELLPADDING="0">
									<TR HEIGHT=29>
										<TD WIDTH="6%" BGCOLOR="#006633" HEIGHT="29"></TD>
										<TD WIDTH="88%" BGCOLOR="#006633" HEIGHT="29" VALIGN=MIDDLE ALIGN=CENTER>
											<FONT FACE="Verdana, Arial, Helvetica" COLOR=#FFFFF><B>
												TOOLS USA 2000 - <I>Software Serving Society</I></B>
											</FONT>
										</TD>
									</TR>
								</TABLE>
							</TD>
						</TR>
						<TR HEIGHT = "36">
							<TD WIDTH="100%">
								<DIV ALIGN="CENTER">
									<TABLE BORDER="0" WIDTH="100%" CELLPADDING="0" CELLSPACING="0">
										<TR>
											<TD WIDTH="100%">
												<P ALIGN="CENTER"><FONT SIZE="5" COLOR="#006633">(Demo) Registration Form for TOOLS USA 2000</FONT>
													<UL>
														<UL>
															<SMALL><B>Note</B>: This is a demo only and will <I>not</I> register you.
																To register for TOOLS USA, the event of the year in advanced technology,
																"Beach meets Bytes" in Santa Barbara (July 30-August 4),
																go to the real
																<A HREF="http://www.tools-conferences.com/usa/registration">TOOLS USA 2000 registration page</A>.
															</SMALL>
														</UL>
													</UL>
												</P>
											</TD>
										</TR>
									</TABLE>
								</DIV>
							</TD>
						</TR>
						<FORM RUNAT="SERVER">
							<TR VALIGN="BOTTOM">
								<TD WIDTH="100%" ALIGN="RIGHT" VALIGN="BOTTOM">
									<TABLE BORDER="0" WIDTH="99%" CELLSPACING="0" CELLPADDING="0" HEIGHT="90%" VALIGN="BOTTOM">
										<TR>
											<TD BGCOLOR="#FFFFCC">
												<H6 CLASS="register"><FONT COLOR="#FF0000">*</FONT>Title</H6>
											</TD>
											<TD BGCOLOR="#FFFFCC">
												<ASP:DropDownList ID="address_form" RUNAT="SERVER">
													<ASP:ListItem>Mr.</ASP:ListItem>
													<ASP:ListItem>Ms.</ASP:ListItem>
													<ASP:ListItem>Miss</ASP:ListItem>
													<ASP:ListItem>Mrs.</ASP:ListItem>
													<ASP:ListItem>Dr.</ASP:ListItem>
												</ASP:DropDownList>
											</TD>
										</TR>
										<TR>
											<TD BGCOLOR="#FFFFCC">
												<H6 CLASS="register"><FONT COLOR="#FF0000">*</FONT>First Name:</H6>
											</TD>
											<TD BGCOLOR="#FFFFCC"><INPUT ID="first_name" SIZE="35" TYPE="TEXT" RUNAT="SERVER">
											</TD>
										</TR>
										<TR>
											<TD BGCOLOR="#FFFFCC">
												<H6 CLASS="register"><FONT COLOR="#FF0000">*</FONT>Last Name:</H6>
											</TD>
											<TD BGCOLOR="#FFFFCC"><INPUT ID="last_name" SIZE="35" TYPE="TEXT" RUNAT="SERVER">
											</TD>
										</TR>
										<TR>
											<TD BGCOLOR="#FFFFCC">
												<H6 CLASS="register">Company Name:</H6>
											</TD>
											<TD BGCOLOR="#FFFFCC"><INPUT ID="company_name" SIZE="50" TYPE="TEXT" RUNAT="SERVER">
											</TD>
										</TR>
										<TR>
											<TD BGCOLOR="#FFFFCC">
												<H6 CLASS="register"><FONT COLOR="#FF0000">*</FONT>Address:</H6>
											</TD>
											<TD BGCOLOR="#FFFFCC"><INPUT ID="address" SIZE="50" TYPE="TEXT" RUNAT="SERVER">
											</TD>
										</TR>
										<TR>
											<TD BGCOLOR="#FFFFCC">
												<H6 CLASS="register"><FONT COLOR="#FF0000">*</FONT>City:</H6>
											</TD>
											<TD BGCOLOR="#FFFFCC"><INPUT ID="city" SIZE="50" TYPE="TEXT" RUNAT="SERVER">
											</TD>
										</TR>
										<TR>
											<TD BGCOLOR="#FFFFCC">
												<H6 CLASS="register"><FONT COLOR="#FF0000">*</FONT>State:</H6>
											</TD>
											<TD BGCOLOR="#FFFFCC"><INPUT ID="state" SIZE="10" TYPE="TEXT" RUNAT="SERVER">
											</TD>
										</TR>
										<TR>
											<TD BGCOLOR="#FFFFCC">
												<H6 CLASS="register"><FONT COLOR="#FF0000">*</FONT>Zip Code:</H6>
											</TD>
											<TD BGCOLOR="#FFFFCC"><INPUT ID="zip" SIZE="10" TYPE="TEXT" RUNAT="SERVER">
											</TD>
										</TR>
										<TR>
											<TD BGCOLOR="#FFFFCC">
												<H6 CLASS="register"><FONT COLOR="#FF0000">*</FONT>Country:</H6>
											</TD>
											<TD BGCOLOR="#FFFFCC"><INPUT ID="country" SIZE="10" VALUE="USA" TYPE="TEXT" RUNAT="SERVER">
											</TD>
										</TR>
										<TR>
											<TD ALIGN="CENTER" BGCOLOR="#FFFFCC">
												<H6 CLASS="register" ALIGN="LEFT"><FONT COLOR="#FF0000">*</FONT>Number of participants:</H6>
											</TD>
											<TD BGCOLOR="#FFFFCC" >
												<INPUT VALUE="1" SIZE="3" ID="quantity" TYPE="TEXT" RUNAT="SERVER">
											</TD>
										</TR>
										<TR>
											<TD ALIGN="LEFT" BGCOLOR="#FFFFCC">
												<H6 CLASS="register"><FONT COLOR="#FF0000">*</FONT>Registering as:</H6>
											</TD>
											<TD BGCOLOR="#FFFFCC">
												<ASP:DropDownList ID="discount_plan" RUNAT="SERVER">
													<ASP:ListItem>Regular</ASP:ListItem>
													<ASP:ListItem>Non-academic Authors</ASP:ListItem>
													<ASP:ListItem>Full-Time Students</ASP:ListItem>
													<ASP:ListItem>Full-Time Faculty Members</ASP:ListItem>
												</ASP:DropDownList>
											</TD>
										</TR>
										<TR>
											<TD ALIGN="CENTER" VALIGN="TOP" BGCOLOR="#FFFFCC">
												<H6 CLASS="register" ALIGN="LEFT"><FONT COLOR="#FF0000">*</FONT>I am registering for:</H6>
											</TD>
											<TD BGCOLOR="#FFFFCC">
												<INPUT TYPE="CHECKBOX" ID="preconf" RUNAT="SERVER">
												<FONT COLOR="#000080">Pre-Conference, July 30</FONT>
												<P>
													<INPUT TYPE="CHECKBOX" ID="wet" RUNAT="SERVER">
													<FONT COLOR="#000080">WET, July 30</FONT>
												</P>
												<P>
													<INPUT TYPE="CHECKBOX" ID="conference" RUNAT="SERVER">
													<FONT COLOR="#000080">Conference, July 31 - August 3</FONT>
												</P>
												<P>
													<INPUT TYPE="CHECKBOX" ID="esummit"  RUNAT="SERVER">
													<FONT COLOR="#000080">Eiffel Summit, August 1</FONT>
												</P>
												<P>
													<INPUT TYPE="CHECKBOX" ID="postconf" RUNAT="SERVER">
													<FONT COLOR="#000080">Post-Conference, August 4</FONT>
												</P>
											</TD>
										</TR>
									</TABLE>
								</TD>
							</TR>
						</TABLE>
						<TABLE WIDTH="99%" BORDER="0" CELLPADDING="0" CELLSPACING="0" align="right" HEIGHT="35">
							<TR>
								<TD WIDTH="100%" BGCOLOR="#FFFFCC" ALIGN="CENTER" VALIGN="BOTTOM">
									<ASP:Button ID="Register" TEXT="Register" OnClick="Register_Click" RUNAT="SERVER" />
								</TD>
							</TR>
							<%if( register_click&&!registered ) {%>
							<TR>
								<TD>
									<BR><FONT COLOR="RED">The following error occured</FONT>: <%=error_message%><BR><BR>
								</TD>
							</TR>
							<% } %>
							<TR>
								<TD>
									Back to:
									<BR>&nbsp;&nbsp;&nbsp;- <A HREF="http://www.eiffel.com/doc/manuals/technology/dotnet/eiffelsharp/demo.html">Demo description page</A>.
									<BR>&nbsp;&nbsp;&nbsp;- <A HREF="http://www.eiffel.com/doc/manuals/technology/dotnet/eiffelsharp/">Eiffel# page</A>.
									<BR>&nbsp;&nbsp;&nbsp;- <A HREF="http://www.eiffel.com">Eiffel home page</A>.
								</TD>
							</TR>
						</TABLE>
					</FORM>
				</TD>
			</TR>
		</TABLE>
	</BODY>
</HTML>
